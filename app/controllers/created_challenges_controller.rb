class CreatedChallengesController < ApplicationController
    def destroy
        chal = CreatedChallenge.find(params[:id])
        chal.destroy
        render json: {}
    end
end
