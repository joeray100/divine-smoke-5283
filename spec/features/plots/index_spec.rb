require 'rails_helper'

RSpec.describe 'Plot index Page' do
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

    visit plots_path
  end

  it "I see a list of all plot numbers." do
    expect(current_path).to eq(plots_path)

    within "#plot-#{@plot1.id}" do
      expect(page).to have_content(@plot1.number)
    end

    within "#plot-#{@plot2.id}" do
      expect(page).to have_content(@plot2.number)
    end
  end

  it "Under each plot number I see the names of all of that plot's plants." do
    expect(current_path).to eq(plots_path)

    within "#plant-#{@plant1.id}" do
      expect(page).to have_content(@plant1.name)
    end

    within "#plant-#{@plant2.id}" do
      expect(page).to have_content(@plant2.name)
    end

    within "#plant-#{@plant3.id}" do
      expect(page).to have_content(@plant3.name)
    end

    within "#plant-#{@plant4.id}" do
      expect(page).to have_content(@plant4.name)
    end
  end

  it "I see a link to remove that plant from that plot" do
    expect(current_path).to eq(plots_path)

    within "#plant-#{@plant1.id}" do
      expect(page).to have_link('Delete Plant')
    end

    within "#plant-#{@plant2.id}" do
      expect(page).to have_link('Delete Plant')
    end

    within "#plant-#{@plant3.id}" do
      expect(page).to have_link('Delete Plant')
    end

    within "#plant-#{@plant4.id}" do
      expect(page).to have_link('Delete Plant')
    end
  end

  it "I can delete a plant from a plot" do
    expect(current_path).to eq(plots_path)

    within "#plant-#{@plant1.id}" do
      expect(page).to have_content(@plant1.name)
      click_link 'Delete Plant'
    end

    expect(current_path).to eq(plots_path)
    expect(page).to_not have_content(@plant1.name)
    expect(page).to_not have_link('Delete Plant', count: 4)
  end
end
