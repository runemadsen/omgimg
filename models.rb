DataMapper.setup(:default, 'mysql://user:password@localhost/webdev')
    
class Image

  include DataMapper::Resource

  property :id, Serial
  property :path, String
  property :body, Text
  property :created_at, DateTime
  
end