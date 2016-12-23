require 'spec_helper'

describe 'core_ext' do
  subject { Fv('1.2.3') }
  it { is_expected.to be_instance_of(Fv::V) }
end
