class ArticlesController < ApplicationController
  def index
    @articles = Article.all #デフォルトではcontrolllerはindexのviewsを表示する
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_path(@article), notice: "保存できたよ" #showページに飛ぶ
    else
      flash.now[:error] = "保存に失敗しました"
      render :new #@articleの中に情報が入ったままrenderするのでnewビューに推移しても文字は入ったままになる
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article), notice: "更新できました"
    else
      flash.now[:error] = "更新できませんでした"
      render :edit
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
