require_relative '../../config/environment'

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do 
    # binding.pry
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do 
    erb :new
  end

  post '/recipes' do 
    # binding.pry
  
    @recipe = Recipe.create(params)

    redirect "/recipes/#{@recipe.id}" 

  end

  get '/recipes/:id' do 
    # binding.pry
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  delete '/recipes/:id' do
    # binding.pry
    recipe = Recipe.find_by_id(params[:id])
    recipe.delete
    redirect to '/recipes'
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do 
    recipe = Recipe.find_by_id(params[:id])
    recipe.update(name: params[:name], ingredients: params[:ingredients,], cook_time: params[:cook_time])
    redirect "/recipes/#{params[:id]}"
  end



end
