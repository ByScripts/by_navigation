ByNavigation::Configuration.new :main_nav do

  item :home, "Home"

  item :media, "Multimedia" do

    item :audio, "Audio" do
      item :mp3, "MP3"
      item :flac, "FLAC"
    end

    item :video, "Video" do
      item :avi, "AVI"
      item :mkv, "MKV"
    end
  end

end
