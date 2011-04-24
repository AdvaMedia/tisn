# To change this template, choose Tools | Templates
# and open the template in the editor.

module ExtTextile
    def self.textile(text)
      RedCloth.new(text).to_html(:textile, :video_ext)
    end
end
