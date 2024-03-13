require 'rails_helper'

RSpec.describe List, type: :model do
  # Убеждаемся, что список должен принадлежать к доске.
  it { is_expected.to belong_to :board }

  # Проверяем, что у списка должно быть много элементов, и они должны удаляться при удалении списка.
  it { is_expected.to have_many(:items).dependent(:destroy) }

  # Проверяем, что у списка должно быть обязательное поле с заголовком.
  it { is_expected.to validate_presence_of(:title) }
end