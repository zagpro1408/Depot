class Product < ApplicationRecord

  # Проверка на то, чтобы поле не было пустым
  validates :title, :description, :image_url, :price, presence: {
    message: 'должен быть заполнен'
  }

  # Цена равна или больше 0,01
  validates :price, numericality: {
    greater_than_or_equal_to: 0.01,
    message: 'должен быть минимум 0,01'
  }

  # Уникальный title для товара
  # Минимальное количество символов для title
  validates :title, uniqueness: true, length: {
    minimum: 10,
    message: 'должен содержать минимум 10 символов'
  }

  # Валидация на допустимый формат изображения: GIF, JPG, PNG
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'URL должен указывать на изображение формата GIF, JPG или PNG.'
  }
end
