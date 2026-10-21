package com.apparatushub;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/diary", "/diary-transaction"})
public class DiaryServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/apparatushub?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Samruddhi123";

    public static class DiaryEntry {
        private String transactionId;
        private String itemId;
        private String itemName;
        private String actionType;
        private String facultyName;
        private String department;
        private String createdDate;

        public DiaryEntry(String transactionId, String itemId, String itemName, String actionType, String facultyName, String department, String createdDate) {
            this.transactionId = transactionId;
            this.itemId = itemId;
            this.itemName = itemName;
            this.actionType = actionType;
            this.facultyName = facultyName;
            this.department = department;
            this.createdDate = createdDate;
        }

        public String getTransactionId() { return transactionId; }
        public String getItemId() { return itemId; }
        public String getItemName() { return itemName; }
        public String getActionType() { return actionType; }
        public String getFacultyName() { return facultyName; }
        public String getDepartment() { return department; }
        public String getCreatedDate() { return createdDate; }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        List<DiaryEntry> entries = new ArrayList<>();
        String sql = "SELECT * FROM equipment_diary ORDER BY id DESC";

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                entries.add(new DiaryEntry(
                    rs.getString("transaction_id"),
                    rs.getString("item_id"),
                    rs.getString("item_name"),
                    rs.getString("action_type"),
                    rs.getString("faculty_name"),
                    rs.getString("department"),
                    rs.getString("created_date")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("diaryEntries", entries);
        request.getRequestDispatcher("/diary.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String itemId = request.getParameter("itemId");
        String itemName = request.getParameter("itemName");
        String actionType = request.getParameter("actionType");
        String vendor = request.getParameter("vendorOrRenter");
        String facultyName = request.getParameter("userName");
        String department = request.getParameter("department");
        String reason = request.getParameter("reason");
        String today = LocalDate.now().toString();

        String insertDiarySql = "INSERT INTO equipment_diary (transaction_id, item_id, item_name, action_type, vendor_or_renter, item_condition, faculty_name, department, reason, created_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String updateStockSql = "UPDATE catalogue_inventory SET quantity = quantity - 1 WHERE item_id = ? AND quantity > 0";

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            conn.setAutoCommit(false);

            long count = 1001;
            try (Statement s = conn.createStatement(); ResultSet rs = s.executeQuery("SELECT COUNT(*) FROM equipment_diary")) {
                if (rs.next()) count += rs.getInt(1);
            }

            // 1. Insert into equipment_diary
            try (PreparedStatement stmt = conn.prepareStatement(insertDiarySql)) {
                stmt.setString(1, "TXN-" + count);
                stmt.setString(2, itemId);
                stmt.setString(3, itemName);
                stmt.setString(4, actionType);
                stmt.setString(5, vendor);
                stmt.setString(6, "Available");
                stmt.setString(7, facultyName);
                stmt.setString(8, department);
                stmt.setString(9, reason);
                stmt.setString(10, today);
                stmt.executeUpdate();
            }

            // 2. Decrement inventory stock
            try (PreparedStatement stmt = conn.prepareStatement(updateStockSql)) {
                stmt.setString(1, itemId);
                stmt.executeUpdate();
            }

            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/diary");
    }
}
