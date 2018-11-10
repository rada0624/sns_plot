class MypageController < ApplicationController
  def home

    # @users = User.all
    # @users = User.find_by(id: current_user.id)
    # @users = User.find_by(id: current_user.id)
    @histories = Studies_history.new

    @everyone_hisories = Studies_history.joins(:users).select("users.*, studies_histories.* ").where(is_open: 1).where.not(users_id: current_user.id).order("studies_histories.created_at DESC").limit(10)
    @my_hisories = Studies_history.joins(:users).select("users.*, studies_histories.* ").where(users_id: current_user.id).order("studies_histories.created_at DESC").limit(10)
    @today = Date.today
    params[:year] = @today.year
    params[:month] = @today.month
    @current_year = @today.year

    # render :text => 'マイページです'
  end

  def create
    # デバッグ用。送信されている値を全て確認する
    # raise.params.inspect

      @create_histries = Studies_history.new(valid_params)

      if @create_histries.save
        redirect_to controller: 'mypage', action: 'home'
      end
  end

  def redraw_carender
    @next_year = params[:current_year].to_i
    @next_month = params[:next_month].to_i

    if @next_month === 0
      @next_month = 12
      @next_year = next_year - 1
    end

    if @next_month === 13
      @next_month = 1
      @next_year = @next_year + 1
    end

    @my_hisories = Studies_history.joins(:users).select("users.*, studies_histories.* ")
    .where(users_id: current_user.id)
    .where('studies_histories.created_at >= ?', Time.local(@next_year, @next_month, 1))
    .where('studies_histories.created_at <= ?', Time.local(@next_year, @next_month, 1).end_of_month)

    @today = Date.today
    params[:year] = @next_year.to_i
    params[:month] = @next_month.to_i
  end

  private
  def valid_params
    @create_users_id_seq = 0 # インクリメントされて1になる
    @temp = Studies_history.select("users_id_seq").where(users_id: current_user.id).order("users_id_seq DESC").limit(1) #.order(users_id_seq: :desc)

    @edit_params = params.require(:studies_history).permit(:color_code, :category1, :category2, :content, :is_open)

    # 最新の登録データを取得する
    if !@temp.blank?
      @temp.each do |tempElement|
        @create_users_id_seq = tempElement.users_id_seq
      end
    end
    @edit_params["users_id_seq"] = @create_users_id_seq.next
    @edit_params["users_id"] = current_user.id
    @edit_params
  end
end
