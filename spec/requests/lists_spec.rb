require 'rails_helper'

RSpec.describe "Lists", type: :request do
  let(:user) { create(:user) }  # Создание тестового пользователя
  let(:board) { create(:board, user: user) }  # Создание доски, принадлежащей пользователю
  let(:list) { create(:list, board: board) }  # Создание списка, принадлежащего доске

  before do
    sign_in user  # Авторизация пользователя
  end

  describe "GET new" do
    it "succeeds" do
      get new_board_list_path(board)  # Запрос на страницу создания нового списка
      expect(response).to have_http_status(:success)  # Проверка успешности запроса
    end
  end

  describe "GET edit" do
    it "succeeds" do
      get edit_board_list_path(board, list)  # Запрос на страницу редактирования списка
      expect(response).to have_http_status(:success)  # Проверка успешности запроса
    end
  end
  
  describe "POST create" do
    context "with valid params" do
      it "creates a new list and redirects" do
        expect do
          post board_lists_path(board), params: {
            list: {
              title: "New List"
            }
          }
        end.to change { List.count }.by(1)  # Проверка успешного создания нового списка
        expect(response).to have_http_status(:redirect)  # Проверка успешного редиректа
      end
    end

    context "with invalid params" do
      it "does not create a new list and renders new" do
        expect do
          post board_lists_path(board), params: {
            list: {
              title: ""
            }
          }
        end.not_to change { List.count }  # Проверка, что список не создан из-за некорректных данных
        expect(response).to have_http_status(:success)  # Проверка успешности запроса
      end
    end
  end

  describe "PUT update" do
    context "with valid params" do
      it "updates the list and redirects" do
        expect do
          put board_list_path(board, list), params: {
            list: {
              title: "Updated List"
            }
          }
        end.to change { list.reload.title }.to("Updated List")  # Проверка успешного обновления списка
        expect(response).to have_http_status(:redirect)  # Проверка успешного редиректа
      end
    end

    context "with invalid params" do
      it "does not update the list and renders edits" do
        expect do
          put board_list_path(board, list), params: {
            list: {
              title: ""
            }
          }
        end.not_to change { list.reload.title }  # Проверка, что список не обновлен из-за некорректных данных
        expect(response).to have_http_status(:success)  # Проверка успешности запроса
      end
    end
  end

  describe "DELETE destroy" do
    it "deletes the list record" do
      list
      expect do
        delete board_list_path(board, list), headers: { 'ACCEPT': 'application/json' }
      end.to change { List.count }.by(-1)  # Проверка успешного удаления списка
      expect(response).to have_http_status(:success)  # Проверка успешности запроса
    end
  end
end
