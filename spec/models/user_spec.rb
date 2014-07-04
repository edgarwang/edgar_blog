require 'spec_helper'

describe User do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should have_secure_password }
end
