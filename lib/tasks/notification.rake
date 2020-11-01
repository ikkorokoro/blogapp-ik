namespace :notification do
  desc "利用者にメールを送付する"
  task :send_emails_from_admin, ["msg"] => :environment do |task, args|
    msg = args["msg"]#argsに引数が渡って来る
    if msg.present?
      NotificationFromAdminJob.perform_later(msg)
    else
      puts '送信できませんでした。メッセージを入力してくてださい。ex. rails notification:send_emails_from_admin\[こんにちは\]'
    end
  end
end
  #ターミナルで以下を実行
  # rake -T    rake設定されているタスクの一覧が出る
  #task作成後 以下のコマンドを実行
  # rails notification:send_emails_from_admin\[こんにちは\]