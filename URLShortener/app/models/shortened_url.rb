require 'byebug'
# == Schema Information
#
# Table name: shortened_urls
#
#  id        :bigint           not null, primary key
#  user_id   :integer
#  long_url  :string
#  short_url :string
#

class ShortenedUrl < ApplicationRecord 
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit

  def self.random_code(user, long_url)
    link = SecureRandom::urlsafe_base64((long_url.length / 4))
    until !ShortenedUrl.exists?(short_url: link)
      link = SecureRandom::urlsafe_base64(22)
    end
    ShortenedUrl.create!(user_id: user.id, long_url: long_url, short_url: link)
  end

  def num_clicks
    visits.count 
  end

end
