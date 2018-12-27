class MypageController < ApplicationController
  def home

    # @users = User.all
    # @users = User.find_by(id: current_user.id)
    # @users = User.find_by(id: current_user.id)
    @histories = Studies_history.new
    @who = 1

    @everyone_hisories = Studies_history.joins(:users).select("users.*, studies_histories.* ").where(is_open: 1).where.not(users_id: current_user.id).order("studies_histories.created_at DESC").limit(10)
    # @my_hisories = Studies_history.joins(:users).select("users.*, studies_histories.* ").where(users_id: current_user.id).order("studies_histories.created_at ASC")
    @today = Date.today
    params[:year] = @today.year
    params[:month] = @today.month
    @current_year = @today.year

    @my_hisories = Studies_history.joins(:users).select("users.*, studies_histories.* ")
    .where(users_id: current_user.id)
    .where('studies_histories.created_at >= ?', Time.local(@today.year, @today.month, 1))
    .where('studies_histories.created_at <= ?', Time.local(@today.year, @today.month, 1).end_of_month)


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
    # raise.params.inspect

    @next_year  = params[:current_year].to_i
    @next_month = params[:current_month].to_i

    @today = Date.today

    if params[:next]
      @next_month = @next_month + 1

      if @next_month === 13
        @next_month = 1
        @next_year  = @next_year + 1
      end
    end

    if params[:last]
      @next_month = @next_month - 1

      if @next_month === 0
        @next_month = 12
        @next_year  = @next_year - 1
      end
    end

    if params[:now]
      @next_year  = @today.year.to_i
      @next_month = @today.month.to_i
    end

    puts "params"
    puts params[:member_id]

    if params[:member_id].blank?

      @my_hisories = Studies_history.joins(:users).select("users.*, studies_histories.* ")
      .where(users_id: current_user.id)
      .where('studies_histories.created_at >= ?', Time.local(@next_year, @next_month, 1))
      .where('studies_histories.created_at <= ?', Time.local(@next_year, @next_month, 1).end_of_month)

    else

      @my_hisories = Studies_history.joins(:users).select("users.*, studies_histories.* ")
      .where(users_id: params[:member_id])
      .where('studies_histories.created_at >= ?', Time.local(@next_year, @next_month, 1))
      .where('studies_histories.created_at <= ?', Time.local(@next_year, @next_month, 1).end_of_month)

    end
    params[:year] = @next_year.to_i
    params[:month] = @next_month.to_i

  end

  def redraw_history
    # @who = params[:who].to_i

    if params[:everyone]
      @everyone_hisories = Studies_history.joins(:users).select("users.*, studies_histories.* ").where(is_open: 1).where.not(users_id: current_user.id).order("studies_histories.created_at DESC").limit(10)
      @who = 1
    end

    if params[:myself]
      @everyone_hisories = Studies_history.joins(:users).select("users.*, studies_histories.* ").where(users_id: current_user.id).order("studies_histories.created_at DESC").limit(10)
      @who = 2
    end
    puts @who
  end

  def get_edit_history_data
    @edit_history = Studies_history.find(params[:history_id])
  end

  def update
    # デバッグ用。送信されている値を全て確認する
    # raise.params.inspect
    @is_cancel = true
    @temp = params["studies_history"]
    if !params[:cancel]
    @update_history = Studies_history.find(@temp["id"])
    @update_history.update(:content => @temp["content"])
    @update_history.save
    @is_cancel = false
    end
    @return_history = Studies_history.find(@temp["id"])
  end

  private
  def valid_params
    @create_users_id_seq = 0 # インクリメントされて1になる
    @temp = Studies_history.select("users_id_seq").where(users_id: current_user.id).order("users_id_seq DESC").limit(1) #.order(users_id_seq: :desc)

    @edit_params = params.require(:studies_history).permit(:category2, :content, :is_open)

    # 大カテゴリ名の取得
    @temp_category1 = Field.find_by(user_id: current_user.id , category2: @edit_params["category2"])
    @edit_params["category1"] = @temp_category1.category1
    @edit_params["color_code"] = @temp_category1.color_code

    # 小カテゴリ名の取得
    # @temp_category2 = Sub_category.find(@edit_params["category2"].to_i)
    # @edit_params["color_code"] = @temp_category2.color_code
    # @edit_params["category2"] = @temp_category2.category2

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
