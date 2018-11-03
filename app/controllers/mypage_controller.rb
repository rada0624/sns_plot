class MypageController < ApplicationController
  def home

    # @users = User.all
    # @users = User.find_by(id: current_user.id)
    @users = User.find_by(id: current_user.id)
    @histories = Studies_history.new

    @everyone_hisories = Studies_history.limit(10)

    # render :text => 'マイページです'
  end

  def create
    # デバッグ用。送信されている値を全て確認する
    # raise.params.inspect

      @create_histries = Studies_history.new(valid_params)

      if @create_histries.save
        # redirect_to
      end
  end

  private
  def valid_params
    @create_users_id_seq = 0 # インクリメントされて1になる
    @temp = Studies_history.find_by(users_id: current_user.id) #.order(users_id_seq: :desc)

    @edit_params = params.require(:studies_history).permit(:color_code, :category1, :category2, :content, :is_open)

    # 最新の登録データを取得する
    if !@temp.blank?
      @create_users_id_seq = @temp.users_id_seq
    end
    @edit_params["users_id_seq"] = @create_users_id_seq.next
    @edit_params["users_id"] = current_user.id
    @edit_params
  end



end
