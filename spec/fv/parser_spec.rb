require 'spec_helper'

describe Fv::Parser do
  describe '.parse' do
    subject { described_class.parse(version) }

    context 'valid args' do
      shared_examples 'parsing' do |input:, result:|
        let(:version) { input }
        specify "for input #{input.inspect} as #{result.inspect}" do
          expect(subject.parts).to eq(result)
        end
      end

      it_behaves_like 'parsing', input: '0.0.0', result: [0, 0, 0]
      it_behaves_like 'parsing', input: '1.2.3', result: [1, 2, 3]
      it_behaves_like 'parsing', input: '1.2.3+beta', result: [1, 2, 3]
      it_behaves_like 'parsing', input: '1.2.3+beta.1', result: [1, 2, 3]
      it_behaves_like 'parsing', input: '1.2.3-alpha.1', result: [1, 2, '3-alpha.1']
      it_behaves_like 'parsing', input: '1.2.0b2', result: [1, 2, '0b2']
    end

    context 'invalid args' do
      shared_examples 'raising error' do |input:, error:|
        let(:version) { input }
        specify "for input #{input.inspect}" do
          expect { subject }.to raise_error(error)
        end
      end

      it_behaves_like 'raising error', input: 'x', error: /major version must be integer/i
      it_behaves_like 'raising error', input: '1.x.0', error: /minor version must be integer/i
      it_behaves_like 'raising error', input: '-1.0.0', error: /major version cannot be negative/i
      it_behaves_like 'raising error', input: '1.-1.0', error: /minor version cannot be negative/i
      it_behaves_like 'raising error', input: '1.0.0!!!', error: /can contain only ASCII alphanumerics and hyphen/i
      it_behaves_like 'raising error', input: '1.0!!!.0', error: /minor version must be integer/i
    end
  end
end

