require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  test "buying a product" do
    # Возьмем число существующих заказов, для начальной точки отсчета
    start_order_count = Order.count
    ruby_book = products(:ruby)

    # Пользователь заходит на странице каталога магазина
    get "/"
    assert_response :success
    assert_select 'h1', "Your Pragmatic Catalog"

    # Пользователь выбирает товар, добавляя его в свою корзину
    post '/line_items', params: { product_id: ruby_book.id }, xhr: true
    assert_response :success
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product

    # Пользователь оформляет заказ
    get '/orders/new'
    assert_response :success
    assert_select 'legend', "Please Enter Your Details"

    # Пользователь оформил заказ
    post "/orders", params: {
      order: {
        name:     "Dave Thomas",
        address:  "123 The Street",
        email:    "dave@example.com",
        pay_type: "Check"
      }
    }

    follow_redirect!

    assert_response :success
    assert_select 'h1', "Your Pragmatic Catalog"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    # Проверяем то, что заказ добавился в БД правильно
    assert_equal start_order_count + 1, Order.count
    order = Order.last

    assert_equal "Dave Thomas", order.name
    assert_equal "123 The Street", order.address
    assert_equal "dave@example.com", order.email
    assert_equal "Check", order.pay_type

    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product
  end
end
