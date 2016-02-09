require 'spec_helper'

describe User do
  subject(:user){ User.new }

  describe 'attributes' do
    it_has_attributes 'email', 'password'
  end

  describe 'associations' do
    it 'has many ratings' do
      expect(user.ratings).to eq []
    end
  end
end
