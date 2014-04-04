module ElasticRecord


  module Model
    def self.included(base)
      base.class_eval do


        class << self
          def source(name)
            flex.index = name
          end


          alias_method :flex_fields, :fields

          @_elastic_model_fields ||= []

          def fields(*attributes)
            @_elastic_model_fields ||= []
            attributes.each do |attr|
              @_elastic_model_fields << attr
              attr_accessor attr

              scope "#{attr}_scope".to_sym do |val|
                terms attr => val
              end
            end
          end

          def create(*args)
            raise(ElasticRecord::ReadOnly, 'records are read only!')
          end


          alias_method :flex_find, :find
          def find(id, *args)
            unless id.to_i > 0
              raise(ArgumentError, 'invalid id')
            end

            find_fields = nil
            unless @_elastic_model_fields.blank?
              find_fields = flex_fields(@_elastic_model_fields)
            end

            result = flex_find(id, find_fields)

            if result.blank?
              raise(ElasticRecord::RecordNotFound, "could not find record with id: #{id}")
            else
              result
            end
          end
          alias_method :create!, :create


          def where(*attrs)
            terms = attrs[0]
            has_keys(terms)

            where_scope = self
            terms.each do |k, v|
              where_scope = where_scope.send("#{k}_scope", v)
            end

            where_scope.all
          end

          def has_keys(attrs)
            attrs.each_key do |key|
              unless @_elastic_model_fields.include?(key.to_sym)
                raise(ElasticRecord::UndefinedField, key)
              end
            end
          end
        end

        def save
          raise(ElasticRecord::ReadOnlyError, 'records are read only!')
        end

        alias_method :save!, :save
      end
    end
  end
end