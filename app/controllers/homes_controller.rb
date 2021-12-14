class HomesController < ApplicationController
    before_action :login_check

    def index
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
