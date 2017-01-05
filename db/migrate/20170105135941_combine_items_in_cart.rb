class CombineItemsInCart < ActiveRecord::Migration[5.0]

  def up
    # Замена нескольких записей для одного и того же товара в корзине одной записью
    Cart.all.each do |cart|
      # Подсчет количества каждого товара в корзине
      sums = cart.line_items.group(:product_id).sum(:quantity)

      sums.each do |product_id, quantity|
        if quantity > 1
          # Удаление отдельных записей
          cart.line_items.where(product_id: product_id).delete_all
          # Замена одной записью
          item = cart.line_items.build(product_id: product_id)
          item.quantity = quantity
          item.save!
        end
      end

    end
  end

end
