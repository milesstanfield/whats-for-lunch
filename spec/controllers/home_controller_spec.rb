require 'spec_helper'

describe HomeController, type: :controller do
  describe '#index' do
    it 'renders the index template' do
      restaurants = double(:restaurants)
      recommendations = double(:recommendations)
      expect(Restaurant).to receive(:limit).with(100).and_return(restaurants)
      expect(restaurants).to receive(:recommended).and_return(recommendations)
      get :index
      expect(response).to render_template :index
      expect(assigns(:recommendations)).to eq recommendations
      expect(assigns(:body_color_class)).to eq 'm-bg-default'
    end
  end
end
