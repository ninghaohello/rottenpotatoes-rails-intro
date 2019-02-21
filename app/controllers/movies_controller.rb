class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    sort = params[:sort] || session[:sort]
    
    #handle sorting and highlight
    case sort
    when 'title'
      key = 'title'
      @title_header = 'hilite'
    when 'release_date'
      key = 'release_date'   
      @release_date_header = 'hilite' 
    end

    #handle ratings
    @all_ratings = []
    all_ratings_tuples = Movie.all.select('rating').distinct.to_a
    
    all_ratings_tuples.each do |tuple|
      @all_ratings << tuple.rating
    end
      
    @selected_ratings = params[:ratings] || session[:ratings] || {}

    if session[:sort] != params[:sort]  #get new parameter
      session[:sort] = params[:sort]   #update session
      flash.keep
      redirect_to :sort=>sort, :ratings=> @selected_ratings and return
    end

    if params[:ratings] != session[:ratings] and @selected_ratings != {}
      #session[:sort] = sort
      session[:ratings] = @selected_ratings
      #flash.keep
      #redirect_to :sort => sort, :ratings => @selected_ratings and return
    end
    
    @selected_ratings_keys = []
    if @selected_ratings != {}
      @selected_ratings_keys = @selected_ratings.keys
      @movies = Movie.where(rating:@selected_ratings_keys).order(key)
  
    else
      @movies = Movie.order(key).all
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
