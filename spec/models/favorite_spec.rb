require 'rails_helper'

RSpec.describe Favorite, type: :model do
  # user_idがないと無効な状態であること
  it { is_expected.to validate_presence_of :user_id }
  # question_idがないと無効な状態であること
  it { is_expected.to validate_presence_of :question_id }
end
