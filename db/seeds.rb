Garden.destroy_all
Plot.destroy_all
Plant.destroy_all
PlotPlant.destroy_all

@garden1 = Garden.create!(name: "Turing Community Garden", organic: true)

@plot1 = @garden1.plots.create!(number: 25, size: "Large", direction: "East")
@plant1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
@plant2 = Plant.create!(name: "Watermelon", description: "Prefers rich, swampy soil.", days_to_harvest: 50)
@plant3 = Plant.create!(name: "Carrots", description: "Prefers dry soil.", days_to_harvest: 150)

@plot2 = @garden1.plots.create!(number: 40, size: "Medium", direction: "South")
@plant4 = Plant.create!(name: "Watermelon", description: "Prefers rich soil and wet weather.", days_to_harvest: 50)

@plot1.plants.push(@plant1, @plant2, @plant3)
@plot2.plants.push(@plant4)
