class CartItem {
  final String? name;
  final String? price;

  CartItem({this.name, this.price});
}

List<CartItem> getItems() {
  return [
    CartItem(name: 'Teclado ', price: '24'),
    CartItem(name: 'Mouse', price: '20'),
    CartItem(name: 'Monitor LED', price: '44'),
    CartItem(name: 'Macbook Air', price: '240'),
    CartItem(name: 'Samsung', price: '204'),
    CartItem(name: 'iMac', price: '248'),
    CartItem(name: 'Headphones', price: '29'),
    CartItem(name: 'Disco USB', price: '19'),
    CartItem(name: 'SSD', price: '23'),
  ];
}
