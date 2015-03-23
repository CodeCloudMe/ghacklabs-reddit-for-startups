class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable
        # :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  has_many :posts
  has_many :comments
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  def self.top_rated
    self.select( 'users.*' ). # Select all attributes of the user
        select( 'COUNT(DISTINCT comments.id) AS comments_count' ). # Create new "column" where we count the distinct comments
        select( 'COUNT(DISTINCT posts.id) AS posts_count' ). # Create another column for posts
        select( 'COUNT(DISTINCT comments.id) + COUNT(DISTINCT posts.id) AS rank' ). # Another column where we add them together to sort
        joins( 'LEFT OUTER JOIN posts ON posts.user_id = users.id' ). # Need to join posts to count them
        joins( 'LEFT OUTER JOIN comments ON comments.user_id = users.id' ). # Join comments to count them
        group( 'users.id' ). # Tell Postgres how we want to group them together so it knows what to combine into "one" row
        order( 'rank DESC' ) # How to sort them
  end

  def role?(base_role)
    role == base_role.to_s
  end

  def favorited( post )
    self.favorites.where( post_id: post.id ).first
  end

  def voted( post )
    self.votes.where( post_id: post.id ).first
  end

end
