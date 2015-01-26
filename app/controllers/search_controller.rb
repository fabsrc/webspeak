class SearchController < ApplicationController
  def search
    return redirect_to words_path unless params[:query].present?
    @words = Word.search(params[:query], fields: [:title, :slug])
    return redirect_to @words.first if @words.count == 1
    if @words.count == 0
      return redirect_to new_word_path, flash: { info:
        "Word #{params[:query]} doesn\'t exist. Create it now!" }
    end
    show_results(@words)
  end

  def show_results(results)
    @words =
      results
      .sort_by { |word| word.title.downcase }
      .group_by { |word| word.title[0].upcase }
    render 'words/index'
  end

  def autocomplete
    render json: Word.search(
      params[:query],
      autocomplete: true,
      limit: 10).as_json(only: [:title])
  end
end
