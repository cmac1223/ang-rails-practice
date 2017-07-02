class SongsController < ApplicationController
   
    def index
        @artist = Artist.find(params[:artist_id])
        @songs = @artist.songs.all
        render json: @songs
    end
    
    def show
        @artist = Artist.find(params[:artist_id])
        @song = Song.find(params[:id])
        render json: @song
    end

    def create
          @artist = Artist.find(params[:artist_id])
          @song = @artist.songs.new(song_params)

        if @song.save
            redirect_to artist_songs_path(@artist, @song)
        else
            render status: 500, json: {error: @song.errors}
        end
    end

    def update
        @artist = Artist.find(params[:artist_id])
        @song = Song.find(params[:id])
        
        if @song.update(song_params)
            render json: {
                artist: @song
            }
        else
            render status: 500, 
            json: {
                error: @song.errors
            }
        end
    end 

    def destroy
        @song = Song.find(params[:id])
        if @song.destroy
            render json: {message: 'Successfully deleted song'}
        else
            render status: 500, json: {error: 'Could not delete Song'}
        end
        
    end
        

    
    

  private
  def song_params
    params.require(:song).permit(:title, :album, :preview_url)
  end

end



