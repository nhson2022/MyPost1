class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :posts

  # Follows a user.
  def follow(other_user)
    return if other_user.id == id

    if following?(other_user)
      unfollow(other_user)
      return
    end

    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def ordered_posts(params)
    posts.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  end
  
  def self.available_users(current_user)
    return all unless current_user.present?

    where.not(id: current_user.id)
  end
end
