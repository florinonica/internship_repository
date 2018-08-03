class Attachment < ApplicationRecord
  belongs_to :user
  belongs_to :project, optional: true
  belongs_to :ticket, optional: true
  belongs_to :comment, optional: true
  has_attached_file :file#, styles: lambda { |a| a.instance.check_file_type}
  validates_attachment_content_type :file, :content_type => [/\Aimage\/.*\Z/, /\Avideo\/.*\Z/, /\Aaudio\/.*\Z/, /\Aapplication\/.*\Z/]
=begin
  def check_file_type
    if file_content_type =~ %r(image)
      {:small => "x200>", :medium => "x300>", :large => "x400>"}
    elsif file_content_type =~ %r(video)
      {
          :thumb => { :geometry => "250x250#", :format => 'jpg', :time => 10, :processors => [:ffmpeg] },
          :medium => {:geometry => "640x480#", :format => 'jpg', :time => 10, :processors => [:ffmpeg]}
      }
    else
      {}
    end
  end
=end
  def is_video?
    file_content_type =~ %r(video)
  end

  def is_image?
    file_content_type =~ %r(image)
  end

  def is_audio?
    file_content_type =~ %r(audio)
  end
end
