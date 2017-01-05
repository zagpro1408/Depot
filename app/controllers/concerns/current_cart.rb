module CurrentCart

  private

  def set_cart

    # Попытка обнаружения корзины соответствующая данному индефикатору
    @cart = Cart.find(session[:cart_id])

    # Если запись корзины не найдена( индификатор не будет подходить или nil )
    # То приступит к созданию нового объекта Cart
    rescue ActiveRecord::RecordNotFound

    # Создание объекта Cart
    @cart = Cart.create
    # Сохранение id корзины в сессию
    session[:cart_id] = @cart.id
  end

end
