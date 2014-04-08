# ElasticRecord

ActiveModel API for ElasticSearch based records

## Installation

Add this line to your application's Gemfile:

    gem 'elastic_record'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elastic_record

## Usage

In the source ActiveRecord source class:

    class Brand < ActiveRecord::Base
        include Tire::Model::Search
        include Tire::Model::Callbacks
        
        #make sure the index names match
        index_name "index-name-#{Rails.env}"
        
        mapping do
            indexes :id, type: 'integer'
            indexes :name, type: 'string', index: 'not_analyzed'
            indexes :status, type: 'string', index: 'not_analyzed'
        end
        
        def to_indexed_json
            {
                id: id,
                name: name,
                status: status
            }.to_json
            #or if you have a serializer
            #BrandSerializer.new(self).to_json
        end
        
In the ElasticRecord client class

    class Brand
        include ElasticRecord::ReadOnly
        
        #make sure the index names match
        source "index-name-#{Rails.env}"
        
        #optional - define the fields you're interested in
        #fields :id, :name

Queries:

    Brand.find(1) #find a single record by id
    
    Brand.find([1,2,3]) #find multiple brands by id
    
    Brand.where(name: "Gap") #find by attribute

## Contributing

1. Fork it ( http://github.com/<my-github-username>/elastic_record/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
