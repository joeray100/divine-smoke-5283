class Garden < ApplicationRecord
  has_many :plots, dependent: :destroy
  has_many :plot_plants, through: :plots
  has_many :plants, through: :plot_plants

  # def garden_plants
  #   plants
  #   .where('days_to_harvest < ?', 100)
  #   .distinct
  # end

  def garden_plants
    plants
    .where('days_to_harvest < ?', 100)
    .select('plants.id, plants.name')
    .group(:id)
    .order(id: :asc)
    .distinct
  end
end

# ran this first to make sure order was correct but you can't have distinct on hash from count so...
# plants.where('days_to_harvest < ?', 100).select('plants.id, plants.name').group(:id).order(id: :asc).sum(:all)

# this should be the correct AR method
# plants.where('days_to_harvest < ?', 100).select('plants.id, plants.name').group(:id).order(id: :asc).distinct
