class MemberController < ApplicationController
  def home
    @member_id = params["id"]
    @member = User.find_by(id: @member_id)
    @member_hisories = Studies_history.joins(:users).select("users.*, studies_histories.* ").where(users_id: @member_id, is_open: 1).order("studies_histories.created_at DESC").limit(100)

    # 過去30日分のデータ取得
    to  = Time.now
    from    = (to - 30.day).at_end_of_day
    @month_history = Studies_history.where(created_at: from...to).where(users_id: @member_id)

    # 全投稿件数
    @all_history = Studies_history.joins(:users).select("id").where(users_id: @member_id)

    @today = Date.today
    params[:year] = @today.year
    params[:month] = @today.month
    @current_year = @today.year
    params[:member_id] = @member_id


    @my_hisories = Studies_history.joins(:users).select("users.*, studies_histories.* ")
    .where(users_id: @member_id)
    .where('studies_histories.created_at >= ?', Time.local(@today.year, @today.month, 1))
    .where('studies_histories.created_at <= ?', Time.local(@today.year, @today.month, 1).end_of_month)


    # @month_history = Studies_history.joins(:users).select("id").where(users_id: @member_id, )


  end

end
