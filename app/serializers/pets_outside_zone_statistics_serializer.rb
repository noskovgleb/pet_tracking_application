class PetsOutsideZoneStatisticsSerializer < ActiveModel::Serializer
  attribute :pets_outside_zone

  def initialize(pets_outside_zone)
    @pets_outside_zone = pets_outside_zone
  end

  def pets_outside_zone
    result = {}
    @pets_outside_zone.each do |key, value|
      array_key = key.join(' ')
      result[array_key] = value
    end
    result
  end
end


# {"pets_outside_zone":{["Cat", "small"]":1, ["Dog", "small"]: 1}}
#