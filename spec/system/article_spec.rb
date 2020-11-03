require 'rails_helper'

RSpec.describe 'Article', type: :system do
  let!(:user) { create(:user) }
  let!(:articles) { create_list(:article, 3, user: user) }
  it '記事一覧が表示される' do
    visit root_path #visit 指定されているページを開く
    articles.each do |article|
      expect(page).to have_css('.card_title', text: article.title)
    end
  end
  it '記事の詳細を表示できる' do
    visit root_path
    article = articles.first
    click_on article.title
    expect(page).to have_css('.article_title', text: article.title)
    expect(page).to have_css('.article_content', text: article.content.to_plain_text)
  end
end
#have_contentで指定したインスタンスがあるのか？判断する
#have_css クラスを指定してそのテキストがあっているか判断できる。have_contentより正確にテストができる
#click_on 指定した文字列を探してクリックしてくれる。だがaタグにしか使えない
