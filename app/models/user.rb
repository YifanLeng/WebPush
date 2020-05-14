require 'sinatra/activerecord'
require 'bcrypt'

class User < ActiveRecord::Base
  def as_json(options = {})
    super(options.merge({ except: [:password] }))
  end
  # use bcrypt to encrypt user's password 
  has_secure_password

  # associate a user with its fans
  # 1. retrieve entries in Follow with idol_id = user.id
  has_many :user_as_idols, 
  :foreign_key => :idol_id,
  :class_name => 'Follow'
  # 2. use fan_ids as foreign keys in Follow to find its fans in User 
  has_many :fans,
  :through => :user_as_idols,
  :foreign_key => :fan_id,
  :class_name => 'User'

  # associate a user with its idols
  # 1. retrieve entries in Follow with fan_id = user.id
  has_many :user_as_fans,
  :foreign_key => :fan_id,
  :class_name => 'Follow'
  # 2. use idol_ids as foreign keys in Follow to find its idols in User 
  has_many :idols,
  :through => :user_as_fans,
  :foreign_key => :idol_id,
  :class_name => 'User'

  has_many :comments
  has_many :comments_in, 
  :through => :comments, 
  :source => :tweet

  has_many :mentions
  has_many :mentioned_in,
  :through => :mentions, 
  :source => :tweet

  has_many :tweets

  has_one :timeline
  
  def follow(other_id)
    user_as_fans.create!(idol_id: other_id)
  end

  def unfollow(other_id)
    user_as_fans.where(idol_id: other_id).delete_all
  end

  def following?(other)
    user_as_fans.where(idol_id: other.id).length != 0
  end

end