<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>A. P. Shah Institute - Requisition Cart</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; }
        body { background: #ffffff; color: #1e293b; padding: 24px; max-width: 900px; margin: 0 auto; }
        header { display: flex; justify-content: space-between; align-items: center; padding-bottom: 16px; border-bottom: 1px solid #e2e8f0; margin-bottom: 24px; }
        h1 { font-size: 1.3rem; font-weight: 700; color: #0f172a; }
        .back-link { color: #2563eb; text-decoration: none; font-weight: 600; font-size: 0.88rem; }
        
        table { width: 100%; border-collapse: collapse; margin-bottom: 24px; }
        th, td { padding: 12px 14px; text-align: left; border-bottom: 1px solid #e2e8f0; font-size: 0.88rem; }
        th { background: #f8fafc; color: #475569; font-weight: 600; }
        
        .empty-cart { text-align: center; padding: 40px; color: #64748b; font-size: 0.9rem; }
        
        .checkout-box { background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 8px; padding: 20px; }
        .form-group { margin-bottom: 14px; }
        label { display: block; font-size: 0.82rem; font-weight: 600; color: #475569; margin-bottom: 4px; }
        input, select { width: 100%; padding: 8px 12px; border: 1px solid #cbd5e1; border-radius: 4px; outline: none; font-size: 0.88rem; }
        
        .btn-submit { width: 100%; padding: 10px; background: #0f172a; color: #ffffff; border: none; border-radius: 4px; font-weight: 600; font-size: 0.9rem; cursor: pointer; margin-top: 8px; }
        .btn-remove { background: #fee2e2; color: #991b1b; border: 1px solid #fca5a5; padding: 4px 8px; border-radius: 4px; font-size: 0.75rem; cursor: pointer; }
    </style>
</head>
<body>

    <header>
        <h1>Faculty Requisition Cart</h1>
        <a href="catalogue" class="back-link">← Back to Catalogue</a>
    </header>

    <div id="cartTableContainer">
        <table id="cartTable">
            <thead>
                <tr>
                    <th>Item ID</th>
                    <th>Equipment Name</th>
                    <th>Type</th>
                    <th>Vendor / Source</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody id="cartBody">
                <!-- Cart items dynamically rendered via JS -->
            </tbody>
        </table>
    </div>

    <div class="checkout-box" id="checkoutSection">
        <h2 style="font-size: 1rem; margin-bottom: 14px; color: #0f172a;">Order Requisition Details</h2>
        <form action="diary" method="POST" onsubmit="return prepareCartSubmission(event)">
            <input type="hidden" name="cartData" id="cartDataInput">
            <input type="hidden" name="isCartCheckout" value="true">

            <div class="form-group">
                <label>Authorized Faculty / Department</label>
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
                <label>Requisition Purpose</label>
                <select name="reason">
                    <option value="Urgent for Practical Exams">Urgent for Practical Exams</option>
                    <option value="Inter-College Rental / Lend Out">Inter-College Rental / Lend Out</option>
                    <option value="Lab Equipment Replacement">Lab Equipment Replacement</option>
                    <option value="Vendor Purchase / Return">Vendor Purchase / Return</option>
                </select>
            </div>

            <button type="submit" class="btn-submit">Confirm Requisition & Update Diary</button>
        </form>
    </div>

    <script>
        function loadCart() {
            let cart = JSON.parse(localStorage.getItem('apsitCart') || '[]');
            let tbody = document.getElementById('cartBody');
            tbody.innerHTML = '';

            if (cart.length === 0) {
                document.getElementById('cartTableContainer').innerHTML = '<div class="empty-cart">Your requisition cart is currently empty. <br><br><a href="catalogue" class="back-link">Browse Equipment Catalogue</a></div>';
                document.getElementById('checkoutSection').style.display = 'none';
                return;
            }

            cart.forEach((item, index) => {
                let tr = document.createElement('tr');
                tr.innerHTML = `
                    <td><strong>\${item.id}</strong></td>
                    <td>\${item.name}</td>
                    <td>\${item.type}</td>
                    <td>\${item.vendor}</td>
                    <td><button class="btn-remove" onclick="removeItem(\${index})">Remove</button></td>
                `;
                tbody.appendChild(tr);
            });
        }

        function removeItem(index) {
            let cart = JSON.parse(localStorage.getItem('apsitCart') || '[]');
            cart.splice(index, 1);
            localStorage.setItem('apsitCart', JSON.stringify(cart));
            loadCart();
        }

        function prepareCartSubmission(event) {
            let cart = localStorage.getItem('apsitCart') || '[]';
            if (cart === '[]') {
                alert('Cart is empty!');
                return false;
            }
            document.getElementById('cartDataInput').value = cart;
            localStorage.removeItem('apsitCart');
            return true;
        }

        loadCart();
    </script>
</body>
</html>
