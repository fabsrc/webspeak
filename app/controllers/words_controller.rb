class WordsController < ApplicationController
  before_action :find_word, only: [:edit, :update, :destroy]

  def index
    @title = "Webspeak"
    @words = Word.ordered.group_by{ |w| w.title[0].upcase }
  end
  
  def index_by_language
    language = Language.find_by_code(params[:lang].upcase)
    @words = Word.language(params[:lang]).ordered.group_by{ |w| w.title[0].upcase }
    if !@words.empty?
      render :index
    else
      redirect_to words_path
    end
  end

  def _search
    if params[:query].present?
      redirect_to words_path + "#{ URI.escape(params[:query]) }"
    else
      redirect_to words_path
    end
  end

  def _autocomplete
    render json: Word.search(params[:query], autocomplete: true, limit: 10).as_json(only: [:title])
  end

  def show
    if @word = Word.find_by_slug(params[:id])
      @title = @word.title
      @translations = @word.translations + @word.translation_of
      translation_codes = @translations.map{ |t| t.language.code }
      translation_codes.push @word.language.code
      @languages = Language.where.not(code: translation_codes).all
      render :show
    else
      search_for_words
    end
  end

  def search_for_words
    @words = Word.search(params[:id], fields: [:title, :slug])
    @title = params[:id].gsub("_", "\s")
    if @words.count == 1
      @word = @words.first
      redirect_to @word
    elsif @words.count > 1
      @words = @words.group_by{ |u| u.title[0].upcase }
      render :index
    else
      @word = Word.new
      render :new
    end
  end

  def get_translation
    if !@word = Word.find_by_slug(params[:id])
      return redirect_to(action: 'show')
    end
    if !@lang = Language.find_by_code(params[:lang].upcase)
      return redirect_to word_path(@word)
    end
    if @word.language === @lang
      return redirect_to word_path(@word)
    end
    if @translated_word = @word.translations.find_by_language_id(@lang.id) || @word.translation_of.find_by_language_id(@lang.id)
      redirect_to @translated_word
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
    @word = Word.new get_params

    if @word.save
      create_translation
      flash[:success] = "Wort erstellt!"
      redirect_to @word
    else
      render :new
    end
  end

  def create_translation
    if translation_of = params.require(:word)[:translation_of]
      word_to_translate = Word.find(translation_of)
      word_to_translate.translations<< @word
    end
  end

  def edit
    @title = @word.title
  end

  def update
    if @word.update(get_params)
      flash[:success] = "Wort aktualisiert!"
      redirect_to @word
    else
      render :edit
    end
  end

  def destroy
    @word.destroy
    flash[:success] = "Wort gelöscht!"
    redirect_to words_path
  end


  def find_word
    @word = Word.find(params[:id])
  end

  def get_params
    params.require(:word).permit(:title, :body, :language_id)
  end

  private :search_for_words, :find_word, :get_params, :create_translation
end