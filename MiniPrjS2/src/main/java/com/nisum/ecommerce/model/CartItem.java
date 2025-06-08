package com.nisum.ecommerce.model;

public class CartItem {
    private int cartItemId;
    private int productId;
    private String productName;
    private String imagePath;
    private int quantity;
    private double unitPrice;
    private double discount;
    private double totalPrice;
    private String size;

    
    public CartItem() {}

    public CartItem(int productId, String productName, String imagePath, int quantity, double unitPrice, double discount) {
        this.productId = productId;
        this.productName = productName;
        this.imagePath = imagePath;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.discount = discount;
        this.totalPrice = (unitPrice - discount) * quantity;
    }

    
    public int getCartItemId() { return cartItemId; }
    public void setCartItemId(int cartItemId) { this.cartItemId = cartItemId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
        this.totalPrice = (unitPrice - discount) * quantity;
    }

    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; }

    public double getDiscount() { return discount; }
    public void setDiscount(double discount) { this.discount = discount; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }

    public String getSize() { return size; }
    public void setSize(String size) { this.size = size; }
}
