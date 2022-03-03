class Api::ArtistsController < ApplicationController
    # set @artist in our show, update, destroy methods
    before_action :set_artist, only: [:show, :update, :destroy]
   
    def index
        render json: Artist.all
    end

    def show
        render json: @artist
    end
   
    def create
        @artist = Artist.new(artists_params)
        if(@artist.save)
            render json: @artist
        else
            render json: {errors: @artist.errors.full_messages}, status: 422
        end
    end
   
    def update
        if(@artist.update(artists_params))
            render json: @artist
        else
            render json: {errors: @artist.errors.full_messages}, status: 422
        end
    end
   
    def destroy
        render json: @artist.destroy
    end

    private
    
    def artists_params
      params.require(:artist).permit(:name, :fans)
    end

    # this method will be called before  show, update, destroy methods
    def set_artist
      @artist = Artist.find(params[:id])
    end
end
