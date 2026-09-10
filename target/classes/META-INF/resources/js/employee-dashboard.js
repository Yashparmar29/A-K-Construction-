/**
 * A K Construction - Employee Dashboard Logic & Chart.js Visualizations
 * AdminLTE Style Interactive Script
 */

document.addEventListener('DOMContentLoaded', function () {
    // 1. Initialize Real-Time Live Clock
    initLiveClock();

    // 2. Initialize Chart.js Graphs
    initWeeklyAttendanceChart();
    initTaskCompletionChart();
    initProjectProgressChart();

    // 3. Setup Interactive Event Listeners
    setupTaskChecklistListeners();
    setupAttendancePunch();
    setupNotificationFilters();
    setupSidebarToggle();
});

/**
 * Live Clock Display
 */
function initLiveClock() {
    const clockEl = document.getElementById('liveClock');
    if (!clockEl) return;

    function updateTime() {
        const now = new Date();
        const options = { hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: true };
        clockEl.textContent = now.toLocaleTimeString('en-US', options);
    }

    updateTime();
    setInterval(updateTime, 1000);
}

/**
 * Chart 1: Weekly Attendance Hours (Bar + Line Target)
 */
function initWeeklyAttendanceChart() {
    const ctx = document.getElementById('weeklyAttendanceChart');
    if (!ctx) return;

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            datasets: [
                {
                    label: 'Logged Work Hours',
                    data: [8.5, 9.0, 8.2, 8.8, 9.5, 5.0, 0],
                    backgroundColor: 'rgba(245, 158, 11, 0.85)',
                    borderColor: '#f59e0b',
                    borderWidth: 1,
                    borderRadius: 6,
                    barThickness: 24
                },
                {
                    label: 'Daily Target (8.0 hrs)',
                    data: [8, 8, 8, 8, 8, 8, 8],
                    type: 'line',
                    borderColor: '#3b82f6',
                    borderWidth: 2,
                    borderDash: [5, 5],
                    fill: false,
                    pointRadius: 0
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'top',
                    labels: {
                        font: { family: 'Inter', size: 12, weight: '600' },
                        usePointStyle: true
                    }
                },
                tooltip: {
                    backgroundColor: '#0f172a',
                    padding: 10,
                    callbacks: {
                        label: function (context) {
                            return ` ${context.dataset.label}: ${context.raw} hrs`;
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    max: 12,
                    grid: { color: '#e2e8f0' },
                    ticks: {
                        font: { family: 'Inter', size: 11 },
                        callback: function (value) { return value + 'h'; }
                    }
                },
                x: {
                    grid: { display: false },
                    ticks: { font: { family: 'Inter', size: 11, weight: '600' } }
                }
            }
        }
    });
}

/**
 * Chart 2: Task Completion Status (Doughnut Chart)
 */
function initTaskCompletionChart() {
    const ctx = document.getElementById('taskCompletionChart');
    if (!ctx) return;

    new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['Completed Tasks', 'Pending Tasks', 'In Progress', 'On Hold'],
            datasets: [{
                data: [5, 3, 2, 1],
                backgroundColor: [
                    '#10b981', // Green
                    '#f59e0b', // Yellow
                    '#3b82f6', // Blue
                    '#ef4444'  // Red
                ],
                borderWidth: 3,
                borderColor: '#ffffff',
                hoverOffset: 6
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'right',
                    labels: {
                        font: { family: 'Inter', size: 12, weight: '500' },
                        padding: 15,
                        usePointStyle: true
                    }
                },
                tooltip: {
                    backgroundColor: '#0f172a',
                    padding: 10
                }
            },
            cutout: '70%'
        }
    });
}

/**
 * Chart 3: Project Progress Breakdown (Horizontal Bar Chart)
 */
function initProjectProgressChart() {
    const ctx = document.getElementById('projectProgressChart');
    if (!ctx) return;

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [
                'Skyrise Commercial Tower',
                'Green Valley Residential',
                'Metro Flyover Phase 2',
                'Apex Smart Residency'
            ],
            datasets: [{
                label: 'Progress Percentage (%)',
                data: [92, 78, 45, 20],
                backgroundColor: [
                    '#10b981',
                    '#f59e0b',
                    '#3b82f6',
                    '#8b5cf6'
                ],
                borderRadius: 6,
                barThickness: 20
            }]
        },
        options: {
            indexAxis: 'y',
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false },
                tooltip: {
                    backgroundColor: '#0f172a',
                    callbacks: {
                        label: function (context) { return ` Progress: ${context.raw}%`; }
                    }
                }
            },
            scales: {
                x: {
                    beginAtZero: true,
                    max: 100,
                    grid: { color: '#e2e8f0' },
                    ticks: {
                        callback: function (val) { return val + '%'; }
                    }
                },
                y: {
                    grid: { display: false },
                    ticks: { font: { family: 'Inter', size: 11, weight: '600' } }
                }
            }
        }
    });
}

