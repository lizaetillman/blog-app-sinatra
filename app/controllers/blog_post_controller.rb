class BlogPostController < ApplicationController

    get '/posts/new' do
        redirect_if_not_logged_in
            erb :"post_new"
    end

    post '/saveblogpost' do
        post = BlogPost.new(title: params[:title], content: params[:content])
        post.user = current_user
        if post.save
            redirect "/posts/#{post.id}"
        else
            erb :"post_new"
        end
    end

    get '/posts/:id' do
        @post = BlogPost.find_by(id: params[:id])
        erb :post
    end

    get '/posts/:id/edit' do
        authorized_user
        @post = BlogPost.find_by(id: params[:id])
        erb :post_edit
    end

    patch '/posts/:id' do
        authorized_user
        @post = BlogPost.find_by(id: params[:id])
        @post.title = params[:title]
        @post.content = params[:content]
            
            if @post.save
                redirect "/posts/#{@post.id}"
            else
                erb :error_page
            end
    end

    delete "/posts/:id" do
        authorized_user
        blog_post = BlogPost.find(params[:id])
        blog_post.destroy
          redirect "/posts" 
    end

    get '/friends-posts' do
        @user = current_user
        
        @posts_array = BlogPost.all
        @posts = @posts_array.pluck(:id, :title, :content)
            erb :all_posts
    end

    get '/friends-posts/:id' do
        @post = BlogPost.find_by(id: params[:id])
        erb :friends_posts
    end

    get '/posts' do
        @user = User.find_by(:email=> session[:email])
        
        @posts_array = @user.blog_posts
        @posts = @user.blog_posts.pluck(:id, :title, :content)
            erb :user_posts
    end

end