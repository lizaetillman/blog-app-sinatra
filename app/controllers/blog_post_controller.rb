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
        set_post
        erb :post
    end

    get '/posts/:id/edit' do
        set_post
        authorized_user(@post)
        erb :post_edit
    end

    patch '/posts/:id' do
        set_post
        authorized_user(@post)
        params.delete("_method")
        if @post.update(params)
                redirect "/posts/#{@post.id}"
            else
                erb :error_page
            end
    end

    delete "/posts/:id" do
        set_post
        authorized_user(@post)
        @post.destroy
        redirect "/posts" 
    end

    get '/friends-posts' do
        @posts = current_user.friends_posts.pluck(:id, :title, :content)
        erb :all_posts
    end

    get '/friends-posts/:id' do
        set_post
        erb :post
    end

    get '/posts' do
        @posts = current_user.blog_posts.pluck(:id, :title, :content)
        erb :user_posts
    end

    private 

    def set_post 
        @post = BlogPost.find_by(id: params[:id])
    end

end