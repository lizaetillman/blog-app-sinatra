class UserController < ApplicationController

    get '/login' do
        erb :login
    end

    post '/login' do
        login(params[:email], params[:password])
        erb :home
    end

    get '/signup' do
        erb :signup
    end

    post '/signup' do
        @user = User.new
        @user.email = params[:email]
        @user.password = params[:password]
        @user.save
        erb :home
    end

    get '/logout' do
        logout!
        redirect '/login'
    end

    get '/home' do
        erb :home
    end

    get '/' do
        erb :signup
    end
    
end