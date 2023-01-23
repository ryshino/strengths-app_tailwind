class EpisodesController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :destroy, :show]
  before_action :correct_user,   only: :destroy

  def index
    @episodes = Episode.all
  end

  private

    def episode_params
      params.require(:episode).permit(:title, :content)
    end

    # 投稿者かを確認している
    def correct_user
      @episode = current_user.episodes.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @episode.nil?
    end
end
