class VotesController < ApplicationController
  # PATCH/PUT /votes/1
  def update
    @vote = Vote.find_by(article_id: params[:id], user_id: current_user.id)

    if @vote
      flash.notice = 'You already voted before.'
      redirect_to articles_path
      return
    end
    @vote = Vote.new(article_id: params[:id], user_id: current_user.id)

    if @vote.save
      flash[:info] = 'vote was successfully created.'
    else
      flash[:warning] = 'Sorry, something error happened'
    end
    redirect_to articles_path
  end
end
