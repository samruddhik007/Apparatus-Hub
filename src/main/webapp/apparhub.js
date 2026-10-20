document.addEventListener('DOMContentLoaded', () => {
    console.log('ApparatusHub JS loaded successfully.');

    // 1. Dynamic Client-Side Table & Card Search Filter
    const searchInput = document.querySelector('.search-input');
    const deptSelect = document.querySelector('.select-input');

    if (searchInput || deptSelect) {
        const filterItems = () => {
            const query = searchInput ? searchInput.value.toLowerCase().trim() : '';
            const dept = deptSelect ? deptSelect.value : '';

            // Filter Grid Cards (catalogue.jsp)
            const cards = document.querySelectorAll('.grid .card');
            cards.forEach(card => {
                const title = card.querySelector('.equip-title')?.textContent.toLowerCase() || '';
                const owner = card.querySelector('.equip-owner')?.textContent.toLowerCase() || '';
                const cardDept = card.querySelector('.dept-badge')?.textContent.trim() || '';

                const matchesQuery = title.includes(query) || owner.includes(query);
                const matchesDept = !dept || cardDept === dept;

                card.style.display = (matchesQuery && matchesDept) ? 'flex' : 'none';
            });

            // Filter Table Rows (diary.jsp)
            const rows = document.querySelectorAll('.table-wrapper tbody tr');
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                const rowDept = row.querySelector('.badge-dept')?.textContent.trim() || '';

                const matchesQuery = text.includes(query);
                const matchesDept = !dept || rowDept === dept;

                row.style.display = (matchesQuery && matchesDept) ? '' : 'none';
            });
        };

        if (searchInput) searchInput.addEventListener('input', filterItems);
        if (deptSelect) deptSelect.addEventListener('change', filterItems);
    }

    // 2. Request Form Confirmation Modal / Interception
    const requestForms = document.querySelectorAll('form[action="requestEquipment"]');
    requestForms.forEach(form => {
        form.addEventListener('submit', (e) => {
            const confirmBorrow = confirm('Are you sure you want to submit a borrow request for this apparatus?');
            if (!confirmBorrow) {
                e.preventDefault();
            }
        });
    });

    // 3. UI Focus Effects
    const inputs = document.querySelectorAll('.search-input, .select-input');
    inputs.forEach(input => {
        input.addEventListener('focus', () => {
            input.style.borderColor = '#c4c0b5';
        });
        input.addEventListener('blur', () => {
            input.style.borderColor = 'var(--card-border)';
        });
    });
});
