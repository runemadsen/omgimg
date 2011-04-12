set :database, 'mysql://root:Enurmadsen1@localhost/omgimg'

class Image < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  has_many :images, :as => :commentable
end

class User < ActiveRecord::Base
  has_many :images
end