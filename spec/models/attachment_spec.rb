require 'spec_helper'

describe Attachment do
  it 'has a valid factory' do
    expect(build(:attachment)).to be_valid
  end

  it 'create an attachment' do
    expect(create(:attachment)).to be_valid
  end
end
