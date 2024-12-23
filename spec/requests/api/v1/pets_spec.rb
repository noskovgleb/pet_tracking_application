require 'rails_helper'

RSpec.describe "Api::V1::Pets", type: :request do
  describe "POST /api/v1/pets" do
    let(:valid_attributes) do
      {
        pet: {
          pet_type: 'Dog',
          tracker_type: 'small',
          owner_id: 1,
          in_zone: true
        }
      }
    end

    it 'creates a new pet' do
      expect {
        post api_v1_pets_path, params: valid_attributes
      }.to change { Pet.count }.by(1)
    end
  end

  describe "GET /api/v1/pets" do
    it "returns pets outside zone grouped by type and tracker" do
      Pet.create!(pet_type: 'Dog', tracker_type: 'small', owner_id: 1, in_zone: false)
      Pet.create!(pet_type: 'Cat', tracker_type: 'small', owner_id: 2, in_zone: false, lost_tracker: false)

      get "/api/v1/pets"

      expect(response).to have_http_status(:success)
      expect(json['data']['pets_outside_zone']).to include(
        'Dog small' => 1,
        'Cat small' => 1
      )
    end
  end
end