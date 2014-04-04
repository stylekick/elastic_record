module ElasticRecord
  module ReadOnly
    def self.included(base)
      base.class_eval do
        include ElasticRecord::ElasticSearch
        include ElasticRecord::Model
      end
    end
  end
end

