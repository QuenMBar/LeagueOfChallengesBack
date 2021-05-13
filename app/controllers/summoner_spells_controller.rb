class SummonerSpellsController < ApplicationController
    def show
        s = SummonerSpell.find_by(key: params[:id].to_s)
        render json: s
    end
end
