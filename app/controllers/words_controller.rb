class WordsController < ApplicationController
  before_action :find_word, only: [:edit, :update, :destroy]

  def index
    @title = 'Webspeak'
    @words = Word.ordered.group_by { |word| word.title[0].upcase }
  end

  def index_by_language
    @words = Word.language(params[:lang].upcase).ordered.group_by { |word| word.title[0].upcase }
    if !@words.empty?
      render :index
    else
      redirect_to words_path
    end
  end

  def _search
    query = params[:query]
    if query.present?
      redirect_to words_path + "#{ URI.escape(query) }"
    else
      redirect_to words_path
    end
  end

  def _autocomplete
    render json: Word.search(
      params[:query],
      autocomplete: true,
      limit: 10).as_json(only: [:title])
  end

  def show
    @word = Word.find_by_slug(params[:id])
    if @word
      @title = @word.title
      @translations = @word.translations
      @languages = Language.where
                           .not(code: @word.translations
                           .collect { |translation| translation.language.code }
                           .push(@word.language.code))
      render :show
    else
      search_for_words
    end
  end

  def search_for_words
    slug = params[:id]
    @words = Word.search(slug, fields: [:title, :slug])
    if @words.count == 1
      @word = @words.first
      redirect_to @word
    elsif @words.count > 1
      @words = @words.group_by { |word| word.title[0].upcase }
      render :index
    else
      @word = Word.new
      flash[:info] = 'Word doesn\'t exist. Create it now!'
      render :new
    end
  end

  def find_translation
    unless (@word = Word.find_by_slug(params[:id]))
      return redirect_to(action: 'show')
    end
    unless (@lang = Language.find_by_code(params[:lang].upcase))
      return redirect_to word_path(@word)
    end
    if (@translated_word = @word.translations.find_by_language_id(@lang))
      return redirect_to word_path(@translated_word)
    elsif @word.language == @lang
      return redirect_to word_path(@word)
    else
      @word_to_translate = @word
      @word = Word.new language: @lang
      render :new
    end
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new require_params
    if @word.save
      create_translation
      flash[:success] = 'Word created.'
      redirect_to @word
    else
      render :new
    end
  end

  def create_translation
    translation_of = params.require(:word)[:translation_of]
    return false unless translation_of
    word_to_translate = Word.find(translation_of)
    word_to_translate.translations << @word
    @word.translations << word_to_translate
  end

  def edit
    @title = @word.title
  end

  def update
    if @word.update(require_params)
      flash[:success] = 'Word updated.'
      redirect_to @word
    else
      render :edit
    end
  end

  def destroy
    @word.destroy
    flash[:success] = 'Word deleted.'
    redirect_to words_path
  end

  def find_word
    @word = Word.find(params[:id])
  end

  def require_params
    params.require(:word).permit(:title, :body, :language_id)
  end

  private :search_for_words, :find_word, :require_params, :create_translation
end
