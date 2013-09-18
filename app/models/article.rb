class Article < ActiveRecord::Base
  before_save :generate_slug

  validates :title, presence: true
  validates :slug, allow_blank: true, format: {
    with: /\A[-a-z]+[^-]\z/,
    message: "Only lower letters and - allowed"
  }

  def to_param
    return id if slug.empty?

    [id, slug].join('-')
  end

  private
    def generate_slug
      self.slug = self.title.parameterize if slug.empty?
    end
end
