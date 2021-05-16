class Order < ApplicationRecord
  before_validation :set_price

  belongs_to :restaurant
  has_many :order_products

  validates :name, :phone_number, :total_value, :city, :neighborhood, :street, :number, presence: true
  enum status: { wainting: 0, delivered: 1}
  
  # accepts_nested_attributes_for para que serve:
  # ao invés de termos um controller específico para order_products,
  # será aceito dentro do controller order também os valores do 
  # order_products. Ou seja, é um atributo alinhado.
  # ou seja, quando chamarmos o create do order, além de passar os
  # dados dele, também poderemos passar os dados do order_products
  # que possui relação com order.
  accepts_nested_attributes_for :order_products, allow_destroy: true
  


  private
  
  def set_price
    final_price = 0
    # para cada order_products (produtos que vieram do controller)...
    order_products.each do |op|
      final_price += op.quantity * op.product.price
    end
    # self.total_value: este self representa o atributo de Order. 
    # Nele será atribuído o total do pedido.

    # self.restaurant respresenta o objeto Restaurante que contém o 
    # valor de taxa de entrega. O self trará o restaurante corrente
    # no qual está sendo feito o pedido. Este tem relação com Order 
    # (belongs :restaurant)
    self.total_value = final_price + self.restaurant.delivery_tax
  end

end
