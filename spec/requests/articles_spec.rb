require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  let!(:user) { create(:user)}
  let!(:articles) { create_list(:article, 3, user: user) }
  describe 'GET /articles' do
    it '200ステータスが帰ってくる' do
      get articles_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /articles' do
    context 'ログインしてる場合' do
      before do
        sign_in user#rapecではsign_in が使えないためrails_helper.rb に記載
      end
      it '記事が保存されてる' do
        article_params = attributes_for(:article)#ハッシュを作成してくれる
        post articles_path({article: article_params})#article: {:title, :content}を作成した
        expect(response).to have_http_status(302)
        expect(Article.last.title).to eq(article_params[:title])
        expect(Article.last.content.body.to_plain_text).to eq(article_params[:content])
        #contentはactiontextを使っているため文字列で保存されていないため上記の書き方をしないと文字列で帰ってこない
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
      article_params = attributes_for(:article)#ハッシュを作成してくれる
      post articles_path({article: article_params})#article: {:title, :content}を作成した
      expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
