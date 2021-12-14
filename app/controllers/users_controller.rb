class UsersController < ApplicationController
  before_action :login_check

  def show
    @user = User.find(params[:id])
    @users = User.all
    # @comments = Comment.all
    @comments = Comment.where(posted_id: params[:id])
    if user_signed_in?
      @faves = Fave.where(faved_id:params[:id]).find_by(user_id:current_user.id)
    end
    @user_faved = Fave.where(faved_id: params[:id])
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    flash[:notice] = "退会しました"
    redirect_to home_path
  end

  def all
    # @users = User.all
    @users = User.paginate(page: params[:page], per_page: 20)
    @comment = ""
    @params = params
    puts "-------------"
    p params
    puts "-------------"
    if params["utf8"]
      @users = @users.where("profile like ? or name like ?", "%" + params[:profile] + "%","%" + params[:profile] + "%") if params[:profile].present?
      steam = true
      ps = true
      switch = true
      xbox = true
      discord = true
      ptvc = true
      skype = true
      novc = true
      steam = nil if params[:steam] == "0"
      ps = nil if params[:ps] == "0"
      switch = nil if params[:switch] == "0"
      xbox = nil if params[:xbox] == "0"
      discord = nil if params[:discord] == "0"
      ptvc = nil if params[:ptvc] == "0"
      skype = nil if params[:skype] == "0"
      novc = nil if params[:novc] == "0"
      puts "steam:#{steam}"
      puts "ps:#{ps}"
      puts "switch:#{switch}"
      puts "xbox:#{xbox}"
      puts "discord:#{discord}"
      puts "ptvc:#{ptvc}"
      puts "skype:#{skype}"
      puts "novc:#{novc}"
      @users = @users.where(steam: steam).or(@users.where(ps: ps)).or(@users.where(switch: switch)).or(@users.where(xbox: xbox))
      @users = @users.where(discord: discord).or(@users.where(ptvc: ptvc)).or(@users.where(skype: skype)).or(@users.where(novc: novc))
    end
  end

  def mypage
    @user = current_user
  end

  def post_comment
    comment_params = params.permit(:comment_content)
    comment_params[:user_id] = current_user.id
    comment_params[:posted_id] = params[:id]
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_back(fallback_location: home_path)
  end

  def post_fave
    fave = Fave.new #faveクラスのインスタンスを作成
    fave.user_id = current_user.id #current_userのidを変数に代入
    fave.faved_id = params[:id]
    if Fave.where(faved_id:params[:id]).find_by(user_id:current_user.id)
      return
    end
    fave.save
    if fave.save #faveが保存できているかどうかで条件分岐
      flash[:notice] = "いいねしました"
      redirect_to request.referer
    else
      flash.now[:alert] = "いいねに失敗しました。"
      render :new
    end
  end

  
  def destroy_fave
    @fave = Fave.where(faved_id:params[:id]).find_by(user_id:current_user.id)
    @fave.destroy
    flash[:notice] = "いいねを解除しました"
    redirect_to request.referer
  end


  def destroy_comment
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "削除しました"
    redirect_to request.referer
  end


  private
  def login_check
    if user_signed_in?
      if current_user.steam == false && current_user.ps == false && current_user.switch == false && current_user.xbox == false
        flash[:notice] = "プロフィールを設定してください"
        redirect_to edit_user_registration_path
        return
      end
      if current_user.discord == false && current_user.ptvc == false && current_user.skype == false && current_user.novc == false
        flash[:notice] = "プロフィールを設定してください"
        redirect_to edit_user_registration_path
        return
      end
    end
  end
end
