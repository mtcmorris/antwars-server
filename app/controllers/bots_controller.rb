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
      redirect_to @bot, notice: 'Bot was successfully created.'
    else
      render action: "new"
    end
  end
end
