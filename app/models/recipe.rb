class Recipe < ApplicationRecord
	has_one :dish

	def step_by_step
		# byebug
		self.directions.map do |step|
			step.details
		end
	end
end
