require 'spec_helper'

describe Article do
  it 'has a valid factory' do
    expect(build(:article)).to be_valid
  end

  it 'would generate a slug using title if slug is empty' do
    article = create(:article, slug: '')
    expect(article.slug).to eq(article.title.parameterize)
  end

  describe 'filter by status' do
    before :each do
      @published = create(:published_article)
      @draft = create(:draft_article)
      @trash = create(:trash_article)
    end

    context 'matching published articles' do
      it 'returns a sorted array of articles that match' do
        expect(Article.published).to eq([@published])
      end
    end

    context 'matching draft articles' do
      it 'returns a sorted array of articles that match' do
        expect(Article.draft).to eq([@draft])
      end
    end

    context 'matching trashed articles' do
      it 'returns a sorted array of articles that match' do
        expect(Article.trash).to eq([@trash])
      end
    end

    context 'matching all except trashed articles' do
      it 'returns a sorted array of articles that match' do
        expect(Article.not_trash).to eq([@draft, @published])
      end
    end
  end

  describe '.all_by_status' do
    before :each do
      @published = create(:published_article)
      @draft = create(:draft_article)
      @trash = create(:trash_article)
    end

    context 'matching published' do
      it 'returns a sorted array of articles that matches' do
        expect(Article.all_by_status('published')).to eq([@published])
      end
    end

    context 'matching draft' do
      it 'returns a sorted array of articles that matches' do
        expect(Article.all_by_status('draft')).to eq([@draft])
      end
    end

    context 'matching trashed' do
      it 'returns a sorted array of articles that matches' do
        expect(Article.all_by_status('trash')).to eq([@trash])
      end
    end

    context 'without matching filter' do
      it 'returns a sorted array of articles that belongs to published and draft' do
        expect(Article.all_by_status(nil)).to eq([@draft, @published])
      end
    end
  end

  describe 'has status determine method' do
    it '#published?' do
      published = build(:published_article)
      expect(published.published?).to be_true
    end

    it '#draft?' do
      draft = build(:draft_article)
      expect(draft.draft?).to be_true
    end

    it '#trash?' do
      trash = build(:trash_article)
      expect(trash.trash?).to be_true
    end
  end

  it '#to_param' do
    article = create(:article)
    expect(article.to_param).to eq([article.id, article.slug].join('-'))
  end
end
