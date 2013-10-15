module ArticlesHelper
  def draft?
    params[:status] == 'draft'
  end

  def trash?
    params[:status] == 'trash'
  end

  def published?
    params[:status] == 'published'
  end

  def not_published
    not published?
  end
end
