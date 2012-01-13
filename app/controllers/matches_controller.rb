class MatchesController < ApplicationController
  def index
    @matches = Match.order("created_at DESC").all
  end

  def show
    @match = Match.find(params[:id])

    render layout: nil
  end
end
