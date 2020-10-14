require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "blog_post_app"
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

    def logout!
      session.clear
    end

    def logged_in?
      !!session[:email]
    end

    def authorized_user
      @creator_of_post = BlogPost.find([params][:id]).user_id
      #post.user == current_user
      if current_user.id != @creator_of_post
        redirect '/error_page'
      end
    end


  end

end