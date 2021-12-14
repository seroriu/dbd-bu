class ResController < ApplicationController
    def index
    end

    def all
        @res = Re.all
    end

    def new
        @res = Re.new
    end

    def destroy_res
        res = Re.find(params[:id])
        res.destroy
        flash[:notice] = "削除しました"
        redirect_to all_posts_path
      end

    def create_res
        res_params = params.require(:re).permit(:content)
        post_params[:user_id] = current_user.id
        post_params[:post_id] = params[:id]
        @re = Re.new(post_params)
        if @re.save
            flash[:notice] = "投稿しました"
            redirect_to all_posts_path
        else
            flash.now[:alert] = "投稿に失敗しました。"
            render :new
        end
    end
end