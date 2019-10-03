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
    @all_ratings = Movie.get_possible_ratings
    @ratings_selected = nil
    @sortby_column = nil
    
    if params[:sortby] == "title" || params[:sortby] == "release_date"
      session[:sortby] = params[:sortby]
    end
    @sortby_column = session[:sortby]
    
    if !params[:ratings].nil?
      session[:ratings] = params[:ratings]
    elsif session[:ratings].nil?
      session[:ratings] = {}
      @all_ratings.each do |rating|
        session[:ratings][rating] = true
      end
    end
    @ratings_selected = session[:ratings]
    
    #ratings_to_display = @ratings_selected.keys.length == 0 ? @all_ratings : @ratings_selected.keys
    #@movies = Movie.where(:rating => @ratings_selected.keys).all
    #@movies = Movie.all

    @movies = Movie.where(:rating => @ratings_selected.keys).order(@sortby_column).all
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
