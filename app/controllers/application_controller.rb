class ApplicationController < ActionController::Base
  before_action :set_lacale#applicationcontorollerに書くことで全てのコントローラに対して実行される

  def current_user
    ActiveDecorator::Decorator.instance.decorate(super) if super.present?
    super
    #インスタンスにdecorateを実行するとactivedecoratorが使えるようになる
    #superはcurrent_userの継承元である
  end

  def default_url_options
    { locale: I18n.locale }#クリックするとデフォルトでurlが/?local=jaまたはenになる
  end

  private

  def set_lacale#設定言語を設定する
    I18n.locale = params[:locale] || I18n.default_locale
  end# /?locale=jaで日本語にenで英語に切り替わる
end

#I18n.localeを書き換えることで日本語と英語に切り替わる
#I18n.locale = :ja 日本語
#I18n.locale = :en 英語

#parameterについて
#/articles?id=1 => params[:id]が取得できる
#?を入れることでroutes.rbに設定しなくてもurlを作成できる