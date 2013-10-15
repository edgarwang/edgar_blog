class Article < ActiveRecord::Base
  before_save :generate_slug

  validates :title, presence: true
  validates :slug, allow_blank: true, format: {
    with: /\A[-a-z]+[^-]\z/,
    message: "Only lower letters and - allowed"
  }

  scope :trash,     -> { where(status: 'trash') }
  scope :draft,     -> { where(status: 'draft') }
  scope :published, -> { where(status: 'published') }

  # Select all element with specific status
  def self.all_by_status(status)
    case status
    when 'published'
      return published
    when 'draft'
      return draft
    when 'trash'
      return trash
    else
      return all
    end
  end

  # 3 methods to determine article's status
  def draft?
    status == 'draft'
  end
  def published?
    status == 'published'
  end
  def trash?
    status == 'trash'
  end

  def to_param
    return id if slug.empty?

    [id, slug].join('-')
  end

  def html_content
    render_markdown(self.content)
  end

  private
    def generate_slug
      self.slug = self.title.parameterize if slug.empty?
    end
end
