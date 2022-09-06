# frozen_string_literal: true

require_relative '../file_parser'
require 'pry'
RSpec.describe FileParser do
  logfile_path = 'spec/fixtures/webserver.log'
  subject { described_class.new(logfile_path) }

  describe '#initialize' do
    context 'when argument is not passed' do
      it 'should raise an error' do
        expect { described_class.new }
          .to raise_error(ArgumentError)
      end
    end

    context 'when the provided file is not found' do
      it 'should raise an error' do
        expect { described_class.new('spec/fixtures/webservder.log') }
          .to raise_error(RuntimeError, 'File doesn\'t exsit')
      end
    end
  end

  describe '#process_file' do
    before { subject.process_file }

    let(:expected_results) do
      { '/about/2' => ['836.973.694.103'],
        '/home' => ['297.280.786.156', '715.456.286.412'],
        '/index' => ['647.601.489.106', '447.753.468.107'],
        '/contact' => ['584.123.765.007'],
        '/about' => ['166.318.035.038'] }
    end

    it 'should process file' do
      expect(subject.records).to eq(expected_results)
    end
  end

  describe '#most_page_views' do
    before { subject.process_file }

    let(:expected_results) do
      { '/home' => 2, '/index' => 2, '/about/2' => 1, '/contact' => 1, '/about' => 1 }
    end

    it 'should returns the most page views' do
      expect(subject.most_page_views).to eq(expected_results)
    end
  end

  describe '#unique_page_views' do
    before { subject.process_file }

    let(:expected_results) do
      { '/home' => 2, '/index' => 2, '/about/2' => 1, '/contact' => 1, '/about' => 1 }
    end

    it 'should returns the unique page views' do
      expect(subject.unique_page_views).to eq(expected_results)
    end
  end
end
