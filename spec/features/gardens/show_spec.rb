require 'rails_helper'

RSpec.describe 'Garden Show Page' do
  before :each do
    @garden1 = Garden.create!(name: "Turing Community Garden", organic: true)
    @plot1 = @garden1.plots.create!(number: 25, size: "Large", direction: "East")
    @plant1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
    @plant2 = Plant.create!(name: "Watermelon", description: "Prefers rich, swampy soil.", days_to_harvest: 50)
    @plant3 = Plant.create!(name: "Carrots", description: "Prefers dry soil.", days_to_harvest: 150)

    @plot2 = @garden1.plots.create!(number: 40, size: "Medium", direction: "South")
    @plant4 = Plant.create!(name: "Watermelon", description: "Prefers rich soil and wet weather.", days_to_harvest: 50)

    @plot1.plants.push(@plant1, @plant2, @plant3)
    @plot2.plants.push(@plant4)

    visit garden_path(@garden1)
  end

  it "I see a list of plants that are included in that garden's plots" do
    expect(current_path).to eq(garden_path(@garden1))
    expect(page).to have_content(@garden1.name)

    within "#gardens-plant-#{@plant1.id}" do
      expect(page).to have_content(@plant1.name)
    end

    within "#gardens-plant-#{@plant2.id}" do
      expect(page).to have_content(@plant2.name)
    end

    within "#gardens-plant-#{@plant4.id}" do
      expect(page).to have_content(@plant4.name)
    end

    expect(page).to_not have_content(@plant3.name)
  end
end
