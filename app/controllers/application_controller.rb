class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    # ログイン済ユーザーのみにアクセスを許可する
    #before_action :authenticate_user!
  
    # deviseコントローラーにストロングパラメータを追加する          
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    protected
    def configure_permitted_parameters
      # サインアップ時にnameのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      # アカウント編集の時にnameとprofileのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile,:platform, \
                                                                :survivor_lank,:killer_lank, :style, \
                                                                :discord ,:ptvc,:skype, :novc, \
                                                                :activity,:steam,:ps,:switch,:xbox,:image])
    end

    def after_sign_in_path_for(resource)
      if current_user
        if current_user.steam == false && current_user.ps == false && current_user.switch == false && current_user.xbox == false
          flash[:notice] = "プロフィールを設定してください"
          edit_user_registration_path
        else
          flash[:notice] = "ログインに成功しました" 
          home_path  #　指定したいパスに変更
        end
      else
        flash[:notice] = "新規登録完了しました。次に名前を入力してください" 
        edit_user_registration_path  #　指定したいパスに変更
      end
    end

end
