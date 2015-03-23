class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true

  after_create :send_favorite_emails

  default_scope { order('updated_at DESC') }

  private

  def send_favorite_emails
    # for every favorite associated with post, send email
    self.post.favorites.each do |fav|
      # If this isn't the person who made the comment AND they want to get emails for favorites
      if fav.user_id != self.user_id && fav.user.email_favorites?
        FavoriteMailer.new_comment(fav.user, self.post, self).deliver
      end
    end
  end
end
