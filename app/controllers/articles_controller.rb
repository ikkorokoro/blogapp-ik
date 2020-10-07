class ArticlesController < ApplicationController
  before_action :set_article,only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy] 


  def index
    # raise StandardError#強制的にエラーを起こす
    @articles = Article.all #デフォルトではcontrolllerはindexのviewsを表示する
  end

  def show

  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_path(@article), notice: '保存できたよ' #showページに飛ぶ
    else
      flash.now[:error] = '保存に失敗しました'
      render :new #@articleの中に情報が入ったままrenderするのでnewビューに推移しても文字は入ったままになる
    end
  end

  def edit

  end

  def update

    if @article.update(article_params)
      redirect_to article_path(@article), notice: '更新できました'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  def destroy
    article = Article.find(params[:id])
    if article.destroy! #! 削除されない場合エラーを発生させる。
      redirect_to root_path, notice: '削除に成功しました'
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :content)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
