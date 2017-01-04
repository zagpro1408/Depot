class Product < ApplicationRecord

  # Проверка на то, чтобы поле не было пустым
  validates :title, :description, :image_url, :price, presence: true

  # Цена равна или больше 0,01
  validates :price, numericality: {greater_than_or_equal_to: 0.01}

  # Уникальный title для товара
  validates :title, uniqueness: true

  # Валидация на допустимый формат изображения: GIF, JPG, PNG
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'URL должен указывать на изображение формата GIF, JPG или PNG.'
  }
end
