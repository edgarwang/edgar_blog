class Article < ActiveRecord::Base
  before_save :create_url

  def to_param
    return id if url.empty?

    "#{id}-#{url}"
  end

  private
    def create_url
      self.url = self.title.parameterize if url.empty?
    end
end
