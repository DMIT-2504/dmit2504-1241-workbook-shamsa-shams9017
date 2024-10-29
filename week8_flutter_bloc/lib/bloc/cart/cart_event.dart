abstract class CartEvent {}

class AddItemToCart extends CartEvent {
  final Map<String, dynamic> item;

  AddItemToCart(this.item);
}

class RemoveItemFromCart extends CartEvent {
  final int itemId;

  RemoveItemFromCart(this.itemId);
}

class UpdateItemQuantity extends CartEvent {
  final int itemId;
  final int quantity;

  UpdateItemQuantity(this.itemId, this.quantity);
}