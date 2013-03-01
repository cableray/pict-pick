require 'spec_helper'

describe "images/new" do
  before(:each) do
    assign(:image, stub_model(Image,
      :title => "MyString",
      :description => "MyText",
      :image => "",
      :ratings => ""
    ).as_new_record)
  end

  it "renders new image form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", images_path, "post" do
      assert_select "input#image_title[name=?]", "image[title]"
      assert_select "textarea#image_description[name=?]", "image[description]"
      assert_select "input#image_image[name=?]", "image[image]"
      assert_select "input#image_ratings[name=?]", "image[ratings]"
    end
  end
end
