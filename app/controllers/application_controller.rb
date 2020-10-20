class ApplicationController < ActionController::Base
  def current_user
    ActiveDecorator::Decorator.instance.decorate(super) if super.present?
    super
  end
end
#インスタンスにdecorateを実行するとactivedecoratorが使えるようになる
#superはcurrent_userの継承元である