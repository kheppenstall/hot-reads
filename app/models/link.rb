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
end
