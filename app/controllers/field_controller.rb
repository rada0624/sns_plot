class FieldController < ApplicationController
  def home
    @colors = Color.where(is_available: 1)
    # @field  = Color.joins(:fields).select("colors.color_code AS master_color_code, fields.*").where("fields.user_id = ?", current_user.id)

    @field  = Field.where(user_id: current_user.id)

    if @field.blank?
    #  @field = Color.new
    end

  end

  def create

  end

  def update
    # raise.params.inspect
    @params_field = params[:field].permit!

    @idx = 0
    # Rails5.1以降はkey.eachが必須
    @params_field.keys.each do |fds|
      puts fds.inspect

      if @params_field[fds]
        #puts fds
        #puts fds[@idx]
        fd = @params_field[fds]
        @update_field = Field.find_by(user_id: current_user.id, user_id_seq: fd["user_id_seq"].to_i)
        @update_field.update(:color_code => fd["color_code"], :category1 => fd["category1"], :category2 => fd["category2"], :is_available => fd["is_available"].to_i)

      end
      @idx = @idx + 1
    end

  end
end
