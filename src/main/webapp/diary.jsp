<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>A. P. Shah Institute - Equipment Diary & Order History</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; }
        body { background: #ffffff; color: #1e293b; padding: 24px; max-width: 1100px; margin: 0 auto; }
        
        header { display: flex; justify-content: space-between; align-items: center; padding-bottom: 16px; border-bottom: 1px solid #e2e8f0; margin-bottom: 24px; }
        h1 { font-size: 1.3rem; font-weight: 700; color: #0f172a; }
        p { color: #64748b; font-size: 0.85rem; margin-top: 2px; }
        .back-link { color: #2563eb; text-decoration: none; font-weight: 600; font-size: 0.88rem; }
        
        table { width: 100%; border-collapse: collapse; background: #ffffff; border: 1px solid #e2e8f0; border-radius: 6px; overflow: hidden; margin-top: 16px; }
        th, td { padding: 12px 14px; text-align: left; border-bottom: 1px solid #e2e8f0; font-size: 0.85rem; }
        th { background: #f8fafc; color: #475569; font-weight: 600; }
        
        .badge-owned { background: #dcfce7; color: #166534; padding: 3px 8px; border-radius: 4px; font-weight: 600; font-size: 0.75rem; border: 1px solid #bbf7d0; }
        .badge-loan { background: #fef3c7; color: #92400e; padding: 3px 8px; border-radius: 4px; font-weight: 600; font-size: 0.75rem; border: 1px solid #fde68a; }
        .reason-tag { background: #f1f5f9; color: #334155; padding: 2px 6px; border-radius: 4px; font-size: 0.75rem; }
    </style>
</head>
<body>

    <header>
        <div>
            <h1>Equipment Register & Transaction Diary</h1>
            <p>A. P. Shah Institute of Technology — Official Lab Log</p>
        </div>
        <a href="catalogue" class="back-link">← Return to Catalogue</a>
    </header>

    <table>
        <thead>
            <tr>
                <th>Txn ID</th>
                <th>Apparatus Details</th>
                <th>Source / Vendor</th>
                <th>Assigned Lab</th>
                <th>Requisition Purpose</th>
                <th>Date Logged</th>
                <th>Ownership Status</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty transactionLog}">
                    <tr>
                        <td colspan="7" style="text-align: center; color: #94a3b8; padding: 30px;">No transaction records logged yet.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="tx" items="${transactionLog}">
                        <tr>
                            <td><strong>${tx.transactionId}</strong></td>
                            <td>
                                <strong>${tx.itemName}</strong><br>
                                <span style="font-size:0.75rem; color:#64748b;">ID: ${tx.itemId}</span>
                            </td>
                            <td>${tx.vendorOrRenter}</td>
                            <td>${tx.department}</td>
                            <td><span class="reason-tag">${tx.reason}</span></td>
                            <td>${tx.date}</td>
                            <td>
                                <span class="${tx.actionType == 'Rent' ? 'badge-loan' : 'badge-owned'}">
                                    ${tx.actionType == 'Rent' ? 'Needed / Active Loan' : 'Already Owned'}
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

</body>
</html>
