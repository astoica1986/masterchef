require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it "is valid with valid attributes" do
    expect(build(:recipe)).to be_valid
  end

  it "is is not valid with a missing name" do
    expect(build(:recipe, name: nil)).to be_invalid
  end
end
