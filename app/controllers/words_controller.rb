class WordsController < ApplicationController
  before_action :find_word,
                only: [:edit, :update, :destroy, :find_translation, :show]
  before_action :logged_in_user,  only: [:edit, :update, :destroy, :create, :new]
  before_action :admin_user,      only: :destroy

  def index
    if params[:tag]
      @words = Word.tagged_with(params[:tag]).ordered.group_by{ |word| word.title[0].upcase }
      @tag = params[:tag]
    else
      @words = Word.ordered.group_by { |word| word.title[0].upcase }
    end
  end

  def index_by_language
    @words =
      Word
      .language(params[:lang]).ordered.group_by { |word| word.title[0].upcase }
    return redirect_to words_path if @words.empty?
    render :index
  end

  def show
    @translations = @word.translations
    @languages =
      Language.where
      .not(code: @word.translations
                 .collect { |translation| translation.language.code }
                 .push(@word.language.code))
    render :show
  end

  def find_translation
    @lang = Language.find_by(code: params[:lang].upcase)
    return redirect_to word_path(@word) unless @lang || @word.language != @lang
    @translated_word = @word.translations.find_by(language: @lang)
    return redirect_to word_path(@translated_word) if @translated_word
    @word_to_translate = @word
    @word = Word.new language: @lang
    render :new
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new require_params
    if @word.save!
      create_translation
      redirect_to @word, flash: { success: 'Word created.' }
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

  def update
    if @word.update(require_params)
      redirect_to @word, flash: { success: 'Word updated!' }
    else
      render :edit
    end
  end

  def destroy
    @word.destroy
    redirect_to words_path, flash: { success: 'Word deleted!' }
  end

  def find_word
    @word = Word.find_by(slug: params[:id])
    return redirect_to search_words_path(query: params[:id]) unless @word
  end

  def require_params
    params.require(:word).permit(:title, :body, :language_id, :tag_list)
  end

  private :find_word, :require_params, :create_translation

  def admin_user
    unless current_user.role > 0
      flash.now[:danger] = 'You have to be an Administrator.'
      render 'edit'
    end
  end

end
