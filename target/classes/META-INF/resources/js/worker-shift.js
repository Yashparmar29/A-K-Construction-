/**
 * A K Construction - Real-Time Worker Shift & Punch In/Out Manager
 */

class WorkerShiftManager {
    constructor() {
        this.storageKey = 'ak_worker_shift_state';
        this.timerInterval = null;
        this.init();
    }

    getState() {
        const saved = localStorage.getItem(this.storageKey);
        if (saved) {
            try {
                return JSON.parse(saved);
            } catch (e) {
                console.error("Error parsing shift state", e);
            }
        }
        return {
            isPunchedIn: false,
            punchInTimestamp: null,
            totalSecondsToday: 28800 // default 8 hours base
        };
    }

    saveState(state) {
        localStorage.setItem(this.storageKey, JSON.stringify(state));
        this.updateUI();
    }

    punchIn() {
        const state = this.getState();
        if (state.isPunchedIn) return;

        state.isPunchedIn = true;
        state.punchInTimestamp = Date.now();
        this.saveState(state);
        this.startTimer();
    }

    punchOut() {
        const state = this.getState();
        if (!state.isPunchedIn) return;

        const elapsedSec = Math.floor((Date.now() - state.punchInTimestamp) / 1000);
        state.totalSecondsToday += elapsedSec;
        state.isPunchedIn = false;
        state.punchInTimestamp = null;
        this.saveState(state);
        this.stopTimer();

        const hours = (elapsedSec / 3600).toFixed(2);
        alert(`Punch Out Successful! Shift Duration: ${this.formatDuration(elapsedSec)} (${hours} hrs added).`);
    }

    formatDuration(totalSeconds) {
        const hrs = Math.floor(totalSeconds / 3600);
        const mins = Math.floor((totalSeconds % 3600) / 60);
        const secs = totalSeconds % 60;
        return `${String(hrs).padStart(2, '0')}h ${String(mins).padStart(2, '0')}m ${String(secs).padStart(2, '0')}s`;
    }

    getCurrentShiftElapsedSeconds() {
        const state = this.getState();
        if (!state.isPunchedIn || !state.punchInTimestamp) return 0;
        return Math.floor((Date.now() - state.punchInTimestamp) / 1000);
    }

    startTimer() {
        this.stopTimer();
        this.timerInterval = setInterval(() => {
            this.updateCounterDisplay();
        }, 1000);
        this.updateCounterDisplay();
    }

    stopTimer() {
        if (this.timerInterval) {
            clearInterval(this.timerInterval);
            this.timerInterval = null;
        }
        this.updateCounterDisplay();
    }

    updateCounterDisplay() {
        const state = this.getState();
        const elapsed = this.getCurrentShiftElapsedSeconds();
        const total = state.totalSecondsToday + elapsed;

        const shiftTimerEl = document.getElementById('liveShiftTimer');
        const totalHoursEl = document.getElementById('liveTotalHoursWorked');
        const punchBtn = document.getElementById('punchToggleBtn');
        const statusBadge = document.getElementById('shiftStatusBadge');
        const punchTimeMsg = document.getElementById('punchTimeMessage');

        if (shiftTimerEl) {
            shiftTimerEl.textContent = this.formatDuration(elapsed);
        }

        if (totalHoursEl) {
            const hrsDecimal = (total / 3600).toFixed(1);
            totalHoursEl.textContent = `${hrsDecimal} hrs`;
        }

        if (punchBtn && statusBadge) {
            if (state.isPunchedIn) {
                punchBtn.className = "btn btn-danger btn-lg w-100 fw-bold rounded-3 shadow";
                punchBtn.innerHTML = '<i class="fas fa-sign-out-alt me-2"></i> PUNCH OUT (End Shift)';
                punchBtn.onclick = () => this.punchOut();

                statusBadge.className = "badge status-pill-active rounded-pill";
                statusBadge.innerHTML = '<span class="pulse-dot me-1.5"></span> ON DUTY - Active Shift';

                if (punchTimeMsg && state.punchInTimestamp) {
                    const startTimeStr = new Date(state.punchInTimestamp).toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' });
                    punchTimeMsg.textContent = `Started at ${startTimeStr}`;
                }
            } else {
                punchBtn.className = "btn btn-success btn-lg w-100 fw-bold rounded-3 shadow";
                punchBtn.innerHTML = '<i class="fas fa-fingerprint me-2"></i> PUNCH IN (Start Shift)';
                punchBtn.onclick = () => this.punchIn();

                statusBadge.className = "badge status-pill-off rounded-pill";
                statusBadge.innerHTML = '<i class="fas fa-bed me-1.5"></i> OFF DUTY';

                if (punchTimeMsg) {
                    punchTimeMsg.textContent = 'Click Punch In when on site';
                }
            }
        }
    }

    updateUI() {
        this.updateCounterDisplay();
    }

    init() {
        document.addEventListener('DOMContentLoaded', () => {
            const state = this.getState();
            if (state.isPunchedIn) {
                this.startTimer();
            } else {
                this.updateCounterDisplay();
            }
        });
    }
}

window.workerShift = new WorkerShiftManager();
