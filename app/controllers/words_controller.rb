class WordsController < ApplicationController
  before_action :find_word, only: [:edit, :update, :destroy]
  
  def index
    @title = "Webspeak"
    @words = Word.ordered
  end
  
  def _search
    if params[:query].present?
      redirect_to words_path + "#{URI.escape(params[:query])}"
    else
      redirect_to words_path
    end
  end
  
  def _autocomplete
      render :json => Word.search(params[:query], autocomplete: true, limit: 10).as_json(only: [:title])
  end
  
  def show
    if @word = Word.find_by_slug(params[:id])
      @title = @word.title
      render :show
    else
      switch
    end
  end
  
  def switch
    @words = Word.search(params[:id], fields: [:title, :slug])
    @title = params[:id].gsub("_", "\s")
    if @words.count == 1
      @word = @words.first
      if @word.slug == params[:id]
        @title = @word.title
        render :show
      else
        redirect_to @word
      end
    elsif @words.count > 1
      render :index
    else
      @word = Word.new
      render :new
    end
  end
  
  def translation
    if((@word = Word.find_by_slug(params[:id])) && (@lang = Language.find_by_code(params[:lang])))
      if @word.language == @lang
        redirect_to @word
      elsif @translated_word = @word.translations.find_by_language_id(@lang.id) || @word.translation_of.find_by_language_id(@lang.id)
        redirect_to @translated_word
      else
        @word_to_translate = @word
        @word = Word.new language: @lang
        render :new
      end
    else
      redirect_to words_path + "#{URI.escape(params[:id])}"
    end
  end

  def new
    @word = Word.new
  end
  
  def create
    if @translation_of = params.require(:word)['translation_of']
      @word = Word.find(@translation_of)
      @word.translations.build get_params
    else
      @word = Word.new get_params
    end
    
    if @word.save
      flash[:success] = "Wort erstellt!"
      redirect_to @word
    else
      render :new
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
  
  private
  def find_word
    @word = Word.find(params[:id])
  end
  
  def get_params
    params.require(:word).permit(:title, :body, :language_id)
  end
  
end
