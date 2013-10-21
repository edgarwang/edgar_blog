require 'spec_helper'

describe User do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should have_secure_password }
  it 'should require case insensitive unique value for email' do
    create(:user, email: 'demo@example.com')
    user = build(:user, email: 'Demo@Example.com')
    expect(user).to have(1).errors_on(:email)
  end
end
