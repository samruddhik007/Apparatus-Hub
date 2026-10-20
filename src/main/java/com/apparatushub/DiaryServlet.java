package com.apparatushub;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/diary")
public class DiaryServlet extends HttpServlet {

    public static class Transaction {
        private String transactionId;
        private String itemId;
        private String itemName;
        private String actionType;
        private String vendorOrRenter;
        private String condition;
        private String facultyName;
        private String department;
        private String reason;
        private String date;

        public Transaction(String transactionId, String itemId, String itemName, String actionType, 
                           String vendorOrRenter, String condition, String facultyName, 
                           String department, String reason, String date) {
            this.transactionId = transactionId;
            this.itemId = itemId;
            this.itemName = itemName;
            this.actionType = actionType;
            this.vendorOrRenter = vendorOrRenter;
            this.condition = condition;
            this.facultyName = facultyName;
            this.department = department;
            this.reason = reason;
            this.date = date;
        }

        public String getTransactionId() { return transactionId; }
        public String getItemId() { return itemId; }
        public String getItemName() { return itemName; }
        public String getActionType() { return actionType; }
        public String getVendorOrRenter() { return vendorOrRenter; }
        public String getCondition() { return condition; }
        public String getFacultyName() { return facultyName; }
        public String getDepartment() { return department; }
        public String getReason() { return reason; }
        public String getDate() { return date; }
    }

    private static final List<Transaction> transactionLog = new ArrayList<>();

    static {
        // Pre-populated inventory history
        transactionLog.add(new Transaction("TXN-1001", "APP-101", "8086 Microprocessor Kit", "Rent", 
                "KC College of Engineering", "Available", "Computer Faculty", 
                "Microprocessor Lab", "Urgent for Practical Exams", "2026-10-18"));
        
        transactionLog.add(new Transaction("TXN-1002", "APP-102", "Digital Oscilloscope 100MHz", "Buy", 
                "Thane Electronics Local", "Available", "EXTC Faculty", 
                "Basic Electrical & EDC Lab", "Lab Equipment Replacement", "2026-10-19"));

        transactionLog.add(new Transaction("TXN-1003", "APP-110", "Vernier Caliper 0-150mm", "Buy", 
                "Thane Precision Tools", "Available", "Mechanical Faculty", 
                "Applied Mechanics Workshop", "Stock Acquisition", "2026-10-20"));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String isCart = request.getParameter("isCartCheckout");
        String facultyName = request.getParameter("userName");
        String department = request.getParameter("department");
        String reason = request.getParameter("reason");
        String today = LocalDate.now().toString();

        if ("true".equals(isCart)) {
            String cartData = request.getParameter("cartData");
            if (cartData != null && !cartData.isEmpty()) {
                // Parse simple array format from frontend
                String[] items = cartData.replace("[", "").replace("]", "").split("\\},\\{");
                for (String itemStr : items) {
                    String clean = itemStr.replace("{", "").replace("}", "").replace("\"", "");
                    String[] fields = clean.split(",");
                    String id = "APP-GEN", name = "Equipment Item", type = "Buy", vendor = "Thane Supplier";
                    for (String f : fields) {
                        String[] kv = f.split(":");
                        if (kv.length == 2) {
                            String k = kv[0].trim(), v = kv[1].trim();
                            if ("id".equals(k)) id = v;
                            if ("name".equals(k)) name = v;
                            if ("type".equals(k)) type = v;
                            if ("vendor".equals(k)) vendor = v;
                        }
                    }
                    String txId = "TXN-" + (1000 + transactionLog.size() + 1);
                    transactionLog.add(0, new Transaction(txId, id, name, type, vendor, "Available", facultyName, department, reason, today));
                }
            }
        } else {
            String itemId = request.getParameter("itemId");
            String itemName = request.getParameter("itemName");
            String actionType = request.getParameter("actionType");
            String vendor = request.getParameter("vendorOrRenter");
            String condition = request.getParameter("condition");

            String txId = "TXN-" + (1000 + transactionLog.size() + 1);
            if (itemName != null && !itemName.isEmpty()) {
                transactionLog.add(0, new Transaction(txId, itemId, itemName, actionType, vendor, 
                        condition != null ? condition : "Available", facultyName, department, reason, today));
            }
        }

        response.sendRedirect(request.getContextPath() + "/diary");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        request.setAttribute("transactionLog", transactionLog);
        request.getRequestDispatcher("/diary.jsp").forward(request, response);
    }
}
EOFcat << 'EOF' > src/main/java/com/apparatushub/DiaryServlet.java
package com.apparatushub;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/diary")
public class DiaryServlet extends HttpServlet {

