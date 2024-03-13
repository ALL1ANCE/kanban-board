require 'rails_helper'

RSpec.describe Board, type: :model do
  # Убеждаемся, что Board должна принадлежать к пользователю.
  it { is_expected.to belong_to :user }

  # Проверяем, что у доски должно быть обязательное поле с именем.
  it { is_expected.to validate_presence_of(:name) }

  # Убеждаемся, что у доски есть много списков и они удаляются при удалении доски.
  it { is_expected.to have_many(:lists).dependent(:destroy) }
end