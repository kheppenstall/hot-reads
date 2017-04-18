class Link < ApplicationRecord
  validates :url, presence: true, uniqueness: true
  validates :read_count, presence: true

  def add_read
    update(read_count: read_count + 1)
  end

  def self.top_ten
    Link.all.sort_by do |link|
      link.read_count
    end.reverse[0..9]
  end

  def status
    top_ten = self.class.top_ten
    if self == top_ten.first
      'top read'
    elsif self.in?(top_ten)
      'hot read'
    else
      'not hot'
    end
  end
end
