require 'rails_helper'

RSpec.describe "Items", type: :request do
  let(:user) { create(:user) }
  let(:board) { create(:board, user: user) }
  let(:list) { create(:list, board: board) }
  let(:item) { create(:item, list: list) }

  before do
    sign_in user
  end

  describe "GET new" do
    # Проверка успешности запроса на создание нового элемента списка
    it "succeeds" do
      get new_list_item_path(list)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET edit" do
    # Проверка успешности запроса на редактирование элемента списка
    it "succeeds" do
      get edit_list_item_path(list, item)
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "POST create" do
    context "with valid params" do
      # Создание нового элемента списка с корректными данными
      it "creates a new item and redirects" do
        expect do
          post list_items_path(list), params: {
            item: {
              title: "New Item",
              description: "Description"
            }
          }
        end.to change { Item.count }.by(1)
        expect(response).to have_http_status(:redirect)
      end
    end

    context "with invalid params" do
      # Создание нового элемента списка с некорректными данными
      it "does not create a new item and renders new" do
        expect do
          post list_items_path(list), params: {
            item: {
              title: ""
            }
          }
        end.not_to change { Item.count }
        expect(response).to have_http_status(:success)
      end
    end
  end
  
  describe "PUT update" do
    context "with valid params" do
      # Обновление элемента списка с корректными данными
      it "updates the item and redirects" do
        expect do
          put list_item_path(list, item), params: {
            item: {
              title: "Updated Item"
            }
          }
        end.to change { item.reload.title }.to("Updated Item")          
        expect(response).to have_http_status(:redirect)
      end
    end

    context "with invalid params" do
      # Обновление элемента списка с некорректными данными
      it "does not update the item and renders edits" do
        expect do
          put list_item_path(list, item), params: {
            item: {
              title: ""
            }
          }
        end.not_to change { item.reload.title }
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "DELETE destroy" do
    # Удаление элемента списка
    it "deletes the item record" do
      item
      expect do
        delete list_item_path(list, item), headers: { 'ACCEPT': 'application/json' }
      end.to change { Item.count }.by(-1)
      expect(response).to have_http_status(:success)
    end
  end
end