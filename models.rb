set :database, 'mysql://root:Enurmadsen1@localhost/omgimg'

class Discussion < ActiveRecord::Base
  has_one :image, :as => :commentable
end

class Image < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  has_one :image, :as => :commentable
end

class User < ActiveRecord::Base
  has_many :images
end