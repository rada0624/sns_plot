class DetailController < ApplicationController

  def home
    @history_id = params["id"]
    @detail_hisory = Studies_history.joins(:users).select("users.*, studies_histories.* ").where(id: @history_id).order("studies_histories.created_at DESC").limit(1)
  end

  def edit
    @history_id = params["id"]
    @detail_hisory = Studies_history.joins(:users).select("users.*, studies_histories.* ").where(id: @history_id).order("studies_histories.created_at DESC").limit(1)
    @histories = Studies_history.find_by(id: @history_id)
  end

  def create
    # デバッグ用。送信されている値を全て確認する
    # raise.params.inspect
    @temp = params["studies_history"]

    @create_histries = Studies_history.find(@temp["id"])
    @create_histries.update_attributes(:is_open => @temp["is_open"], :color_code => @temp["color_code"], :category1 => @temp["category1"], :category2 => @temp["category2"], :content => @temp["content"] )


    if @create_histries.save
      redirect_to controller: 'detail', action: 'home', id: @temp["id"]
    end
  end

  private
  def vaild_params
    @edit_params = params.require(:studies_history).permit(:id, :color_code, :category1, :category2, :content, :is_open)
    @edit_params
  end
end
