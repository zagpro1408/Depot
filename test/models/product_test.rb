require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  # Загружает стендовые данные БД :products
  fixtures :products

  # Тест: поля не должны быть пустыми
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  # Тест: цена должна быть >= 0.01
  test "pruduct price must be positive" do
    product = Product.new(
      title:        'My Book Title',
      description:  'yyy',
      image_url:    'zzz.jpg'
    )

    # Задается цена меньше 0
    # Валидация должна выдать false, а product.invalid? false
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]

    # Задается цена 0
    # Валидация должна выдать false, а product.invalid? false
    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]

    # Задается валидная цена
    # Валидация должна выдать true, а product.valid? тоже true
    product.price = 1
    assert product.valid?
  end


  # Проверка на правильным формат img_url
  # Создается метод для создания экземпляра с аргументов, который подставляется в свойство img_url
  # Этот метод будет применяться в тесте ниже
  def new_product(image_url)
    Product.new(title: "My Book Title",
                description: "yyy",
                price: 1,
                image_url: image_url)
  end

  # Тестирование img_url на формат
  test "image url" do
    # Создается 2 массива (С правильным формат и с не правильным форматом)
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
    http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    # Элементы из массивов подставляются в аргумент создания нового экземпляра продукта
    # Массив "ok" содержить только валидные, поэтому идет проверка на валидные valid?
    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end

    # Массив "bad" содержить только невалидные, поэтому идет проверка на валидные invalid?
    bad.each do |name|
    assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end

  end

  # Тест: проверка на уникальность
  # product(:ruby) вернет можель Product, содержашую данные, определенные в стенде
  test "product is not valid without a unique title" do
    product = Product.new(title:        products(:ruby).title,
                          description: "yyy",
                          price:       1,
                          image_url:   "fred.gif")
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end

end
