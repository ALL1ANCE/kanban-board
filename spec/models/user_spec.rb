require 'rails_helper'

RSpec.describe User, type: :model do
  # Убеждаемся, что у пользователя должно быть много досок и они должны удаляться при удалении пользователя.
  it { is_expected.to have_many(:boards).dependent(:destroy) }
end
