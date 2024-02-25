# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Document, type: :model do
  describe '#file?' do
    it { is_expected.not_to be_file }

    context 'document has content' do
      subject { described_class.new content: 'hello' }

      it { is_expected.to be_file }
    end
  end

  describe '#render_content_toc' do
    subject { described_class.new content: '# Header' }

    it 'renders an HTML table of contents' do
      expect(subject.render_content_toc).to eq <<~TEXT
        <ul>
        <li>
        <a href="#header">Header</a>
        </li>
        </ul>
      TEXT
    end
  end

  describe '#render_content' do
    subject { described_class.new content: '# Header' }

    it 'renders HTML content' do
      expect(subject.render_content).to eq "<h1 id=\"header\">Header</h1>\n"
    end
  end
end
