class Article < ActiveRecord::Base
  before_save :generate_slug

  validates :title, presence: true
  validates :slug, allow_blank: true, format: {
    with: /\A[a-z1-9][-a-z1-9]+[^-]\z/,
    message: "Only lower letters and - allowed"
  }
  validates :status, inclusion: { in: %w(published draft trash) }

  scope :trash,     -> { where(status: 'trash').order('created_at DESC') }
  scope :draft,     -> { where(status: 'draft').order('created_at DESC') }
  scope :published, -> { where(status: 'published').order('created_at DESC') }
  scope :not_trash, -> { where.not(status: 'trash').order('created_at DESC') }

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
      return not_trash
    end
  end

  # Send an article to trash bin
  def send_to_trash
    self.status = 'trash'
  end

  # Restore an article from trash bin
  def restore
    self.status = 'draft' if self.status == 'trash'
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
    return id.to_s if slug.empty?

    [id, slug].join('-')
  end

  def html_content
    render_markdown(self.content)
  end

  private
    def generate_slug
      self.slug = self.title.parameterize if self.slug.blank?
    end
end
