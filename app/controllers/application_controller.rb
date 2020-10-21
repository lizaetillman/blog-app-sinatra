require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "blog_post_app"
  end

  get '/error_page' do
    erb :error_page
  end

  helpers do

    def login(email, password)
      user = User.find_by(:email => email)
      if user && user.authenticate(password)
        session[:email] = user.email
      else
        redirect '/login'
      end
    end

    def redirect_if_not_logged_in
      if !logged_in?
        redirect '/login'
      end
    end

    def logout!
      session.clear
    end

    def logged_in?
      !!session[:email]
    end

    def current_user
      @user ||= User.find_by(:email => session[:email])
    end
      
    def authorized_user(record)
      if !owner?(record)
        redirect '/error_page'
      end
    end

    def owner?(record)
      current_user == record.user
    end



  end

end