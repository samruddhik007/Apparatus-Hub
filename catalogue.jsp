<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ApparatusHub | Inter-College Lab Catalogue</title>

  <!-- Linking your existing apparhub.css file -->
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/apparhub.css">

  <style>
    :root {
      --bg-cream: #faf9f5;
      --surface-white: #ffffff;
      --card-border: #eae8e1;
      --text-main: #2d312e;
      --text-muted: #737871;
      --pastel-sage: #e2ebd8;
      --pastel-sage-dark: #3b5240;
      --pastel-rose: #fce8e6;
      --pastel-rose-dark: #8c3b36;
      --pastel-sand: #f4efe6;
      --pastel-sand-dark: #635745;
      --radius: 12px;
    }

    body {
      background-color: var(--bg-cream);
      color: var(--text-main);
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
      margin: 0;
      padding: 2rem 1rem;
    }

    .container { max-width: 1080px; margin: 0 auto; }

    header {
      display: flex;
      justify-content: space-between;
      align-items: flex-end;
      margin-bottom: 2rem;
      padding-bottom: 1rem;
      border-bottom: 1px solid var(--card-border);
    }
    header h1 { font-size: 1.6rem; font-weight: 600; margin: 0; }
    header p { font-size: 0.9rem; color: var(--text-muted); margin: 0.2rem 0 0 0; }
    
    .user-pill {
      font-size: 0.85rem;
      background: var(--surface-white);
      border: 1px solid var(--card-border);
      padding: 0.4rem 0.9rem;
      border-radius: 20px;
      color: var(--text-muted);
    }

    .filter-bar { display: flex; gap: 1rem; margin-bottom: 2rem; flex-wrap: wrap; }
    
    .search-input, .select-input {
      background: var(--surface-white);
      border: 1px solid var(--card-border);
      padding: 0.75rem 1rem;
      border-radius: var(--radius);
      font-size: 0.9rem;
      outline: none;
    }
    .search-input { flex: 1; min-width: 220px; }

    .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 1.5rem; }

    .card {
      background: var(--surface-white);
      border: 1px solid var(--card-border);
      border-radius: var(--radius);
      padding: 1.5rem;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.02);
    }

    .card-meta { display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.8rem; }
    
    .dept-badge {
      font-size: 0.75rem;
      padding: 0.3rem 0.6rem;
      border-radius: 6px;
      background: var(--pastel-sand);
      color: var(--pastel-sand-dark);
    }

    .status-badge { font-size: 0.75rem; font-weight: 600; padding: 0.3rem 0.6rem; border-radius: 6px; }
    .status-available { background: var(--pastel-sage); color: var(--pastel-sage-dark); }
    .status-unavailable { background: var(--pastel-rose); color: var(--pastel-rose-dark); }

    .equip-title { font-size: 1.1rem; font-weight: 500; margin-bottom: 0.4rem; }
    .equip-owner { font-size: 0.85rem; color: var(--text-muted); margin-bottom: 1.2rem; }

    .card-footer { display: flex; justify-content: space-between; align-items: center; padding-top: 0.8rem; border-top: 1px solid #f5f4f0; }

    .btn-request {
      background: var(--text-main);
      color: var(--surface-white);
      border: none;
      padding: 0.5rem 1rem;
      border-radius: 8px;
      font-size: 0.85rem;
      cursor: pointer;
    }
    .btn-disabled { background: #e5e3dc; color: #a3a096; cursor: not-allowed; }
  </style>
</head>
<body>

  <div class="container">
    <!-- Header -->
    <header>
      <div>
        <h1>ApparatusHub</h1>
        <p>Inter-College Engineering Equipment Directory — Thane</p>
      </div>
      <div class="user-pill">
        Prof. ${sessionScope.user != null ? sessionScope.user.email : 'Faculty'}
      </div>
    </header>

    <!-- Filter & Search Controls -->
    <form action="catalogue" method="GET" class="filter-bar">
      <input 
        type="text" 
        name="query" 
        class="search-input" 
        placeholder="Search Oscilloscope, UTM, Raspberry Pi..." 
        value="${param.query}" 
      />
      
      <select name="department" class="select-input" onchange="this.form.submit()">
        <option value="">All Departments</option>
        <option value="EXTC / Electronics" ${param.department == 'EXTC / Electronics' ? 'selected' : ''}>EXTC / Electronics</option>
        <option value="Computer / IT" ${param.department == 'Computer / IT' ? 'selected' : ''}>Computer / IT</option>
        <option value="Mechanical" ${param.department == 'Mechanical' ? 'selected' : ''}>Mechanical</option>
        <option value="Civil" ${param.department == 'Civil' ? 'selected' : ''}>Civil</option>
      </select>
    </form>

    <!-- Equipment List Rendered via JDBC Controller -->
    <div class="grid">
      <c:choose>
        <c:when test="${not empty equipmentList}">
          <c:forEach var="item" items="${equipmentList}">
            <div class="card">
              <div>
                <div class="card-meta">
                  <span class="dept-badge">${item.department}</span>
                  <c:choose>
                    <c:when test="${item.quantity > 0}">
                      <span class="status-badge status-available">Available</span>
                    </c:when>
                    <c:otherwise>
                      <span class="status-badge status-unavailable">In Use</span>
                    </c:otherwise>
                  </c:choose>
                </div>
                
                <h2 class="equip-title">${item.name}</h2>
                <p class="equip-owner">${item.ownerCollegeOrVendor}</p>
              </div>

              <div class="card-footer">
                <span style="font-size:0.85rem;">Qty: <strong>${item.quantity}</strong></span>
                
                <c:choose>
                  <c:when test="${item.quantity > 0}">
                    <form action="requestEquipment" method="POST" style="margin:0;">
                      <input type="hidden" name="equipmentId" value="${item.equipmentId}" />
                      <button type="submit" class="btn-request">Request</button>
                    </form>
                  </c:when>
                  <c:otherwise>
                    <button class="btn-request btn-disabled" disabled>Unavailable</button>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
          </c:forEach>
        </c:when>
        
        <c:otherwise>
          <div style="grid-column: 1 / -1; text-align: center; padding: 4rem 1rem; color: var(--text-muted);">
            <p>No lab equipment found.</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <!-- Linking your existing apparhub.js file -->
  <script src="${pageContext.request.contextPath}/apparhub.js"></script>
</body>
</html>
