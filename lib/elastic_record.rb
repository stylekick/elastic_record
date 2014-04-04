require "elastic_record/version"

require 'flex-rails'

module ElasticRecord
  autoload :ElasticSearch,        'elastic_record/elastic_search'
  autoload :Model,                'elastic_record/model'
  autoload :ReadOnly,             'elastic_record/read_only'

  class RecordNotFound < RuntimeError

  end

  class ReadOnlyError < RuntimeError

  end

  class UndefinedField < RuntimeError
  end

end
