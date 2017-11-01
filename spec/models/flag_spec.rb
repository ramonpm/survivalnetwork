require 'rails_helper'

RSpec.describe Flag, type: :model do
  it { should belong_to(:reporter) }
  it { should belong_to(:infected) }
end
