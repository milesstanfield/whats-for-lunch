require 'spec_helper'

describe RestaurantsController, type: :controller do
  context 'when not logged in' do
    describe '#new' do
      it 'redirects to login page' do
        get :new
        expect(response).to redirect_to '/users/sign_in'
      end
    end

    describe '#index' do
      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to '/users/sign_in'
      end
    end

    describe '#show' do
      it 'redirects to login page' do
        get :show, id: '123'
        expect(response).to redirect_to '/users/sign_in'
      end
    end

    describe '#edit' do
      it 'redirects to login page' do
        get :edit, id: '123'
        expect(response).to redirect_to '/users/sign_in'
      end
    end

    describe '#destroy' do
      it 'redirects to login page' do
        delete :destroy, id: '123'
        expect(response).to redirect_to '/users/sign_in'
      end
    end

    describe '#update' do
      it 'redirects to login page' do
        put :update, id: '123'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  context 'when logged in' do
    before(:each){ sign_in :user, FactoryGirl.create(:user) }

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
        expect(Restaurant).to receive(:limit).with(100).and_return(restaurants)
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

    describe '#edit' do
      it 'renders the edit template' do
        params = {id: '123'}
        restaurant = double(:restaurant)
        expect(Restaurant).to receive(:find).with(params[:id]).and_return(restaurant)
        get :edit, params
        expect(response).to render_template :edit
        expect(assigns(:restaurant)).to eq restaurant
      end
    end

    describe '#update' do
      context 'on successful updating restaurant' do
        it 'redirects to index template' do
          params = {id: '123', restaurant: {name: 'Chick-fil-a', last_visited: '01/04/2006'}, rating: {value: '4'}}
          restaurant = Restaurant.new({id: '123'})
          expect(Restaurant).to receive(:find).with('123').and_return(restaurant)
          expect(restaurant).to receive(:update_attributes).with({'name'=>'Chick-fil-a', 'last_visited'=>'01/04/2006'}).and_return(true)
          expect(controller).to receive(:save_rating!).with(restaurant).and_return(true)
          put :update, params
          expect(response).to redirect_to '/restaurants'
          expect(session[:flash]['flashes']).to eq({'message'=>'Restaurant successfully updated!'})
          expect(assigns(:restaurant)).to eq restaurant
        end
      end

      context 'on unsuccessful updating restaurant' do
        it 'redirects to index template' do
          params = {id: '123', restaurant: {name: nil, last_visited: '01/04/2006'}, rating: {value: nil}}
          restaurant = Restaurant.new({id: '123'})
          expect(Restaurant).to receive(:find).with('123').and_return(restaurant)
          expect(restaurant).to receive(:update_attributes).with({name: nil, last_visited: '01/04/2006'}).and_return(false)
          put :update, params
          expect(response).to redirect_to '/restaurants/new'
          expect(assigns(:restaurant)).to eq restaurant
        end
      end
    end

    describe '#create' do
      context 'on successfully creating restaurant' do
        it 'redirects to index' do
          params = {restaurant: {name: 'Chick-fil-a', last_visited: '01/04/2016'}, rating: {value: '1'}}
          restaurant = Restaurant.new(params[:restaurant])
          expect(Restaurant).to receive(:new).with(params[:restaurant]).and_return(restaurant)
          expect(restaurant).to receive(:save).and_return(true)
          expect(controller).to receive(:save_rating!).with(restaurant).and_return(true)
          post :create, params
          expect(response).to redirect_to '/restaurants'
          expect(session[:flash]['flashes']).to eq({'message'=>'Restaurant successfully created!'})
          expect(assigns(:restaurant)).to eq restaurant
        end
      end

      context 'on unsuccessfully creating restaurant' do
        it 'rerenders the new template' do
          @request.env['HTTP_REFERER'] = '/restaurants/new'
          params = {restaurant: {name: nil, last_visited: '01/04/2016'}, rating: {value: '1'}}
          restaurant = Restaurant.new(params[:restaurant])
          expect(Restaurant).to receive(:new).with(params[:restaurant]).and_return(restaurant)
          expect(restaurant).to receive(:save).and_return(false)
          post :create, params
          expect(response).to redirect_to '/restaurants/new'
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
          @request.env['HTTP_REFERER'] = '/restaurants'
          params = {id: '123'}
          restaurant = Restaurant.new({id: '456'})
          expect(Restaurant).to receive(:find).with(params[:id]).and_return(restaurant)
          expect(restaurant).to receive(:destroy).and_return(false)
          delete :destroy, params
          expect(response).to redirect_to '/restaurants'
          expect(assigns(:restaurant)).to eq restaurant
        end
      end
    end
  end
end
