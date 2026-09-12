// Local State Mock (Acts as intermediary before JDBC API endpoints)
let currentUser = null;

let equipmentList = [
  { id: 101, name: "Function Generator (3 MHz)", dept: "Electronics & Telecomm", specs: "Sine/Square/Triangle output", qty: 12, status: "Available" },
  { id: 102, name: "Universal Testing Machine", dept: "Mechanical / Applied Mechanics", specs: "100 kN Capacity", qty: 2, status: "Available" },
  { id: 103, name: "Digital Multimeter", dept: "Electrical Engineering", specs: "True RMS Auto-ranging", qty: 25, status: "Reserved" }
];

// Auth Switchers
function toggleAuth(type) {
  const loginForm = document.getElementById('login-form');
  const regForm = document.getElementById('register-form');
  const loginBtn = document.getElementById('show-login-btn');
  const regBtn = document.getElementById('show-register-btn');

  if (type === 'login') {
    loginForm.classList.remove('hidden');
    regForm.classList.add('hidden');
    loginBtn.classList.add('active');
    regBtn.classList.remove('active');
    document.getElementById('auth-title').innerText = "ApparatusHub Login";
  } else {
    loginForm.classList.add('hidden');
    regForm.classList.remove('hidden');
    regBtn.classList.add('active');
    loginBtn.classList.remove('active');
    document.getElementById('auth-title').innerText = "Register for ApparatusHub";
  }
}

function handleLogin(e) {
  e.preventDefault();
  const email = document.getElementById('login-email').value;
  
  // Role assignment rule mock
  let role = "FACULTY";
  if (email.includes("admin")) role = "ADMIN";
  if (email.includes("helper")) role = "LAB_HELP";

  currentUser = { name: email.split('@')[0], role: role, email: email };
  initializeDashboard();
}

function handleRegister(e) {
  e.preventDefault();
  currentUser = {
    name: document.getElementById('reg-name').value,
    role: document.getElementById('reg-role').value,
    email: document.getElementById('reg-email').value
  };
  initializeDashboard();
}

function handleLogout() {
  currentUser = null;
  document.getElementById('dashboard').classList.add('hidden');
  document.getElementById('auth-container').classList.remove('hidden');
}

// Render Dashboard based on Roles
function initializeDashboard() {
  document.getElementById('auth-container').classList.add('hidden');
  document.getElementById('dashboard').classList.remove('hidden');
  document.getElementById('user-display').innerText = `${currentUser.name} (${currentUser.role})`;

  const isAdmin = currentUser.role === 'ADMIN';
  
  // Toggle Admin Controls
  if (isAdmin) {
    document.getElementById('add-equip-btn').classList.remove('hidden');
    document.getElementById('actions-header').classList.remove('hidden');
  } else {
    document.getElementById('add-equip-btn').classList.add('hidden');
    document.getElementById('actions-header').classList.add('hidden');
  }

  renderTable();
}

function renderTable() {
  const tbody = document.getElementById('apparatus-table-body');
  const isAdmin = currentUser.role === 'ADMIN';
  tbody.innerHTML = '';

  equipmentList.forEach(item => {
    const tr = document.createElement('tr');
    tr.innerHTML = `
      <td>#${item.id}</td>
      <td><strong>${item.name}</strong></td>
      <td>${item.dept}</td>
      <td>${item.specs}</td>
      <td>${item.qty}</td>
      <td><span class="status-tag">${item.status}</span></td>
      ${isAdmin ? `
        <td>
          <button class="btn btn-edit" onclick="openModal('edit', ${item.id})">Edit</button>
          <button class="btn btn-danger" onclick="deleteEquipment(${item.id})">Delete</button>
        </td>
      ` : ''}
    `;
    tbody.appendChild(tr);
  });
}

// Modal & CRUD Operations
function openModal(mode, id = null) {
  const modal = document.getElementById('equip-modal');
  modal.classList.remove('hidden');

  if (mode === 'edit' && id) {
    document.getElementById('modal-title').innerText = "Edit Apparatus Details";
    const item = equipmentList.find(e => e.id === id);
    document.getElementById('equip-id').value = item.id;
    document.getElementById('equip-name').value = item.name;
    document.getElementById('equip-dept').value = item.dept;
    document.getElementById('equip-specs').value = item.specs;
    document.getElementById('equip-qty').value = item.qty;
    document.getElementById('equip-status').value = item.status;
  } else {
    document.getElementById('modal-title').innerText = "Add New Apparatus";
    document.getElementById('equip-form').reset();
    document.getElementById('equip-id').value = '';
  }
}

function closeModal() {
  document.getElementById('equip-modal').classList.add('hidden');
}

function handleSaveEquipment(e) {
  e.preventDefault();
  const id = document.getElementById('equip-id').value;
  const newEquip = {
    id: id ? parseInt(id) : Date.now(),
    name: document.getElementById('equip-name').value,
    dept: document.getElementById('equip-dept').value,
    specs: document.getElementById('equip-specs').value,
    qty: parseInt(document.getElementById('equip-qty').value),
    status: document.getElementById('equip-status').value
  };

  if (id) {
    const index = equipmentList.findIndex(e => e.id === parseInt(id));
    equipmentList[index] = newEquip;
  } else {
    equipmentList.push(newEquip);
  }

  closeModal();
  renderTable();
}

function deleteEquipment(id) {
  if (confirm("Are you sure you want to remove this apparatus from the database?")) {
    equipmentList = equipmentList.filter(e => e.id !== id);
    renderTable();
  }
}
