require 'rails_helper'

RSpec.describe Survivor, type: :model do
  it { should have_many(:resources) }
end
