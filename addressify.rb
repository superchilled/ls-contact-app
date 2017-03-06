# addressify.rb

require 'sinatra/base'

module Sinatra
  module Addressify
    def addressify(contact_data, *fields)
      # perhaps have an optional argument that decides if you want to include or exclude fields
      selected_data = if fields.size > 0
                        select_data(contact_data, fields)
                      else
                        contact_data
                      end
      cleaned_data = clean_data(selected_data)
      markup_data(cleaned_data)                
    end

    private

    def select_data(data, fields)
      # add a process here to remove any values from 'fields' which aren't in contact_data
      selected_data = {}
      fields.each do |field|
        selected_data[field] = data[field]
      end
      selected_data
    end

    def clean_data(data)
      data.reject do |k, v|
        !v || v == ''
      end
    end

    def markup_data(data)
      data.values.join('<br/>')
    end
  end

  helpers Addressify
end

# perhaps allow users to set default args in a configure block?
