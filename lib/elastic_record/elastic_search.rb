module ElasticRecord
  module ElasticSearch
    def self.included(base) #:nodoc:
      base.class_eval do
        include Flex::ActiveModel
      end
    end
  end
end

