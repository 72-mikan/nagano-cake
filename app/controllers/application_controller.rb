class ApplicationController < ActionController::Base
  before_action :authenticate_any!

  def authenticate_any!
    if request.path.match(/\/admin(\/)?/) # url判定(urlにadminを含んでいるか)
      authenticate_admin! # adminログイン制限
    elsif controller_name == 'items' || action_name == 'top' || action_name == 'about'
      # itemsコントローラーかtopアクションまたはaboutアクションが読み込まれるとき
      return # 処理を抜ける
    else
      authenticate_customer! # customerログイン制限
    end
  end
end
