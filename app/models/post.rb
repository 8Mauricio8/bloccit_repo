 class Post < ActiveRecord::Base
  has_many:comments
   belongs_to :user
   has_one :summary
   belongs_to :topic
   default_scope { order('created_at DESC') }
   
   validates :title, length: { minimum: 5 }, presence: true
   validates :body, length: { minimum: 20 }, presence: true
   validates :topic, presence: true
   validates :user, presence: true

  # def self.ordered
     # order('created_at DESC')
   #end
   
   #def self.recent
    # where('created_at > ?', 7.days.ago)
  # end
end
