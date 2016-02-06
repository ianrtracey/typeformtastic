namespace :sync do
  task execute: :environment do
require 'net/http'
require 'json'

def get_options_array(questions, answer, type)
	answers = []
	type_questions = questions.select{|x| x['group'] == "group_13632155" && x['question'].include?(type) }
	type_questions.each do |q|
		answers << answer[q['id']]
	end
	return answers.reject { |str| str.empty? } 
end

def save_response(response, questions)
	answer = response['answers']
	if !answer.nil?
	if !Hacker.exists?(:email => answer['email_13632193'])
	Hacker.create(
		:first_name => answer['textfield_13632184'],
		:last_name => answer['textfield_13632185'],
		:email => answer['email_13632193'],
		:hireable => answer['yesno_13632174'] == "1" ? true : false,
		:returner => answer['yesno_13632569'] == "1" ? true : false,
 		:is_over_18 => answer['yesno_13632199'] == "1" ? true : false,
 		:gender => !answer['list_13632165_other'].empty? ? answer['list_13632165_other'] : answer['list_13632165_choice'],
 		:school => answer['textfield_13632159'],
 		:major => answer['textarea_13632171'],
 		:graduation_date => !answer['list_13632166_choice'].empty? ? answer['list_13632166_choice'] : answer['list_13632166_other'],
 		:learn => get_options_array(questions, answer, "learn"),
 		:experience => get_options_array(questions, answer, "experience"),
 		:num_of_hackathons => answer['number_13632164'],
 		:github => answer['website_13632176'],
 		:linkedin => answer['website_13632177'],
 		:resume => answer['fileupload_13632178'],
 		:require_travel_reimbursement => answer['yesno_13632175'] == "1" ? true : false,
 		:emergency_contact_name => answer['textfield_13632160'], 
 		:emergency_contact_number=> answer['textfield_13632161'])
	end
	end
end

def get_form(offset)
	uri = URI()
	response = Net::HTTP.get(uri)
	form = JSON.parse(response)
	return form
end


offset = 0
form = get_form(offset)
while form['responses'].count > 0
	puts form['responses'].count
	form['responses'].each do |response|
			save_response(response, form['questions'])
	end

	offset += 900
	form = get_form(offset)
	puts form['responses'].count
end



  end
end

