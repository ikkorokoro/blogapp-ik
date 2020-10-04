class ArticlesController < ApplicationController
    def index
        @articles = Article.all#デフォルトではcontrolllerはindexのviewsを表示する
      end

      def show
        @article = Article.find(params[:id])
      end
    end