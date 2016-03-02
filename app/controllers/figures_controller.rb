class FiguresController < ApplicationController
  get '/figures' do 
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do 
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/new'
  end 

  post '/figures' do 
    @figure = Figure.create(params[:figure])
    @figure.landmarks << Landmark.create(params[:landmark])
    @figure.titles << Title.create(params[:title])
    @figure.save
    redirect "/figures/#{@figure.id}"

  end

  get '/figures/:id' do 
    @figure = Figure.find_by_id(params[:id])

    erb :'figures/show'
  end

  get '/figures/:id/edit' do 
    @figure = Figure.find_by_id(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all

    erb :'figures/edit'
  end

  post '/figures/:id' do 
    @figure = Figure.find_by_id(params[:id])
    @figure.name = params[:figure][:name]
    @figure.landmarks << Landmark.find_or_create_by(params[:landmark])
    @figure.titles << Title.find_or_create_by(params[:title])
    @figure.save

    redirect "/figures/#{@figure.id}"

  end

end