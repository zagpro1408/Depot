require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderMailer.received(orders(:one))
    assert_equal "Подтверждение заказа в Pragmatic Store", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from
  end

  test "shipped" do
    mail = OrderMailer.shipped(orders(:one))
    assert_equal "Заказ из Pragmatic Store отправлен", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from
  end

end
