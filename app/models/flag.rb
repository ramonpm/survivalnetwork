class Flag < ApplicationRecord
  belongs_to :reporter, class_name: 'Survivor', foreign_key: 'reporter_id', validate: true
  belongs_to :infected, class_name: 'Survivor', foreign_key: 'infected_id', validate: true

  after_create :mark_infected

  validates :reporter, uniqueness: { scope: :infected }

  def mark_infected
    if infected.flags.size >= 3
      infected.infected = true
      infected.save!
    end
  end
end
