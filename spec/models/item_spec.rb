require 'rails_helper'

RSpec.describe Item, type: :model do
  # Убеждаемся, что элемент должен принадлежать к списку.
  it { is_expected.to belong_to :list }

  # Проверяем, что у элемента должно быть обязательное поле с заголовком.
  it { is_expected.to validate_presence_of(:title) }
end