    public static class Transaction {
        private String transactionId;
        private String itemId;
        private String itemName;
        private String actionType;
        private String vendorOrRenter;
        private String condition;
        private String facultyName;
        private String department;
        private String reason;
        private String date;

        public Transaction(String transactionId, String itemId, String itemName, String actionType, 
                           String vendorOrRenter, String condition, String facultyName, 
                           String department, String reason, String date) {
            this.transactionId = transactionId;
            this.itemId = itemId;
            this.itemName = itemName;
            this.actionType = actionType;
            this.vendorOrRenter = vendorOrRenter;
            this.condition = condition;
            this.facultyName = facultyName;
            this.department = department;
            this.reason = reason;
            this.date = date;
        }

        public String getTransactionId() { return transactionId; }
        public String getItemId() { return itemId; }
        public String getItemName() { return itemName; }
        public String getActionType() { return actionType; }
        public String getVendorOrRenter() { return vendorOrRenter; }
        public String getCondition() { return condition; }
        public String getFacultyName() { return facultyName; }
        public String getDepartment() { return department; }
        public String getReason() { return reason; }
        public String getDate() { return date; }
    }

    private static final List<Transaction> transactionLog = new ArrayList<>();

    static {
        // Pre-populated inventory history
        transactionLog.add(new Transaction("TXN-1001", "APP-101", "8086 Microprocessor Kit", "Rent", 
                "KC College of Engineering", "Available", "Computer Faculty", 
                "Microprocessor Lab", "Urgent for Practical Exams", "2026-10-18"));
        
        transactionLog.add(new Transaction("TXN-1002", "APP-102", "Digital Oscilloscope 100MHz", "Buy", 
                "Thane Electronics Local", "Available", "EXTC Faculty", 
                "Basic Electrical & EDC Lab", "Lab Equipment Replacement", "2026-10-19"));

        transactionLog.add(new Transaction("TXN-1003", "APP-110", "Vernier Caliper 0-150mm", "Buy", 
                "Thane Precision Tools", "Available", "Mechanical Faculty", 
                "Applied Mechanics Workshop", "Stock Acquisition", "2026-10-20"));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String isCart = request.getParameter("isCartCheckout");
        String facultyName = request.getParameter("userName");
        String department = request.getParameter("department");
        String reason = request.getParameter("reason");
        String today = LocalDate.now().toString();

        if ("true".equals(isCart)) {
            String cartData = request.getParameter("cartData");
            if (cartData != null && !cartData.isEmpty()) {
                // Parse simple array format from frontend
                String[] items = cartData.replace("[", "").replace("]", "").split("\\},\\{");
                for (String itemStr : items) {
                    String clean = itemStr.replace("{", "").replace("}", "").replace("\"", "");
                    String[] fields = clean.split(",");
                    String id = "APP-GEN", name = "Equipment Item", type = "Buy", vendor = "Thane Supplier";
                    for (String f : fields) {
                        String[] kv = f.split(":");
                        if (kv.length == 2) {
                            String k = kv[0].trim(), v = kv[1].trim();
                            if ("id".equals(k)) id = v;
                            if ("name".equals(k)) name = v;
                            if ("type".equals(k)) type = v;
                            if ("vendor".equals(k)) vendor = v;
                        }
                    }
                    String txId = "TXN-" + (1000 + transactionLog.size() + 1);
                    transactionLog.add(0, new Transaction(txId, id, name, type, vendor, "Available", facultyName, department, reason, today));
                }
            }
        } else {
            String itemId = request.getParameter("itemId");
            String itemName = request.getParameter("itemName");
            String actionType = request.getParameter("actionType");
            String vendor = request.getParameter("vendorOrRenter");
            String condition = request.getParameter("condition");

            String txId = "TXN-" + (1000 + transactionLog.size() + 1);
            if (itemName != null && !itemName.isEmpty()) {
                transactionLog.add(0, new Transaction(txId, itemId, itemName, actionType, vendor, 
                        condition != null ? condition : "Available", facultyName, department, reason, today));
            }
        }

        response.sendRedirect(request.getContextPath() + "/diary");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        request.setAttribute("transactionLog", transactionLog);
        request.getRequestDispatcher("/diary.jsp").forward(request, response);
    }
}
