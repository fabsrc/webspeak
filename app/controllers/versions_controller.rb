class VersionsController < ApplicationController
  def index
    word = Word.find_by_slug(params[:id])
    @title = word.title
    @versions = word.versions
  end

  def revert
    @version = Word.find(params[:id]).versions.find(params[:version_id])
    if @version.reify.save!
      redirect_to word_path(@version.item),
                  flash: { success: '"Word reverted.' }
    else
      redirect_to versions_word_path,
                  flash: { danger: 'Word could not be reverted.' }
    end
  end
end
