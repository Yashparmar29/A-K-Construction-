/**
 * A K Construction - Real-Time Contractor Site Supervision & Punch In/Out Manager
 */

class ContractorShiftManager {
    constructor() {
        this.storageKey = 'ak_contractor_shift_state';
        this.timerInterval = null;
        this.init();
    }

    getState() {
        const saved = localStorage.getItem(this.storageKey);
        if (saved) {
            try {
                return JSON.parse(saved);
            } catch (e) {
                console.error("Error parsing contractor shift state", e);
            }
        }
        return {
            isPunchedIn: false,
            punchInTimestamp: null,
            totalSecondsToday: 25200 // default 7 hrs site supervision base
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
        alert(`Site Supervision Completed! Active Time: ${this.formatDuration(elapsedSec)} (${hours} hrs logged).`);
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

        const shiftTimerEl = document.getElementById('liveContractorTimer');
        const totalHoursEl = document.getElementById('liveContractorTotalHours');
        const punchBtn = document.getElementById('contractorPunchBtn');
        const statusBadge = document.getElementById('contractorStatusBadge');
        const punchTimeMsg = document.getElementById('contractorPunchMsg');

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
                punchBtn.innerHTML = '<i class="fas fa-sign-out-alt me-2"></i> PUNCH OUT (End Supervision)';
                punchBtn.onclick = () => this.punchOut();

                statusBadge.className = "badge status-pill-active rounded-pill";
                statusBadge.innerHTML = '<span class="pulse-dot me-1.5"></span> ON SITE SUPERVISION';

                if (punchTimeMsg && state.punchInTimestamp) {
                    const startTimeStr = new Date(state.punchInTimestamp).toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' });
                    punchTimeMsg.textContent = `Active site session since ${startTimeStr}`;
                }
            } else {
                punchBtn.className = "btn btn-success btn-lg w-100 fw-bold rounded-3 shadow";
                punchBtn.innerHTML = '<i class="fas fa-fingerprint me-2"></i> PUNCH IN (Start Site Duty)';
                punchBtn.onclick = () => this.punchIn();

                statusBadge.className = "badge status-pill-off rounded-pill";
                statusBadge.innerHTML = '<i class="fas fa-pause-circle me-1.5"></i> OFF SITE';

                if (punchTimeMsg) {
                    punchTimeMsg.textContent = 'Click Punch In when inspecting site';
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

window.contractorShift = new ContractorShiftManager();
