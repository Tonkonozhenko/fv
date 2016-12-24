require 'spec_helper'

describe Fv::V do
  let(:parts) { [1, 2, 3] }
  subject { Fv::V.new(*parts) }

  describe '.new' do
    it 'creates object' do
      expect { subject }.not_to raise_error
    end
  end

  describe 'properties' do
    shared_examples 'having property' do |prop|
      it { is_expected.to respond_to(prop) }
    end

    it_behaves_like 'having property', :major
    it_behaves_like 'having property', :minor
    it_behaves_like 'having property', :patch
    it_behaves_like 'having property', :parts

    it 'sets corresponding values' do
      expect(subject.major).to eq(1)
      expect(subject.minor).to eq(2)
      expect(subject.patch).to eq(3)
      expect(subject.parts).to eq([1, 2, 3])
    end
  end

  describe '#to_s' do
    subject { Fv::V.new(*parts).to_s }

    it { is_expected.to eq('1.2.3') }

    context 'with complex patch version' do
      let(:parts) { [1, 2, '0b2'] }

      it { is_expected.to eq('1.2.0b2') }
    end
  end

  describe '#prerelease?' do
    shared_examples 'being prerelease' do |v|
      it "treats #{v.inspect} as prerelease" do
        expect(Fv(v)).to be_prerelease
      end
    end

    it_behaves_like 'being prerelease', '1.2.0b2'
    it_behaves_like 'being prerelease', '1.2.0b2+some-metadata'

    context 'not prerelease' do
      it 'works' do
        expect(Fv('1.2.0')).not_to be_prerelease
      end
    end
  end

  describe 'behaviour' do
    it { is_expected.to be_kind_of(Comparable) }
  end

  describe '#<=>' do
    shared_examples 'comparing' do |l: nil, r: nil, result: nil|
      subject do
        x = Fv(l) <=> Fv(r)
        x.itself
      end
      it "#{l.inspect} and #{r.inspect}" do
        is_expected.to eq(result)
      end
    end

    it_behaves_like 'comparing', l: '1.9.0', r: '1.10.0', result: -1
    it_behaves_like 'comparing', l: '1.10.0', r: '1.11.0', result: -1
    it_behaves_like 'comparing', l: '1.9.0', r: '1.11.0', result: -1
    it_behaves_like 'comparing', l: '1.2.3', r: '1.2.3', result: 0
    it_behaves_like 'comparing', l: '1.2.3', r: '0.2.3', result: 1
    it_behaves_like 'comparing', l: '1.0.0', r: '1.0.0-pre', result: 1

    it 'compares version and string' do
      expect(Fv('1.2.3') <=> '1.2.4').to eq(-1)
    end
  end
end
