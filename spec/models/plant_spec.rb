require 'rails_helper'

RSpec.describe Plant, type: :model do
  describe 'relationships' do
    it { should have_many(:plot_plants) }
    it { should have_many(:plants).through(:plot_plants) }
  end

  # before :each do
  #
  # end
  #
  # describe 'class methods' do
  #   describe '.' do
  #   end
  # end
  #
  # describe 'instance methods' do
  #   describe '#' do
  #   end
  # end
end
