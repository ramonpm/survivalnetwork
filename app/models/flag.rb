class Flag < ApplicationRecord
  belongs_to :reporter, class_name: 'Survivor', foreign_key: 'reporter_id', validate: true
  belongs_to :infected, class_name: 'Survivor', foreign_key: 'infected_id', validate: true
end
