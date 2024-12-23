class PetSerializer < ActiveModel::Serializer
  attributes :id, :pet_type, :tracker_type, :owner_id, :in_zone, :lost_tracker
end
