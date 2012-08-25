configure :development, :test do
  set :database, 'sqlite://development.db'
end

configure :production do
  db = URI.parse(ENV['DATABASE_URL'])
  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end


class Discussion < ActiveRecord::Base
  has_one :image, :as => :commentable
end

class Image < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  has_many :images, :as => :commentable
end

class User < ActiveRecord::Base
  has_many :images
end