class Api::SongsController < ApplicationController
    before_action :set_artist
    before_action :set_song, only: [:show, :update, :destroy]
   
    def index
        render json: @artist.songs.all
    end

    def show
        render json: @song
    end
   
    def create
        @song = @artist.songs.new(songs_params)
        if(@song.save)
            render json: @song
        else
            render json: {errors: @song.errors.full_messages}, status: 422
        end
    end
   
    def update
        if(@song.update(songs_params))
            render json: @song
        else
            render json: {errors: @song.errors.full_messages}, status: 422
        end
    end
   
    def destroy
        render json: @song.destroy
    end

    private
    
    def songs_params
      params.require(:song).permit(:name, :play_count)
    end

    # this method will be called before  all methods
    def set_artist
      @artist = Artist.find(params[:artist_id])
    end


    # this method will be called before  show, update, destroy methods
    def set_song
        @song = @artist.songs.find(params[:id])
    end
end
