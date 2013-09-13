class Article < ActiveRecord::Base
  before_save :create_url

  validates :title, presence: true
  validates :url, allow_blank: true, format: {
    with: /\A[-a-z]+[^-]\z/,
    message: "Only lower letters and - allowed"
  }

  def to_param
    return id if url.empty?

    "#{id}-#{url}"
  end

  private
    def create_url
      self.url = self.title.parameterize if url.empty?
    end
end
