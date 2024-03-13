require 'rails_helper'

RSpec.describe "Api::Lists", type: :request do
  # Создание пользователя, доски и списков перед тестом
  let(:user) { create(:user) }
  let(:board) { create(:board, user: user) }
  let(:lists) { create_list(:list, 3, board: board) }

  # Создание элементов для каждого списка перед каждым тестом
  before do
    lists.each_with_index do |list, index|
      create_list(:item, 2, list: list, title: "item #{index + 1}")
    end
  end

  describe "GET index" do
    # Успешный запрос должен возвращать статус успешного выполнения и ожидаемое количество списков и элементов в каждом списке
    it "succeeds" do
      get api_board_lists_path(board)
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response.dig("data").size).to eq(3) # Ожидаем 3 списка
      json_response.dig("data").each do |list_data|
        expect(list_data.dig("attributes", "items", "data").size).to eq(2) # Ожидаем 2 элемента в каждом списке
      end
    end
  end
end
