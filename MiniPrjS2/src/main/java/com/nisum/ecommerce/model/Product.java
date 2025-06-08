package com.nisum.ecommerce.model;

public class Product {
    private int productId;
    private String productName;
    private int categoryId;
    private String status;
    private String imagePath;
    private String categoryName;
    private double price;
    private double discountPrice;
    private int discount;

    
    public Product() {}

    
    public Product(int productId, String productName, String categoryName, String imagePath) {
        this.productId = productId;
        this.productName = productName;
        this.categoryName = categoryName;
        this.imagePath = imagePath;
    }

    
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public double getDiscountPrice() { return discountPrice; }
    public void setDiscountPrice(double discountPrice) { this.discountPrice = discountPrice; }

    public int getDiscount() { return discount; }
    public void setDiscount(int discount) { this.discount = discount; }
}
