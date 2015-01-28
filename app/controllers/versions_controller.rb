class VersionsController < ApplicationController
  before_action :admin_user, only: :revert

  def index
    @word = Word.find(params[:id])
    @versions = @word.versions
  end

  def revert
    @version = PaperTrail::Version.find(params[:version_id])
    if @version.reify.save!
      redirect_to word_path(@version.item),
                  flash: { success: "Word «#{@version.item.title}» reverted." }
    else
      redirect_to versions_word_path,
                  flash: { danger: 'Word could not be reverted.' }
    end
  end
end
