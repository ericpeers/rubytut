class ArticlesController < ApplicationController
  def new
    #so that I get a legit article when I render my form on new. (same form used for create failure)
    @article = Article.new
  end

  http_basic_authenticate_with name: "ejp", password: "secret",
                               except: [:index, :show]
  #show all the articles
  def index
    @articles = Article.all
  end


  def create
    #create a new article, save it, render it.
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end

    #render plain: params[:article].inspect
  end

  def show
    @article = Article.find(params[:id])
  end

  #grab an article for updating it.
  def edit
    @article = Article.find(params[:id])

  end

  def update
    @article = Article.find(params[:id]) #this auto-404's if it's not found.
    #this could happen if the article was deleted concurrent with the edit, or if someone passes and edit
    #for an article that is not present. You can manually cause this by deleting the article in SQL.

    #if not defined? @article
    #  raise ActiveRecord::RecordNotFound
    #end

    if @article.update(article_params)
      redirect_to @article
    else
      #no good - failed to update (failed our checks in the model). So go rerender the edit page.
      render 'edit'
    end

  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path

  end



  private
  def article_params
    #choose what the allowed params are.
    params.require(:article).permit(:title, :text)
  end



end
