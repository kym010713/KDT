package com.kdt.project.seller.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.kdt.project.db.OracleDB;
import com.kdt.project.seller.model.ProductDetailModel;

@Repository
public class ProductDetailDao extends OracleDB {
    private Connection conn = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;
    
    // 상품 상세 정보 등록
    public int insertProductDetail(ProductDetailModel detail) {
        int result = 0;
        conn = getConnection();
        String sql = "INSERT INTO product_detail (product_name, product_count, product_detail, product_price, product_size, product_photo) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, detail.getProductName());
            pstmt.setInt(2, detail.getProductCount());
            pstmt.setString(3, detail.getProductDetail());
            pstmt.setString(4, detail.getProductPrice());
            pstmt.setString(5, detail.getProductSize());
            pstmt.setString(6, detail.getProductPhoto());
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            getClose(conn, pstmt, rs);
        }
        return result;
    }
    
    // 상품명으로 상세 정보 조회
    public ProductDetailModel getProductDetailByName(String productName) {
        ProductDetailModel detail = null;
        conn = getConnection();
        String sql = "SELECT * FROM product_detail WHERE product_name = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, productName);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                detail = new ProductDetailModel();
                detail.setProductName(rs.getString("product_name"));
                detail.setProductCount(rs.getInt("product_count"));
                detail.setProductDetail(rs.getString("product_detail"));
                detail.setProductPrice(rs.getString("product_price"));
                detail.setProductSize(rs.getString("product_size"));
                detail.setProductPhoto(rs.getString("product_photo"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            getClose(conn, pstmt, rs);
        }
        return detail;
    }
    
    // 모든 상품 상세 정보 조회
    public List<ProductDetailModel> getAllProductDetails() {
        List<ProductDetailModel> details = new ArrayList<>();
        conn = getConnection();
        String sql = "SELECT * FROM product_detail ORDER BY product_name";
        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ProductDetailModel detail = new ProductDetailModel();
                detail.setProductName(rs.getString("product_name"));
                detail.setProductCount(rs.getInt("product_count"));
                detail.setProductDetail(rs.getString("product_detail"));
                detail.setProductPrice(rs.getString("product_price"));
                detail.setProductSize(rs.getString("product_size"));
                detail.setProductPhoto(rs.getString("product_photo"));
                details.add(detail);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            getClose(conn, pstmt, rs);
        }
        return details;
    }
    
    // 상품 상세 정보 수정
    public int updateProductDetail(ProductDetailModel detail) {
        int result = 0;
        conn = getConnection();
        String sql = "UPDATE product_detail SET product_count=?, product_detail=?, product_price=?, product_size=? WHERE product_name=? AND product_photo=?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, detail.getProductCount());
            pstmt.setString(2, detail.getProductDetail());
            pstmt.setString(3, detail.getProductPrice());
            pstmt.setString(4, detail.getProductSize());
            pstmt.setString(5, detail.getProductName());
            pstmt.setString(6, detail.getProductPhoto());
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            getClose(conn, pstmt, rs);
        }
        return result;
    }
    
    // 상품 상세 정보 삭제
    public int deleteProductDetail(String productName, String productPhoto) {
        int result = 0;
        conn = getConnection();
        String sql = "DELETE FROM product_detail WHERE product_name = ? AND product_photo = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, productName);
            pstmt.setString(2, productPhoto);
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            getClose(conn, pstmt, rs);
        }
        return result;
    }
}