# Read about factories at https://github.com/thoughtbot/factory_girl
include ActionDispatch::TestProcess
FactoryGirl.define do

  factory :image do
    title "Mona Lisa"
    description "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec feugiat rutrum orci vel mollis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas."
    image do
      fixture_file_upload(Rails.root.join('spec', 'image_fixtures', 'test.jpg'), 'image/jpeg')
    end
  end
end
