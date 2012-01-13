class MatchesController < ApplicationController
  def index
    @current_match = Match.order("created_at DESC").where(status: "running").first
    @matches = Match.order("created_at DESC").where(status: "finished").limit(10).all
  end

  def show
    @match = Match.find(params[:id])
    render layout: nil
  end
end
