<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ApparatusHub | APSIT Equipment Log</title>

  <!-- External Stylesheet link -->
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/apparhub.css">

  <style>
    :root {
      --bg-cream: #faf9f5;
      --surface-white: #ffffff;
      --card-border: #eae8e1;
      --text-main: #2d312e;
      --text-muted: #737871;
      
      /* Soft Pastel Accents */
      --pastel-sage: #e2ebd8;
      --pastel-sage-dark: #3b5240;
      --pastel-sand: #f4efe6;
      --pastel-sand-dark: #635745;
      --pastel-rose: #fce8e6;
      --pastel-rose-dark: #8c3b36;
      --pastel-blue: #e3edf7;
      --pastel-blue-dark: #2b4c6f;
      
      --radius: 12px;
      --shadow-subtle: 0 4px 15px rgba(0, 0, 0, 0.02);
    }

    * { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      background-color: var(--bg-cream);
      color: var(--text-main);
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
      padding: 2rem 1rem;
    }

    .container { max-width: 1080px; margin: 0 auto; }

    /* Header Section */
    header {
      display: flex;
      justify-content: space-between;
      align-items: flex-end;
      margin-bottom: 2rem;
      padding-bottom: 1rem;
      border-bottom: 1px solid var(--card-border);
    }
    
    .institute-title h1 { font-size: 1.6rem; font-weight: 600; margin-bottom: 0.2rem; }
    .institute-title p { font-size: 0.9rem; color: var(--text-muted); }
    
    .college-badge {
      font-size: 0.85rem;
      background: var(--surface-white);
      border: 1px solid var(--card-border);
      padding: 0.4rem 0.9rem;
      border-radius: 20px;
      color: var(--pastel-blue-dark);
      background-color: var(--pastel-blue);
      font-weight: 500;
    }

    /* Summary Dashboard Cards */
    .summary-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 1.2rem;
      margin-bottom: 2rem;
    }

    .stat-card {
      background: var(--surface-white);
      border: 1px solid var(--card-border);
      border-radius: var(--radius);
      padding: 1.2rem 1.5rem;
      box-shadow: var(--shadow-subtle);
    }
    .stat-card .label { font-size: 0.8rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.05em; }
    .stat-card .value { font-size: 1.8rem; font-weight: 600; margin-top: 0.4rem; color: var(--text-main); }

    /* Filters & Controls */
    .control-bar {
      display: flex;
      justify-content: space-between;
      gap: 1rem;
      margin-bottom: 1.5rem;
      flex-wrap: wrap;
    }

    .search-input, .select-input {
      background: var(--surface-white);
      border: 1px solid var(--card-border);
      padding: 0.75rem 1rem;
      border-radius: var(--radius);
      font-size: 0.9rem;
      outline: none;
      color: var(--text-main);
    }
    .search-input { flex: 1; min-width: 240px; }

    /* Log Table Styling */
    .table-wrapper {
      background: var(--surface-white);
      border: 1px solid var(--card-border);
      border-radius: var(--radius);
      box-shadow: var(--shadow-subtle);
      overflow-x: auto;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      text-align: left;
      font-size: 0.9rem;
    }

    th {
      background: #f7f6f0;
      color: var(--text-muted);
      font-weight: 500;
      padding: 0.9rem 1.2rem;
      border-bottom: 1px solid var(--card-border);
      font-size: 0.8rem;
      text-transform: uppercase;
      letter-spacing: 0.03em;
    }

    td {
      padding: 1rem 1.2rem;
      border-bottom: 1px solid #f2f1ea;
      vertical-align: middle;
    }

    tr:last-child td { border-bottom: none; }
    tr:hover { background-color: #faf9f5; }

    /* Badges */
    .badge {
      font-size: 0.75rem;
      font-weight: 500;
      padding: 0.3rem 0.65rem;
      border-radius: 6px;
      display: inline-block;
    }
    .badge-dept { background: var(--pastel-sand); color: var(--pastel-sand-dark); }
    .badge-available { background: var(--pastel-sage); color: var(--pastel-sage-dark); }
    .badge-loaned { background: var(--pastel-rose); color: var(--pastel-rose-dark); }

    .equip-id { font-family: monospace; font-size: 0.85rem; color: var(--text-muted); }
  </style>
</head>
<body>

  <div class="container">
    <!-- Header -->
    <header>
      <div class="institute-title">
        <h1>Equipment Log & Register</h1>
        <p>Central Inventory Registry — A. P. Shah Institute of Technology, Thane</p>
      </div>
      <div class="college-badge">
        APSIT Campus
      </div>
    </header>

    <!-- Summary Stats Row -->
    <div class="summary-grid">
      <div class="stat-card">
        <div class="label">Total Equipment Logged</div>
        <div class="value">${totalCount != null ? totalCount : '0'}</div>
      </div>
      <div class="stat-card">
        <div class="label">In-House Available</div>
        <div class="value" style="color: var(--pastel-sage-dark);">${availableCount != null ? availableCount : '0'}</div>
      </div>
      <div class="stat-card">
        <div class="label">On Loan / Borrowed</div>
        <div class="value" style="color: var(--pastel-rose-dark);">${loanedCount != null ? loanedCount : '0'}</div>
      </div>
    </div>

    <!-- Search & Department Filter -->
    <form action="diary" method="GET" class="control-bar">
      <input 
        type="text" 
        name="search" 
        class="search-input" 
        placeholder="Filter by instrument name or lab location..." 
        value="${param.search}" 
      />
      
      <select name="dept" class="select-input" onchange="this.form.submit()">
        <option value="">All Departments</option>
        <option value="EXTC / Electronics" ${param.dept == 'EXTC / Electronics' ? 'selected' : ''}>EXTC / Electronics</option>
        <option value="Computer / IT" ${param.dept == 'Computer / IT' ? 'selected' : ''}>Computer / IT</option>
        <option value="Mechanical" ${param.dept == 'Mechanical' ? 'selected' : ''}>Mechanical</option>
        <option value="Civil" ${param.dept == 'Civil' ? 'selected' : ''}>Civil</option>
      </select>
    </form>

    <!-- Inventory Register Table -->
    <div class="table-wrapper">
      <table>
        <thead>
          <tr>
            <th>Asset ID</th>
            <th>Apparatus / Instrument</th>
            <th>Department</th>
            <th>Lab Location</th>
            <th>Quantity</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${not empty apsitEquipmentList}">
              <c:forEach var="item" items="${apsitEquipmentList}">
                <tr>
                  <td class="equip-id">APSIT-EQ-${item.equipmentId}</td>
                  <td><strong>${item.name}</strong></td>
                  <td><span class="badge badge-dept">${item.department}</span></td>
                  <td>${item.labLocation != null ? item.labLocation : 'Main Engineering Lab'}</td>
                  <td>${item.quantity} units</td>
                  <td>
                    <c:choose>
                      <c:when test="${item.quantity > 0}">
                        <span class="badge badge-available">In Stock</span>
                      </c:when>
                      <c:otherwise>
                        <span class="badge badge-loaned">Loaned / In Use</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            
            <c:otherwise>
              <tr>
                <td colspan="6" style="text-align: center; padding: 3rem 1rem; color: var(--text-muted);">
                  No equipment records logged for A. P. Shah Institute of Technology matching your filter.
                </td>
              </tr>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
    </div>
  </div>

  <!-- JavaScript link -->
  <script src="${pageContext.request.contextPath}/apparhub.js"></script>
</body>
</html>
