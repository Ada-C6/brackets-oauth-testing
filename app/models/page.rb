class Page < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :user_id, presence: true

  def self.by_date
    order(:created_at).reverse
  end
end
