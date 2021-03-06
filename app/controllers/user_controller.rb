class UserController < ApplicationController

    get '/login' do
        erb :login
    end

    post '/login' do
        login(params[:email], params[:password])
        redirect :home
    end

    get '/signup' do
        erb :signup
    end

    post '/signup' do
        @user = User.new(
            email: params[:email],
            password: params[:password]
        )
        @user.save
        session[:email] = @user.email
        if !@user.id
            erb :error_page
        else
            redirect '/home'
        end
    end

    get '/logout' do
        logout!
        redirect '/signup' 
    end

    get '/home' do
        erb :home
    end

    get '/' do
        erb :signup
    end
    
end