package com.nisum.ecommerce.dao;

import com.nisum.ecommerce.model.Product;
import com.nisum.ecommerce.model.Category;
import com.nisum.ecommerce.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ProductDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Product> getAllProducts() {
        String sql = "SELECT p.ProductID, p.ProductName, p.CategoryID, p.Status, p.ImagePath, " +
                "c.CategoryName, pc.Price, pc.DiscountPrice, pc.Discount " +
                "FROM Product p " +
                "JOIN Category c ON p.CategoryID = c.CategoryID " +
                "LEFT JOIN ProductCategory pc ON p.ProductID = pc.ProductID " +
                "WHERE p.Status = 'Active'";

        return jdbcTemplate.query(sql, this::mapRowToProduct);
    }

    public List<Product> searchProducts(String keyword) {
        String sql = "SELECT p.ProductID, p.ProductName, p.CategoryID, p.Status, p.ImagePath, " +
                "c.CategoryName, pc.Price, pc.DiscountPrice, pc.Discount " +
                "FROM Product p " +
                "JOIN Category c ON p.CategoryID = c.CategoryID " +
                "LEFT JOIN ProductCategory pc ON p.ProductID = pc.ProductID " +
                "WHERE (p.ProductName LIKE ? OR p.ProductID LIKE ?) AND p.Status = 'Active'";

        return jdbcTemplate.query(sql, this::mapRowToProduct, "%" + keyword + "%", "%" + keyword + "%");
    }

    public List<Product> getProductsByCategory(int categoryId) {
        String sql = "SELECT p.ProductID, p.ProductName, p.CategoryID, p.Status, p.ImagePath, " +
                "c.CategoryName, pc.Price, pc.DiscountPrice, pc.Discount " +
                "FROM Product p " +
                "JOIN Category c ON p.CategoryID = c.CategoryID " +
                "LEFT JOIN ProductCategory pc ON p.ProductID = pc.ProductID " +
                "WHERE p.CategoryID = ? AND p.Status = 'Active'";

        return jdbcTemplate.query(sql, this::mapRowToProduct, categoryId);
    }

    public Product getProductById(int productId) {
        try {
            String sql = "SELECT p.ProductID, p.ProductName, p.CategoryID, p.Status, p.ImagePath, " +
                    "c.CategoryName, pc.Price, pc.DiscountPrice, pc.Discount " +
                    "FROM Product p " +
                    "JOIN Category c ON p.CategoryID = c.CategoryID " +
                    "LEFT JOIN ProductCategory pc ON p.ProductID = pc.ProductID " +
                    "WHERE p.ProductID = ?";

            List<Product> products = jdbcTemplate.query(sql, this::mapRowToProduct, productId);
            return products.isEmpty() ? null : products.get(0);
        } catch (Exception e) {
            return null;
        }
    }

    public List<Category> getAllCategories() {
        String sql = "SELECT CategoryID, CategoryName FROM Category";
        return jdbcTemplate.query(sql, this::mapRowToCategory);
    }

    public User authenticateUser(String email, String password) {
        try {
            String sql = "SELECT * FROM Users WHERE Email = ? AND Password = ?";
            List<User> users = jdbcTemplate.query(sql, this::mapRowToUser, email, password);
            return users.isEmpty() ? null : users.get(0);
        } catch (Exception e) {
            return null;
        }
    }

    public boolean createUser(User user) {
        try {
            String sql = "INSERT INTO Users (FirstName, LastName, Email, Password, PhoneNumber) VALUES (?, ?, ?, ?, ?)";
            int result = jdbcTemplate.update(sql,
                    user.getFirstName(),
                    user.getLastName(),
                    user.getEmail(),
                    user.getPassword(),
                    user.getPhoneNumber());
            return result > 0;
        } catch (Exception e) {
            return false;
        }
    }

    
    private Product mapRowToProduct(ResultSet rs, int rowNum) throws SQLException {
        Product product = new Product();
        product.setProductId(rs.getInt("ProductID"));
        product.setProductName(rs.getString("ProductName"));
        product.setCategoryId(rs.getInt("CategoryID"));
        product.setStatus(rs.getString("Status"));

        
        String imagePath = rs.getString("ImagePath");
        if (imagePath == null || imagePath.trim().isEmpty()) {
            product.setImagePath("images/placeholder.jpg");
        } else {
            product.setImagePath(imagePath);
        }

        product.setCategoryName(rs.getString("CategoryName"));

        try {
            product.setPrice(rs.getDouble("Price"));
            product.setDiscountPrice(rs.getDouble("DiscountPrice"));
            product.setDiscount(rs.getInt("Discount"));
        } catch (SQLException e) {
            product.setPrice(0.0);
            product.setDiscountPrice(0.0);
            product.setDiscount(0);
        }

        return product;
    }

    private Category mapRowToCategory(ResultSet rs, int rowNum) throws SQLException {
        Category category = new Category();
        category.setCategoryId(rs.getInt("CategoryID"));
        category.setCategoryName(rs.getString("CategoryName"));
        return category;
    }

    private User mapRowToUser(ResultSet rs, int rowNum) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("UserID"));
        user.setFirstName(rs.getString("FirstName"));
        user.setLastName(rs.getString("LastName"));
        user.setEmail(rs.getString("Email"));
        user.setPassword(rs.getString("Password"));
        user.setPhoneNumber(rs.getString("PhoneNumber"));
        return user;
    }
}
