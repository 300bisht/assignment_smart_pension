# frozen_string_literal: true

require_relative '../print'

RSpec.describe Print do
  data = { visits: { '/about/2' => 90, '/contact' => 89, '/index' => 82 },
           unique_views: { '/help_page/1' => 23, '/contact' => 23, '/home' => 23 } }
  subject { described_class.new(data) }

  describe '#data' do
    let(:expected_result) do
      "<<Most page views<<\n /about/2 | 90 | visits\n /contact | 89 | visits\n /index | 82 | visits\n<<Unique page views<<\n /help_page/1 | 23 | unique_views\n /contact | 23 | unique_views\n /home | 23 | unique_views\n"
    end
    it 'should returns the most page views' do
      expect do
        subject.data
      end.to output(expected_result).to_stdout
    end
  end
end
