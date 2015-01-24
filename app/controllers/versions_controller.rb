class VersionsController < ApplicationController
  def index
    word = Word.find_by_slug(params[:id])
    @title = word.title
    @versions = word.versions
  end

  def revert
    @version = Word.find_by_slug(params[:id]).versions.find(params[:version_id])
    if @version.reify.save!
      flash[:success] = 'Word reverted.'
      redirect_to word_path(@version.item)
    else
      flash[:danger] = 'Word could not be reverted.'
      redirect_to versions_word_path
    end
  end
end
