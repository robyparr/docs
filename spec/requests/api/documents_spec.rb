# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Documents', type: :request do
  let!(:org) { create :organization, subdomain: 'test' }
  let!(:user) { create :user, organization: org }

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

    it 'creates new documents' do
      expect { post '/api/documents', params: { documents: documents_attrs } }
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

    context 'documents with the same path exist' do
      let!(:folder_doc) { create :document, organization: org, path: 'folder', content: nil }
      let!(:top_doc) { create :document, organization: org, path: 'top-level.md' }
      let!(:p1_doc) { create :document, organization: org, path: 'folder/page-one.md' }
      let!(:p2_doc) { create :document, organization: org, path: 'folder/page-two.md' }

      it 'updates the existing documents' do
        expect { post '/api/documents', params: { documents: documents_attrs } }
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
  end
end
