require 'spec_helper'

describe HomeController, type: :controller do
  describe '#index' do
    let(:params){ {day: '3'} }
    let(:restaurants){ double(:restaurants) }
    let(:recommendations){ double(:recommendations) }

    context 'with filter params' do
      it 'renders the index template' do
        expect(Restaurant).to receive(:limit).with(100).and_return(restaurants)
        expect(restaurants).to receive(:days_old).with('3').and_return(restaurants)
        expect(Recommendations).to receive(:fetch).with(restaurants).and_return(recommendations)
        get :index, params
        expect(response).to render_template :index
        expect(assigns(:recommendations)).to eq recommendations
        expect(assigns(:body_color_class)).to eq 'm-bg-default'
      end
    end

    context 'without filter params' do
      it 'renders the index template' do
        expect(Restaurant).to receive(:limit).with(100).and_return(restaurants)
        expect(Recommendations).to receive(:fetch).with(restaurants).and_return(recommendations)
        get :index
        expect(response).to render_template :index
        expect(assigns(:recommendations)).to eq recommendations
        expect(assigns(:body_color_class)).to eq 'm-bg-default'
      end
    end
  end
end
