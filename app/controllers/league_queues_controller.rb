class LeagueQueuesController < ApplicationController
    def show
        q = LeagueQueue.find_by(queueId: params[:id])
        render json: q
    end
end
