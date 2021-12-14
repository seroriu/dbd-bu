class PostController < ApplicationController
    def index
    end

    def all
        @posts = Post.all
    end

    def new
        @post = Post.new
    end

    def show
        @post = Post.find(params[:id])
        @posts = Post.all
        @res = @post.re
        
    end

    def destroy
        @posts = Post.find(params[:id])
        @posts.destroy
        flash[:notice] = "削除しました"
        redirect_to all_posts_path
      end

    def create
        post_params = params.require(:post).permit(:title,:content)
        post_params[:user_id] = current_user.id
        @post = Post.new(post_params)
        if @post.save
            flash[:notice] = "投稿しました"
            redirect_to all_posts_path
        else
            flash.now[:alert] = "投稿に失敗しました。"
            render :new
        end
    end

    def destroy_res
        res = Re.find(params[:id])
        res.destroy
        flash[:notice] = "削除しました"
        redirect_to request.referer
      end

    def create_res
        res_params = params.permit(:content)
        res_params[:user_id] = current_user.id
        res_params[:post_id] = params[:id]
        @re = Re.new(res_params)
        if @re.save
            flash[:notice] = "投稿しました"
            redirect_to request.referer
        else
            flash.now[:alert] = "投稿に失敗しました。"
            render :new
        end
    end
end
