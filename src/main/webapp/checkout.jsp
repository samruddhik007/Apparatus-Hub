<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ApparatusHub - Faculty Requisition</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; }
        body { background: #f8fafc; padding: 30px 15px; color: #0f172a; }
        .checkout-card { max-width: 500px; margin: 0 auto; background: #ffffff; border-radius: 12px; padding: 28px; box-shadow: 0 4px 15px rgba(0,0,0,0.04); border: 1px solid #e2e8f0; }
        h2 { color: #0f172a; margin-bottom: 20px; font-size: 1.4rem; font-weight: 800; }
        .summary-box { background: #f1f5f9; border-radius: 8px; padding: 16px; margin-bottom: 22px; border: 1px solid #e2e8f0; }
        .summary-item { display: flex; justify-content: space-between; margin-bottom: 10px; font-size: 0.9rem; }
        .summary-item:last-child { margin-bottom: 0; }
        .summary-item span { color: #64748b; }
        .summary-item strong { color: #0f172a; }
        .form-group { margin-bottom: 16px; }
        label { display: block; font-size: 0.85rem; font-weight: 600; margin-bottom: 6px; color: #475569; }
        input, select { width: 100%; padding: 10px 14px; border: 1px solid #cbd5e1; border-radius: 6px; outline: none; font-size: 0.9rem; }
        input:focus, select:focus { border-color: #0f172a; }
        .btn-confirm { width: 100%; padding: 12px; background: #0f172a; color: #fff; border: none; border-radius: 6px; font-weight: 700; font-size: 0.95rem; cursor: pointer; margin-top: 10px; transition: background 0.2s; }
        .btn-confirm:hover { background: #1e293b; }
        .back-link { display: block; text-align: center; margin-top: 16px; color: #64748b; text-decoration: none; font-size: 0.85rem; font-weight: 600; }
    </style>
</head>
<body>

    <div class="checkout-card">
        <h2>Faculty Requisition Tracker</h2>

        <div class="summary-box">
            <div class="summary-item"><span>Equipment Name:</span> <strong>${param.itemName}</strong></div>
            <div class="summary-item"><span>Apparatus ID:</span> <strong>${param.itemId}</strong></div>
            <div class="summary-item"><span>Transaction Type:</span> <strong>${param.actionType}</strong></div>
            <div class="summary-item"><span>Vendor / Partner College:</span> <strong>${param.vendorOrRenter}</strong></div>
            <div class="summary-item"><span>Condition Status:</span> <strong>${param.condition}</strong></div>
        </div>

        <form action="diary" method="POST">
            <input type="hidden" name="itemId" value="${param.itemId}">
            <input type="hidden" name="itemName" value="${param.itemName}">
            <input type="hidden" name="actionType" value="${param.actionType}">
            <input type="hidden" name="vendorOrRenter" value="${param.vendorOrRenter}">
            <input type="hidden" name="condition" value="${param.condition}">

            <div class="form-group">
                <label>Authorized Faculty Member</label>
                <input type="text" name="userName" value="Computer Engineering Department Faculty" required>
            </div>

            <div class="form-group">
                <label>Target Laboratory / Workshop</label>
                <select name="department">
                    <option value="Microprocessor & Embedded Lab">Microprocessor & Embedded Lab</option>
                    <option value="Advanced Software Engineering Lab">Advanced Software Engineering Lab</option>
                    <option value="Applied Mechanics & Mechanical Workshop">Applied Mechanics & Mechanical Workshop</option>
                    <option value="Basic Electrical & EDC Lab">Basic Electrical & EDC Lab</option>
                    <option value="Applied Chemistry & Scientific Store">Applied Chemistry & Scientific Store</option>
                </select>
            </div>

            <div class="form-group">
                <label>Requisition Reason</label>
                <select name="reason">
                    <option value="Urgent for Practical Exams">Urgent for Practical Exams</option>
                    <option value="Inter-College Rental / Lend Out">Inter-College Rental / Lend Out</option>
                    <option value="Lab Equipment Replacement">Lab Equipment Replacement</option>
                    <option value="Vendor Purchase / Return">Vendor Purchase / Return</option>
                </select>
            </div>

            <button type="submit" class="btn-confirm">Log Order into Faculty Diary</button>
        </form>

        <a href="catalogue" class="back-link">← Cancel & Return to Catalogue</a>
    </div>

</body>
</html>
