class BlogPostController < ApplicationController

    get '/posts/new' do
        if !logged_in?
            redirect "/login"
          else
            erb :"post_new"
          end
    end

    post '/saveblogpost' do
        post = BlogPost.new
        post.title = params[:title]
        post.content = params[:content]
        post.user_id = User.find_by(:email => session[:email]).id
        if post.save
            redirect "/posts/#{post.id}"
        else
            erb :error_page
        end
    end

    get '/posts/:id' do
        erb :post
    end

    get '/posts/:id/edit' do
        erb :post_edit
    end

    patch '/posts/:id' do
        authorized_user? 
        @post= BlogPost.find_by(id: params[:id])
        @post.title = params[:title]
        @post.content = params[:content]
            
            if @post.save
                redirect "/posts/#{@post.id}"
            else
                erb :error_page
            end
    end

    delete "/posts/:id" do
          blog_post =  BlogPost.find(params[:id])
          blog_post.destroy
          redirect "/home"
    end

    get '/posts' do
        @user = User.find_by(:email=> session[:email])
        @posts_array = @user.blog_posts
        @posts = @user.blog_posts.pluck(:id, :title, :content)
        erb :all_posts
    end

end