require 'net/http'
require 'json'

module Typeformtastic

	class FormScanner


		def initialize(form, api_key, offset=0, is_completed=true)
			@form = form
			@offset = offset
			@api_key = api_key
			@is_completed = is_completed
		end

		def definition_scan
			uri = URI("https://api.typeform.com/v0/form/#{@form}?key=#{@api_key}&completed=#{@is_completed}&offset=#{@offset}")
			response = Net::HTTP.get(uri)
			form = JSON.parse(response)
			return form['questions']
		end


		def aggregate_questions(form)
			
		end

	end
end