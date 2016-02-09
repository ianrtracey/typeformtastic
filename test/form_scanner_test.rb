require 'test_helper'
require 'typeformtastic/form_scanner'
class FormScannerTest < ActiveSupport::TestCase
	
	def setup
		@form = ENV['typeform_test_form']
		@api_key = ENV['typeform_test_api_key']
	end

	# really bad test
	def test_scanner_init
		scanner = Typeformtastic::FormScanner.new(@form, @api_key)
		defs = scanner.definition_scan
		puts defs 
	end




end