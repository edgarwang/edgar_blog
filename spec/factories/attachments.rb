FactoryGirl.define do
  factory :attachment do
    file File.open('spec/files/test.png')
  end
end
