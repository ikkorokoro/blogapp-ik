class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content
end
#jem serualizerを使うことでjsonでactiverecordに関するインスタンスを渡すことができる
