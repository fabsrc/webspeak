class WordsController < ApplicationController
  before_action :find_word, only: [:edit, :update, :destroy]
  
  def index
    @words = Word.order('lower(title)').all
  end
  
  def search
    if params[:query].present?
      @words = Word.search(params[:query], fields: [:title])
      render :index
    else
      redirect_to words_path
    end
  end
  
  def autocomplete
      render :json => Word.search(params[:query], autocomplete: true, limit: 10).as_json(only: [:title])
  end
  
  def show
    if @word = Word.find_by_slug(params[:id])
      render :show
    else
      if params[:id].match(/\s/)
        redirect_to word_path(params[:id].gsub("\s", "_"))
      else
        @title = params[:id].gsub("_", "\s")
        @word = Word.new
        render :new
      end
    end
  end

  def new
    @word = Word.new
  end
  
  def create
    @word = Word.new(params.require(:word).permit(:title, :body))
    if @word.save
      flash[:success] = "Wort erstellt!"
      redirect_to @word
    else
      render :new
    end
  end
  
  def update
    if @word.update(params.require(:word).permit(:title, :body))
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
  
end
