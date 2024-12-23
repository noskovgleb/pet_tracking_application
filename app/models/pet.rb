class Pet < ApplicationRecord
  validates :pet_type, presence: true, inclusion: { in: %w[Cat Dog] }
  validates :tracker_type, presence: true
  validates :owner_id, presence: true, numericality: { only_integer: true }
  validates :in_zone, inclusion: { in: [true, false] }
  
  # Additional attribute for Cat
  validates :lost_tracker, inclusion: { in: [true, false] }, if: :is_cat?
  
  private
  
  def is_cat?
    pet_type == 'Cat'
  end
end