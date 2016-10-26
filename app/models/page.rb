class Page < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :user_id, presence: true

  before_create :log_to_console

  def self.by_date
    order(:created_at).reverse
  end

private
  def log_to_console
    puts ">>>>>DPR!!!!!"
  end
end
