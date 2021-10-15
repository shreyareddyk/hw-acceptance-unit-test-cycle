require 'rails_helper'

describe MoviesController, :type => :controller do

    let!(:m1) { FactoryGirl.create(:movie, title: 'The Terminator', director: 'This guy') }
    let!(:m2) { FactoryGirl.create(:movie, title: 'When Harry Met Sally', director: 'This guy') }
    
    describe "similar"
       context "When specified movie has a director" do
           it "should find movies with the same director" do
           @movie_id = "123"
           @movie = double('Frozen 2', :director => 'Jennifer Lee')
           expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
           expect(@movie).to receive(:same_directors)
           get :similar,  :id => @movie_id
           expect(response).to render_template(:similar)
        end
       end
    
    context "When a specified movie does not have a director" do
           it "should redirect to the movies page" do
           @movie_id = "123"
           @movie = double('Frozen 2').as_null_object
           expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
           get :similar, :id => @movie_id
           expect(response).to redirect_to(movies_path)
           end
           
       end
       
describe 'Editing' do
    let!(:movie) { FactoryGirl.create(:movie) }
    before do
      get :edit, id: movie.id
    end
     it 'should find the movie' do
      expect(assigns(:movie)).to eql(movie)
    end
     it 'should render the edit template' do
      expect(response).to render_template('edit')
    end
  end
  
  describe 'Destroy' do
    let!(:movie1) { FactoryGirl.create(:movie) }
    it 'destroys or deletes a movie' do
      expect { delete :destroy, id: movie1.id
      }.to change(Movie, :count).by(-1)
    end
    it 'redirects to movies#index after destroy' do
      delete :destroy, id: movie1.id
      expect(response).to redirect_to(movies_path)
    end
  end
  
  describe 'Show' do
    let!(:movie) { FactoryGirl.create(:movie) }
    before(:each) do
      get :show, id: movie.id
    end
    it 'should find the movie' do
      expect(assigns(:movie)).to eql(movie)
    end
    it 'should render the show template correctly' do
      expect(response).to render_template('show')
    end
  end
  
  describe 'Get index' do
    let!(:movie) {FactoryGirl.create(:movie)}
    it 'should render the index template' do
      get :index
      expect(response).to render_template('index')
    end
    it 'should assign the instance variable for title header' do
      get :index, { sort: 'title'}
      expect(assigns(:title_header)).to eql('hilite')
    end
    it 'should assign the instance variable for release_date header' do
      get :index, { sort: 'release_date'}
      expect(assigns(:date_header)).to eql('hilite')
    end
  end
  


end
