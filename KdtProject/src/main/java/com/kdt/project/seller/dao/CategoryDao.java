package com.kdt.project.seller.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.kdt.project.db.OracleDB;

@Repository
public class CategoryDao extends OracleDB {
    private Connection conn = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;
    
    // TOP_CATEGORY 테이블에서 모든 카테고리 조회
    public List<String> getAllTopCategories() {
        List<String> categories = new ArrayList<>();
        conn = getConnection();
        String sql = "SELECT TOP_NAME FROM TOP_CATEGORY ORDER BY TOP_NAME";
        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                categories.add(rs.getString("TOP_NAME"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            getClose(conn, pstmt, rs);
        }
        return categories;
    }
    
    // 특정 카테고리가 존재하는지 확인
    public boolean categoryExists(String categoryName) {
        boolean exists = false;
        conn = getConnection();
        String sql = "SELECT COUNT(*) FROM TOP_CATEGORY WHERE TOP_NAME = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, categoryName);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            getClose(conn, pstmt, rs);
        }
        return exists;
    }
}