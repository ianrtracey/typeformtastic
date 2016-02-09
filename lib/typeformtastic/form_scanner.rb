require 'net/http'
require 'json'

module Typeformtastic

	class FormScanner


		def initialize(form, api_key, offset=0, is_completed=true)
			@form = form
			@offset = offset
			@api_key = api_key
			@is_completed = is_completed
			@definitions = {}
		end

		def definition_scan
			uri = URI("https://api.typeform.com/v0/form/#{@form}?key=#{@api_key}&completed=#{@is_completed}&offset=#{@offset}")
			response = Net::HTTP.get(uri)
			form = JSON.parse(response)
			build_definitions(form['questions'])
			return @definitions
		end

	private
		def build_definitions(form_questions)
			form_questions.each do |q|
				
				id = q['id']
				type = q['id'].split('_')[0]
				question = q['question']

				if type == "list"
					@definitions = build_list(id, @definitions)
					next
				end

					@definitions[id.split('_')[1..id.size].join('_')] = nil

			end

		end

		def build_list(list_id, definitions)
			parent_id = list_id.split('_')[1]
			id = list_id.split('_')[2..list_id.size]
			
			if !definitions.has_key? parent_id
				definitions[parent_id] = {}
				definitions[parent_id][id.join("_")] = nil
				return definitions
			end

			definitions[parent_id][id.join("_")] = nil
			return definitions

		end

	end
end