# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Documents', type: :request do
  include ActiveSupport::Testing::TimeHelpers

  let!(:org) { create :organization, subdomain: 'test' }
  let!(:user) { create :user, organization: org }
  let!(:repo) { create :repository, organization: org, user: }
  let!(:token) { create :api_token, repository: repo }

  before do
    host! 'test.example.com'
    sign_in user
  end

  describe 'POST /api/documents' do
    let(:documents_attrs) do
      [
        { path: 'docs/top-level.md', content: '# Top-level' },
        { path: 'docs/folder/page-one.md', content: '# Page 1' },
        { path: 'docs/folder/page-two.md', content: '# Page 2' }
      ]
    end

    let(:params) do
      {
        repository_id: repo.id,
        documents: documents_attrs
      }
    end

    let(:headers) do
      {
        Authorization: "Basic #{token.token}"
      }
    end

    it 'creates new documents' do
      expect { post '/api/documents', params:, headers: }
        .to change { Document.count }.from(0).to(4)

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq ''

      documents = org.documents.order(:path).all
      folder_doc = documents.find { _1.basename == 'folder' }

      expect(documents[0]).to have_attributes(
        path: 'folder',
        basename: 'folder',
        content: nil,
        parent_id: nil
      )

      expect(documents[1]).to have_attributes(
        path: 'folder/page-one.md',
        basename: 'page-one.md',
        content: '# Page 1',
        parent_id: folder_doc.id
      )

      expect(documents[2]).to have_attributes(
        path: 'folder/page-two.md',
        basename: 'page-two.md',
        content: '# Page 2',
        parent_id: folder_doc.id
      )

      expect(documents[3]).to have_attributes(
        path: 'top-level.md',
        basename: 'top-level.md',
        content: '# Top-level',
        parent_id: nil
      )
    end

    it 'updates token usage information' do
      freeze_time do
        expect { post '/api/documents', params:, headers: }
          .to change { token.reload.last_used_at }.from(nil).to(Time.current)
          .and change { token.usage_count }.from(0).to(1)
      end
    end

    context 'documents with the same path exist' do
      let!(:folder_doc) { create :document, organization: org, repository: repo, path: 'folder', content: nil }
      let!(:top_doc) { create :document, organization: org, repository: repo, path: 'top-level.md' }
      let!(:p1_doc) { create :document, organization: org, repository: repo, path: 'folder/page-one.md' }
      let!(:p2_doc) { create :document, organization: org, repository: repo, path: 'folder/page-two.md' }

      it 'updates the existing documents' do
        expect { post '/api/documents', params:, headers: }
          .not_to change { Document.count }.from(4)

        expect(response).to have_http_status(:ok)

        expect(folder_doc.reload).to have_attributes(
          path: 'folder',
          basename: 'folder',
          content: nil,
          parent_id: nil
        )

        expect(p1_doc.reload).to have_attributes(
          path: 'folder/page-one.md',
          basename: 'page-one.md',
          content: '# Page 1',
          parent_id: folder_doc.id
        )

        expect(p2_doc.reload).to have_attributes(
          path: 'folder/page-two.md',
          basename: 'page-two.md',
          content: '# Page 2',
          parent_id: folder_doc.id
        )

        expect(top_doc.reload).to have_attributes(
          path: 'top-level.md',
          basename: 'top-level.md',
          content: '# Top-level',
          parent_id: nil
        )
      end
    end

    context 'unauthenticated requests' do
      it 'disallows requests without a token' do
        expect { post '/api/documents', params: }.not_to change { Document.count }.from(0)
        expect(response).to have_http_status(:unauthorized)
      end

      it 'disallows requests with non-existant tokens' do
        headers = { Authorization: 'Basic invalid' }
        expect { post '/api/documents', params:, headers: }.not_to change { Document.count }.from(0)
        expect(response).to have_http_status(:unauthorized)
      end

      it 'disallows requests with tokens for different repositories' do
        headers = { Authorization: "Basic #{create(:api_token).token}" }
        expect { post '/api/documents', params:, headers: }.not_to change { Document.count }.from(0)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
