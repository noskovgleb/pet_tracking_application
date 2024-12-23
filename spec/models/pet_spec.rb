require 'rails_helper'

RSpec.describe Pet, type: :model do
  it "is valid with valid attributes" do
    pet = Pet.new(
      pet_type: 'Dog',
      tracker_type: 'small',
      owner_id: 1,
      in_zone: true
    )
    expect(pet).to be_valid
  end

  it "requires lost_tracker for cats" do
    pet = Pet.new(
      pet_type: 'Cat',
      tracker_type: 'small',
      owner_id: 1,
      in_zone: true
    )
    expect(pet).not_to be_valid
  end

  it "validates pet_type inclusion" do
    pet = Pet.new(
      pet_type: 'Bird',
      tracker_type: 'small',
      owner_id: 1,
      in_zone: true
    )
    expect(pet).not_to be_valid
  end
end