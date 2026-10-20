<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>A. P. Shah Institute of Technology - Apparatus Portal</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; }
        body { background-color: #ffffff; color: #1e293b; padding-bottom: 60px; }
        
        header { background: #ffffff; color: #0f172a; padding: 16px 24px; border-bottom: 1px solid #e2e8f0; display: flex; justify-content: space-between; align-items: center; }
        header h1 { font-size: 1.2rem; font-weight: 700; color: #0f172a; }
        .nav-links { display: flex; gap: 16px; align-items: center; }
        .nav-links a { color: #2563eb; text-decoration: none; font-weight: 600; font-size: 0.88rem; }
        .nav-links a:hover { text-decoration: underline; }
        .cart-badge { background: #f1f5f9; color: #0f172a; border: 1px solid #cbd5e1; padding: 5px 12px; border-radius: 6px; font-weight: 600; font-size: 0.85rem; }

        /* Simple Counter Banner */
        .stats-banner { max-width: 1200px; margin: 20px auto 0; padding: 0 20px; display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 12px; }
        .stat-card { background: #ffffff; border-radius: 6px; padding: 12px 16px; border: 1px solid #e2e8f0; }
        .stat-title { font-size: 0.75rem; font-weight: 600; color: #64748b; text-transform: uppercase; }
        .stat-value { font-size: 1.3rem; font-weight: 700; color: #0f172a; margin-top: 2px; }
        .stat-sub { font-size: 0.75rem; color: #475569; margin-top: 2px; }
        .stat-sub.urgent { color: #dc2626; font-weight: 600; }

        /* Search Bar */
        .search-container { max-width: 1200px; margin: 16px auto 0; padding: 0 20px; }
        .search-container input { width: 100%; padding: 10px 14px; border: 1px solid #cbd5e1; border-radius: 6px; outline: none; font-size: 0.9rem; background: #ffffff; color: #0f172a; }
        .search-container input:focus { border-color: #2563eb; }

        /* Product Grid */
        .product-grid { max-width: 1200px; margin: 0 auto; display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 16px; padding: 20px; }
        .card { background: #ffffff; border-radius: 8px; border: 1px solid #e2e8f0; overflow: hidden; display: flex; flex-direction: column; justify-content: space-between; }
        
        .card-img-wrapper { position: relative; width: 100%; height: 170px; background: #f8fafc; padding: 10px; display: flex; align-items: center; justify-content: center; border-bottom: 1px solid #e2e8f0; }
        .card-img-wrapper img { max-width: 100%; max-height: 100%; object-fit: contain; }
        
        .type-badge { position: absolute; bottom: 8px; left: 8px; padding: 2px 6px; border-radius: 4px; font-size: 0.7rem; font-weight: 700; }
        .badge-buy { background: #dcfce7; color: #166534; border: 1px solid #bbf7d0; }
        .badge-rent { background: #dbeafe; color: #1e40af; border: 1px solid #bfdbfe; }

        .stock-badge { position: absolute; top: 8px; right: 8px; padding: 2px 6px; border-radius: 4px; font-size: 0.7rem; font-weight: 600; background: #ffffff; color: #334155; border: 1px solid #cbd5e1; }
        .condition-tag { position: absolute; top: 8px; left: 8px; padding: 2px 6px; border-radius: 4px; font-size: 0.7rem; font-weight: 600; background: #ffffff; color: #475569; border: 1px solid #cbd5e1; }

        .card-details { padding: 12px; display: flex; flex-direction: column; gap: 3px; }
        .item-name { font-size: 0.95rem; font-weight: 700; color: #0f172a; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .item-faculty { font-size: 0.8rem; color: #334155; }
        .item-vendor { font-size: 0.8rem; color: #64748b; }
        .item-desc { font-size: 0.75rem; color: #64748b; margin-top: 4px; line-height: 1.3; height: 32px; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; }

        /* Action Buttons */
        .card-actions { padding: 0 12px 12px; display: flex; gap: 6px; }
        .btn { flex: 1; padding: 8px 0; border: none; border-radius: 4px; font-weight: 600; font-size: 0.8rem; cursor: pointer; text-align: center; }
        
        .btn-cart { background: #f1f5f9; color: #334155; border: 1px solid #cbd5e1; }
        .btn-buy-green { background: #16a34a; color: #ffffff; }
        .btn-rent-red { background: #dc2626; color: #ffffff; }

        #toast { visibility: hidden; min-width: 220px; background-color: #0f172a; color: #fff; text-align: center; border-radius: 6px; padding: 10px; position: fixed; z-index: 200; left: 50%; bottom: 20px; transform: translateX(-50%); font-size: 0.85rem; }
        #toast.show { visibility: visible; animation: fadein 0.3s, fadeout 0.3s 2.2s; }
        @keyframes fadein { from { bottom: 0; opacity: 0; } to { bottom: 20px; opacity: 1; } }
        @keyframes fadeout { from { bottom: 20px; opacity: 1; } to { bottom: 0; opacity: 0; } }
    </style>
</head>
<body>

    <header>
        <h1>A. P. Shah Institute of Technology — Apparatus Management</h1>
        <div class="nav-links">
            <a href="diary">View Inventory Diary</a>
            <div class="cart-badge" id="cartCount">Cart (0)</div>
        </div>
    </header>

    <div class="stats-banner">
        <div class="stat-card">
            <div class="stat-title">Total Equipment</div>
            <div class="stat-value">124</div>
            <div class="stat-sub">APSIT Registered Items</div>
        </div>
        <div class="stat-card">
            <div class="stat-title">Available in Labs</div>
            <div class="stat-value">98</div>
            <div class="stat-sub">Ready for practicals</div>
        </div>
        <div class="stat-card">
            <div class="stat-title">Active Loans / Lends</div>
            <div class="stat-value">14</div>
            <div class="stat-sub">Partner colleges</div>
        </div>
        <div class="stat-card">
            <div class="stat-title">Required Equipment</div>
            <div class="stat-value">12</div>
            <div class="stat-sub urgent">Needed for practical exams</div>
        </div>
    </div>

    <div class="search-container">
        <input type="text" id="searchInput" onkeyup="filterItems()" placeholder="Filter by equipment name, category, or vendor...">
    </div>

    <div class="product-grid" id="productGrid">
        <c:forEach var="item" items="${catalogueList}">
            <div class="card" data-name="${item.name.toLowerCase()}" data-category="${item.category.toLowerCase()}">
                <div>
                    <div class="card-img-wrapper">
                        <span class="condition-tag">${item.condition}</span>
                        <span class="stock-badge">Qty: ${item.quantity}</span>
                        <c:choose>
                            <c:when test="${item.name.contains('8086') || item.category == 'Microprocessors'}">
                                <img src="https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=400&q=80" alt="${item.name}">
                            </c:when>
                            <c:when test="${item.name.contains('Oscilloscope') || item.category == 'Oscillators'}">
                                <img src="https://images.unsplash.com/photo-1581092160607-ee22621dd758?auto=format&fit=crop&w=400&q=80" alt="${item.name}">
                            </c:when>
                            <c:when test="${item.name.contains('Workstation') || item.category == 'Computers'}">
                                <img src="https://images.unsplash.com/photo-1587831990711-23ca6441447b?auto=format&fit=crop&w=400&q=80" alt="${item.name}">
                            </c:when>
                            <c:when test="${item.name.contains('Pulley')}">
                                <img src="https://images.unsplash.com/photo-1504917595217-d4dc5ebe6122?auto=format&fit=crop&w=400&q=80" alt="${item.name}">
                            </c:when>
                            <c:when test="${item.name.contains('Voltmeter') || item.category == 'Electrical Measuring'}">
                                <img src="https://images.unsplash.com/photo-1581092335397-9583fe92d232?auto=format&fit=crop&w=400&q=80" alt="${item.name}">
                            </c:when>
                            <c:when test="${item.name.contains('Test Tubes') || item.category == 'Glassware'}">
                                <img src="https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?auto=format&fit=crop&w=400&q=80" alt="${item.name}">
                            </c:when>
                            <c:when test="${item.category == 'Chemicals'}">
                                <img src="https://images.unsplash.com/photo-1603126857599-f6e157fa2fe6?auto=format&fit=crop&w=400&q=80" alt="${item.name}">
                            </c:when>
                            <c:when test="${item.name.contains('Keyboard') || item.category == 'Peripherals'}">
                                <img src="https://images.unsplash.com/photo-1587829741301-dc798b83add3?auto=format&fit=crop&w=400&q=80" alt="${item.name}">
                            </c:when>
                            <c:when test="${item.name.contains('CPU') || item.category == 'CPUs'}">
                                <img src="https://images.unsplash.com/photo-1591799264318-7e6ef8ddb7ea?auto=format&fit=crop&w=400&q=80" alt="${item.name}">
                            </c:when>
                            <c:otherwise>
                                <img src="https://images.unsplash.com/photo-1530124566582-a618bc2615dc?auto=format&fit=crop&w=400&q=80" alt="${item.name}">
                            </c:otherwise>
                        </c:choose>
                        <span class="type-badge ${item.listingType == 'Buy' ? 'badge-buy' : 'badge-rent'}">${item.listingType}</span>
                    </div>
                    <div class="card-details">
                        <div class="item-name">${item.name}</div>
                        <div class="item-faculty">${item.ownerFaculty}</div>
                        <div class="item-vendor">${item.vendorOrRenter}</div>
                        <div class="item-desc">${item.description}</div>
                    </div>
                </div>
                <div class="card-actions">
                    <button class="btn btn-cart" onclick="addToCart('${item.name}')">Add</button>
                    <button class="btn ${item.listingType == 'Buy' ? 'btn-buy-green' : 'btn-rent-red'}" 
                            onclick="buyNow('${item.id}', '${item.name}', '${item.listingType}', '${item.vendorOrRenter}', '${item.condition}')">
                        ${item.listingType == 'Buy' ? 'Buy' : 'Rent'}
                    </button>
                </div>
            </div>
        </c:forEach>
    </div>

    <form id="checkoutForm" action="checkout.jsp" method="GET" style="display: none;">
        <input type="hidden" name="itemId" id="formItemId">
        <input type="hidden" name="itemName" id="formItemName">
        <input type="hidden" name="actionType" id="formActionType">
        <input type="hidden" name="vendorOrRenter" id="formVendor">
        <input type="hidden" name="condition" id="formCondition">
    </form>

    <div id="toast">Item added to cart</div>

    <script>
        let count = 0;

        function addToCart(name) {
            count++;
            document.getElementById('cartCount').innerText = "Cart (" + count + ")";
            showToast("Added " + name + " to cart");
        }

        function buyNow(id, name, type, vendor, condition) {
            document.getElementById('formItemId').value = id;
            document.getElementById('formItemName').value = name;
            document.getElementById('formActionType').value = type;
            document.getElementById('formVendor').value = vendor;
            document.getElementById('formCondition').value = condition;
            document.getElementById('checkoutForm').submit();
        }

        function filterItems() {
            let input = document.getElementById('searchInput').value.toLowerCase();
            let cards = document.querySelectorAll('.card');
            cards.forEach(card => {
                let name = card.getAttribute('data-name');
                let category = card.getAttribute('data-category');
                if (name.includes(input) || category.includes(input)) {
                    card.style.display = "flex";
                } else {
                    card.style.display = "none";
                }
            });
        }

        function showToast(msg) {
            let toast = document.getElementById("toast");
            toast.innerText = msg;
            toast.className = "show";
            setTimeout(() => { toast.className = toast.className.replace("show", ""); }, 2500);
        }
    </script>
</body>
</html>
