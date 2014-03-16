FactoryGirl.define do
  factory :revision do
    hash_code 'foobarbaz'
    url 'http://example.com/'
    log 'commit from factory'
  end

  factory :other_revision do
    hash_code 'hoge'
    url 'http://example.com/'
    log 'other commit'
  end
end
