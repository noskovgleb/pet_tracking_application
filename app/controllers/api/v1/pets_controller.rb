module Api
  module V1
    class PetsController < Api::V1::BaseController
      def create
        @pet = Pet.new(pet_params)
        if @pet.save
          render_json(data: PetSerializer.new(@pet), status: :created)
        else
          render_json(data: @pet.errors, status: :unprocessable_entity)
        end
      end

      def index
        pets_outside_zone = Pet.where(in_zone: false)
                              .group(:pet_type, :tracker_type)
                              .count

        render_json(data: PetsOutsideZoneStatisticsSerializer.new(pets_outside_zone))
      end

      private

      def pet_params
        params.require(:pet).permit(:pet_type, :tracker_type, :owner_id, :in_zone, :lost_tracker)
      end
    end
  end
end