/**
 * Interactive Task Checklist Handlers
 */
function setupTaskChecklistListeners() {
    const checkboxes = document.querySelectorAll('.task-checkbox');
    const completedCounter = document.getElementById('completedTasksCounter');
    const pendingCounter = document.getElementById('pendingTasksCounter');
    const progressFill = document.getElementById('taskProgressBarFill');

    checkboxes.forEach(cb => {
        cb.addEventListener('change', function () {
            const taskItem = this.closest('.task-item');
            if (this.checked) {
                taskItem.classList.add('completed');
            } else {
                taskItem.classList.remove('completed');
            }

            // Recalculate counts
            const total = checkboxes.length;
            const checkedCount = document.querySelectorAll('.task-checkbox:checked').length;
            const uncheckedCount = total - checkedCount;

            if (completedCounter) completedCounter.textContent = checkedCount;
            if (pendingCounter) pendingCounter.textContent = uncheckedCount;

            if (progressFill) {
                const percent = Math.round((checkedCount / total) * 100);
                progressFill.style.width = percent + '%';
                progressFill.setAttribute('aria-valuenow', percent);
            }
        });
    });
}

/**
 * Attendance Punch In / Punch Out System Simulation
 */
function setupAttendancePunch() {
    const punchBtn = document.getElementById('attendancePunchBtn');
    const statusBadge = document.getElementById('attendanceStatusBadge');
    const statusText = document.getElementById('attendanceStatusText');

    if (!punchBtn) return;

    let isPunchedIn = true;

    punchBtn.addEventListener('click', function () {
        if (isPunchedIn) {
            // Clock Out action
            isPunchedIn = false;
            punchBtn.innerHTML = '<i class="fas fa-sign-in-alt me-1"></i> Punch In';
            punchBtn.className = 'btn btn-success btn-sm quick-action-btn';
            
            if (statusBadge) {
                statusBadge.className = 'badge bg-secondary';
                statusBadge.textContent = 'Off Duty';
            }
            if (statusText) {
                statusText.textContent = 'Punched Out at ' + new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
            }
            showToast('Attendance Updated', 'You have successfully punched OUT.', 'info');
        } else {
            // Clock In action
            isPunchedIn = true;
            punchBtn.innerHTML = '<i class="fas fa-sign-out-alt me-1"></i> Punch Out';
            punchBtn.className = 'btn btn-outline-warning btn-sm quick-action-btn';
            
            if (statusBadge) {
                statusBadge.className = 'badge bg-success';
                statusBadge.textContent = 'On Duty';
            }
            if (statusText) {
                statusText.textContent = 'Checked In (' + new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) + ')';
            }
            showToast('Attendance Updated', 'You have successfully punched IN.', 'success');
        }
    });
}

/**
 * Notification Filter Tabs
 */
function setupNotificationFilters() {
    const filterBtns = document.querySelectorAll('.notification-filter-btn');
    const notifItems = document.querySelectorAll('.notification-item');

    filterBtns.forEach(btn => {
        btn.addEventListener('click', function () {
            filterBtns.forEach(b => b.classList.remove('active'));
            this.classList.add('active');

            const filter = this.getAttribute('data-filter');

            notifItems.forEach(item => {
                if (filter === 'all') {
                    item.style.display = 'flex';
                } else {
                    const category = item.getAttribute('data-category');
                    if (category === filter) {
                        item.style.display = 'flex';
                    } else {
                        item.style.display = 'none';
                    }
                }
            });
        });
    });
}

/**
 * Mobile Sidebar Toggle
 */
function setupSidebarToggle() {
    const toggleBtn = document.getElementById('sidebarToggleBtn');
    const sidebar = document.getElementById('appSidebar');
    const overlay = document.getElementById('sidebarOverlay');

    if (!toggleBtn || !sidebar) return;

    toggleBtn.addEventListener('click', function () {
        sidebar.classList.toggle('sidebar-open');
        if (overlay) overlay.classList.toggle('active');
    });

    if (overlay) {
        overlay.addEventListener('click', function () {
            sidebar.classList.remove('sidebar-open');
            overlay.classList.remove('active');
        });
    }
}

/**
 * Simple Toast Alert helper
 */
function showToast(title, message, type) {
    const container = document.getElementById('toastContainer');
    if (!container) return;

    const toast = document.createElement('div');
    toast.className = `toast show align-items-center text-white bg-${type === 'danger' ? 'danger' : type === 'info' ? 'info' : 'success'} border-0 mb-2`;
    toast.role = 'alert';
    toast.innerHTML = `
        <div class="d-flex">
            <div class="toast-body">
                <strong>${title}:</strong> ${message}
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
        </div>
    `;
    container.appendChild(toast);
    setTimeout(() => {
        toast.remove();
    }, 4000);
}
