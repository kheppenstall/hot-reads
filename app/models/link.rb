class Link < ApplicationRecord
  validates :url, presence: true, uniqueness: true
  validates :read_count, presence: true

  def add_read
    update(read_count: read_count + 1)
  end
end
