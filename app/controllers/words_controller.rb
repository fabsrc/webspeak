class WordsController < ApplicationController
  before_action :find_word, only: [:edit, :update, :destroy]
  
  def index
    @words = Word.order('lower(title)').all
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
      redirect_to @word
    else
      render :new
    end
  end
  
  def update
    if @word.update(params.require(:word).permit(:title, :body))
      flash[:message] = "Wort akutalisiert!"
      redirect_to @word
    else
      render :edit
    end
  end
  
  def destroy
    @word.destroy
    redirect_to words_path
  end
  
  private
  def find_word
    @word = Word.find(params[:id])
  end
  
end
