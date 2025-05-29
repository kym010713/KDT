package com.kdt.project.seller.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.kdt.project.db.OracleDB;
import com.kdt.project.seller.model.ProductModel;

@Repository
public class ProductDao extends OracleDB {
    private Connection conn = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;
    
    // 상품 등록
    public int insertProduct(ProductModel product) {
        int result = 0;
        conn = getConnection();
        String sql = "INSERT INTO product (category, product_id, product_name, company_name, product_photo) " +
                     "VALUES (?, ?, ?, ?, ?)";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, product.getCategory());
            pstmt.setString(2, product.getProductId());
            pstmt.setString(3, product.getProductName());
            pstmt.setString(4, product.getCompanyName());
            pstmt.setString(5, product.getProductPhoto());
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            getClose(conn, pstmt, rs);
        }
        return result;
    }
    
    // 상품 목록 조회
    public List<ProductModel> getAllProducts() {
        List<ProductModel> products = new ArrayList<>();
        conn = getConnection();
        String sql = "SELECT * FROM product ORDER BY product_id";
        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ProductModel product = new ProductModel();
                product.setCategory(rs.getString("category"));
                product.setProductId(rs.getString("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setCompanyName(rs.getString("company_name"));
                product.setProductPhoto(rs.getString("product_photo"));
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            getClose(conn, pstmt, rs);
        }
        return products;
    }
    
    // 상품 단건 조회
    public ProductModel getProductById(String productId) {
        ProductModel product = null;
        conn = getConnection();
        String sql = "SELECT * FROM product WHERE product_id = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, productId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                product = new ProductModel();
                product.setCategory(rs.getString("category"));
                product.setProductId(rs.getString("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setCompanyName(rs.getString("company_name"));
                product.setProductPhoto(rs.getString("product_photo"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            getClose(conn, pstmt, rs);
        }
        return product;
    }
    
    // 상품 수정
    public int updateProduct(ProductModel product) {
        int result = 0;
        conn = getConnection();
        String sql = "UPDATE product SET category=?, product_name=?, company_name=?, product_photo=? WHERE product_id=?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, product.getCategory());
            pstmt.setString(2, product.getProductName());
            pstmt.setString(3, product.getCompanyName());
            pstmt.setString(4, product.getProductPhoto());
            pstmt.setString(5, product.getProductId());
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            getClose(conn, pstmt, rs);
        }
        return result;
    }
    
    // 상품 삭제
    public int deleteProduct(String productId) {
        int result = 0;
        conn = getConnection();
        String sql = "DELETE FROM product WHERE product_id = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, productId);
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            getClose(conn, pstmt, rs);
        }
        return result;
    }
}