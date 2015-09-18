module TracksHelper

  def render_lyrics(lyrics)
    html = "<pre>"

    lyrics.split(/\n/).each do |line|
      html += ("&#9835; " + h(line) + "\n")
    end

    html += "</pre>"

    html.html_safe
  end
end
