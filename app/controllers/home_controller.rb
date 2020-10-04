class HomeController < ApplicationController #< ApplicationControllerBase
  def index 
    @article = Article.first
    #デフォルトではcontrolllerはindexのviewsを表示する
  end

  def about
    # デフォルトではrender 'home/about'が呼ばれるので記述しなくてもいい
  end
end