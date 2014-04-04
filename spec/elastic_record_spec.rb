require 'spec_helper'

class StyleSource
  include Tire::Model::Persistence


  property :id
  property :name
end

class Style
  include ElasticRecord::ReadOnly

  fields :id, :name
end

describe 'Elastic Record Module' do

  def refresh_index
    StyleSource.all.each { |style| style.update_index }
    StyleSource.index.refresh
  end

  before(:each) do
    # Create new ES index for each test, giving the index a unique name just to be sure
    StyleSource.document_type('style')

    name = StyleSource.model_name.plural + '_test_' + (Time.now.to_f * 1000000.0).to_i.to_s
    StyleSource.index_name(name)
    StyleSource.create_elasticsearch_index

    Style.flex.index = name
  end

  after(:each) do
    # Delete the index after each test
    StyleSource.index.delete
    sleep(1)
  end


  describe 'reading from the database' do
    before(:each) do
      StyleSource.create(id: 6, name: 'first')
      StyleSource.create(id: 7, name: 'second')
      sleep(1)
    end


    describe '.find' do
      context 'matching record found' do
        it 'returns the matching record' do
          expect(Style.find(6).name).to eq 'first'
        end
      end

      context 'no matching record found' do
        it 'throws an error' do
          expect{Style.find(1)}.to raise_error ElasticRecord::RecordNotFound
        end
      end
    end

    describe '.where', focus: true do
      context 'when a property does not exist' do
        it 'throws an error' do
          expect{Style.where(abc: 'def', id: 14)}.to raise_error ElasticRecord::UndefinedField
        end
      end

      context 'when the properties exist' do
        it 'returns the matching records from id' do
          expect(Style.where(id: [6, 7]).map(&:id)).to match_array [6,7]
        end

        it 'returns the matching records from another property' do
          expect(Style.where(name: 'second').map(&:name)).to eq ['second']
        end

        it 'returns an empty collection when there are search results' do
          expect(Style.where(name: 'not found').map(&:name)).to eq []
        end
      end
    end

    describe '.all' do
    end

    describe '.find_in_batches' do
    end

    describe '.count' do
      it 'returns the number of matching records' do
        expect(Style.count).to eq 2
      end
    end

  end



  describe 'dynamic finders' do
  end

  describe 'has_many'

  describe 'has_one'
end