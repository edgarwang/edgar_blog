FactoryGirl.define do
  factory :article do
    title { Faker::Lorem.sentence(4) }
    slug 'a-test-article'
    content { Faker::Lorem.paragraph(5) }

    factory :published_article do
      status 'published'
    end

    factory :draft_article do
      status 'draft'
    end

    factory :trash_article do
      status 'trash'
    end
  end
end
