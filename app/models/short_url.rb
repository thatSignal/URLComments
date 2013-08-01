require 'launchy'

class ShortUrl < ActiveRecord::Base
  attr_accessible :long_url_id, :short_url, :user_id

  belongs_to(
    :user,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  belongs_to(
    :long_url,
    :class_name => "LongUrl",
    :foreign_key => :long_url_id,
    :primary_key => :id
  )


  has_many(
    :comments,
    :class_name => "Comment",
    :foreign_key => :short_url_id,
    :primary_key => :id
  )

  def self.shorten(long_url)
      SecureRandom.urlsafe_base64
  end

  def self.expand(short_url)
    short_url = ShortUrl.find_by_short_url(short_url)
    puts short_url.comments

    url = LongUrl.where( :short_url_id => short_url.id ).url
    Launchy.open(url)

  end

  def self.get_comments(short_url)
    ShortUrl.find_by_short_url(short_url).comments
  end


end