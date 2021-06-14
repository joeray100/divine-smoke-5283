require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plot_plants).through(:plots) }
    it { should have_many(:plants).through(:plot_plants) }
  end

  before :each do
    @garden1 = Garden.create!(name: "Turing Community Garden", organic: true)
    @plot1 = @garden1.plots.create!(number: 25, size: "Large", direction: "East")
    @plant1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
    @plant2 = Plant.create!(name: "Watermelon", description: "Prefers rich, swampy soil.", days_to_harvest: 50)
    @plant3 = Plant.create!(name: "Carrots", description: "Prefers dry soil.", days_to_harvest: 150)

    @plot2 = @garden1.plots.create!(number: 40, size: "Medium", direction: "South")
    @plant4 = Plant.create!(name: "Onions", description: "Prefers mild conditions", days_to_harvest: 50)

    @plot1.plants.push(@plant1, @plant2, @plant3, @plant1)
    @plot2.plants.push(@plant4)
  end

  describe 'instance methods' do
    describe '#garden_plants' do
      it "It returns plants that belong to this garden, is unique, and take less than 100 days to harvest." do
        expect(@garden1.garden_plants).to eq([@plant1, @plant2, @plant4])

        # plant 3 is over 100 days_to_harvest
        expect(@garden1.garden_plants).to_not eq([@plant1, @plant2, @plant3])
        # plant 3 is over 100 days_to_harvest & plant 1 is in list twice
        expect(@garden1.garden_plants).to_not eq([@plant1, @plant2, @plant3, @plant1, @plant4])
      end
    end
  end

  # describe 'class methods' do
  #   describe '.' do
  #   end
  # end
  #
end
