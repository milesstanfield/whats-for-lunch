require 'spec_helper'

describe RestaurantsController, type: :controller do
  describe '#new' do
    it 'renders the new template' do
      restaurant = double(:restaurant)
      expect(Restaurant).to receive(:new).and_return(restaurant)
      get :new
      expect(response).to render_template :new
      expect(assigns(:restaurant)).to eq restaurant
    end
  end

  describe '#index' do
    it 'renders the index template' do
      restaurants = double(:restaurants)
      expect(Restaurant).to receive(:all).and_return(restaurants)
      get :index
      expect(response).to render_template :index
      expect(assigns(:restaurants)).to eq restaurants
    end
  end

  describe '#show' do
    it 'renders the show template' do
      params = {id: '123'}
      restaurant = double(:restaurant)
      expect(Restaurant).to receive(:find).with(params[:id]).and_return(restaurant)
      get :show, params
      expect(response).to render_template :show
      expect(assigns(:restaurant)).to eq restaurant
    end
  end

  describe '#create' do
    context 'on successfully creating restaurant' do
      it 'redirects to index' do
        params = {restaurant: {name: 'Chick-fil-a'}}
        restaurant = Restaurant.new(params[:restaurant])
        expect(Restaurant).to receive(:new).with(params[:restaurant]).and_return(restaurant)
        expect(restaurant).to receive(:save).and_return(true)
        post :create, params
        expect(response).to redirect_to '/restaurants'
        expect(session[:flash]['flashes']).to eq({'message'=>'Restaurant successfully created!'})
        expect(assigns(:restaurant)).to eq restaurant
      end
    end

    context 'on unsuccessfully creating restaurant' do
      it 'rerenders the new template' do
        params = {restaurant: {name: nil}}
        restaurant = Restaurant.new(params[:restaurant])
        expect(Restaurant).to receive(:new).with(params[:restaurant]).and_return(restaurant)
        expect(restaurant).to receive(:save).and_return(false)
        post :create, params
        expect(response).to render_template :new
        expect(assigns(:restaurant)).to eq restaurant
      end
    end
  end

  describe '#destroy' do
    context 'on successfully destroying restaurant' do
      it 'redirects to index' do
        params = {id: '123'}
        restaurant = Restaurant.new(params[:restaurant])
        expect(Restaurant).to receive(:find).with(params[:id]).and_return(restaurant)
        expect(restaurant).to receive(:destroy).and_return(true)
        delete :destroy, params
        expect(response).to redirect_to '/restaurants'
        expect(session[:flash]['flashes']).to eq({'message'=>'Restaurant successfully deleted!'})
        expect(assigns(:restaurant)).to eq restaurant
      end
    end

    context 'on unsuccessful destroying restaurant' do
      it 'renders the index template' do
        params = {id: '123'}
        restaurant = Restaurant.new({id: '456'})
        expect(Restaurant).to receive(:find).with(params[:id]).and_return(restaurant)
        expect(restaurant).to receive(:destroy).and_return(false)
        delete :destroy, params
        expect(response).to render_template :index
        expect(assigns(:restaurant)).to eq restaurant
      end
    end
  end
end
