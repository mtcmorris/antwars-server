class BotsController < ApplicationController
  def index
    @bots = Bot.all
  end

  def show
    @bot = Bot.find(params[:id])
  end

  def new
    @bot = Bot.new
  end

  def create
    @bot = Bot.new(params[:bot])

    if @bot.save
      # Deactivate old bots
      Bot.where(player_name: @bot.player_name).where("id < ?", @bot.id).all.map{|b| b.update_attribute :status, "inactive" }
      redirect_to @bot, notice: 'Bot was successfully created.'
    else
      render action: "new"
    end
  end
end
