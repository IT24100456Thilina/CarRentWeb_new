// Enhanced Notification System for CarGO Application
// Provides toast notifications, alert messages, and confirmation dialogs

class NotificationManager {
    constructor() {
        this.init();
    }

    init() {
        // Create notification container if it doesn't exist
        if (!document.getElementById('notification-container')) {
            this.createNotificationContainer();
        }
    }

    createNotificationContainer() {
        const container = document.createElement('div');
        container.id = 'notification-container';
        container.className = 'position-fixed top-0 end-0 p-3';
        container.style.zIndex = '11000';
        container.innerHTML = `
            <div id="toast-notification" class="toast align-items-center text-white bg-primary border-0" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body" id="toast-message">
                        Notification message
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
            <div id="alert-notification" class="alert alert-dismissible fade show d-none" role="alert">
                <div id="alert-message">Alert message</div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        `;
        document.body.appendChild(container);
    }

    // Toast Notifications
    showToast(message, type = 'primary', duration = 5000) {
        const toastElement = document.getElementById('toast-notification');
        const toastMessage = document.getElementById('toast-message');

        if (!toastElement || !toastMessage) {
            console.error('Toast elements not found');
            return;
        }

        // Set message and type
        toastMessage.textContent = message;

        // Set background color based on type
        const bgClasses = {
            'primary': 'bg-primary',
            'success': 'bg-success',
            'danger': 'bg-danger',
            'warning': 'bg-warning',
            'info': 'bg-info'
        };

        // Remove existing bg classes
        Object.values(bgClasses).forEach(cls => {
            toastElement.classList.remove(cls);
        });

        // Add new bg class
        if (bgClasses[type]) {
            toastElement.classList.add(bgClasses[type]);
        } else {
            toastElement.classList.add('bg-primary');
        }

        // Show toast
        const toast = new bootstrap.Toast(toastElement, {
            autohide: true,
            delay: duration
        });
        toast.show();
    }

    // Alert Messages (Bootstrap style)
    showAlert(message, type = 'info', dismissible = true) {
        const alertElement = document.getElementById('alert-notification');

        if (!alertElement) {
            console.error('Alert element not found');
            return;
        }

        // Set message
        document.getElementById('alert-message').innerHTML = message;

        // Set alert type
        const alertClasses = ['alert-primary', 'alert-secondary', 'alert-success', 'alert-danger', 'alert-warning', 'alert-info'];
        alertClasses.forEach(cls => {
            alertElement.classList.remove(cls);
        });

        alertElement.classList.add(`alert-${type}`);

        // Show alert
        alertElement.classList.remove('d-none');

        // Auto-hide non-dismissible alerts after 5 seconds
        if (!dismissible) {
            setTimeout(() => {
                this.hideAlert();
            }, 5000);
        }
    }

    hideAlert() {
        const alertElement = document.getElementById('alert-notification');
        if (alertElement) {
            alertElement.classList.add('d-none');
        }
    }

    // Confirmation Dialogs
    showConfirm(message, onConfirm, onCancel = null, confirmText = 'Yes', cancelText = 'No') {
        const result = confirm(message);
        if (result && onConfirm) {
            onConfirm();
        } else if (!result && onCancel) {
            onCancel();
        }
        return result;
    }

    // Custom Modal Confirmations (more stylish)
    showConfirmModal(title, message, onConfirm, onCancel = null, confirmText = 'Confirm', cancelText = 'Cancel') {
        // Create modal if it doesn't exist
        if (!document.getElementById('confirm-modal')) {
            this.createConfirmModal();
        }

        const modal = document.getElementById('confirm-modal');
        const modalTitle = document.getElementById('confirm-modal-title');
        const modalBody = document.getElementById('confirm-modal-body');
        const confirmBtn = document.getElementById('confirm-modal-confirm');
        const cancelBtn = document.getElementById('confirm-modal-cancel');

        modalTitle.textContent = title;
        modalBody.textContent = message;
        confirmBtn.textContent = confirmText;
        cancelBtn.textContent = cancelText;

        // Set up event listeners
        confirmBtn.onclick = () => {
            bootstrap.Modal.getInstance(modal).hide();
            if (onConfirm) onConfirm();
        };

        cancelBtn.onclick = () => {
            bootstrap.Modal.getInstance(modal).hide();
            if (onCancel) onCancel();
        };

        // Show modal
        const bsModal = new bootstrap.Modal(modal);
        bsModal.show();
    }

    createConfirmModal() {
        const modal = document.createElement('div');
        modal.className = 'modal fade';
        modal.id = 'confirm-modal';
        modal.innerHTML = `
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirm-modal-title">Confirmation</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="confirm-modal-body">
                        Are you sure?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" id="confirm-modal-cancel" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary" id="confirm-modal-confirm">Confirm</button>
                    </div>
                </div>
            </div>
        `;
        document.body.appendChild(modal);
    }

    // Loading indicator
    showLoading(message = 'Loading...') {
        if (!document.getElementById('loading-modal')) {
            this.createLoadingModal();
        }

        const modal = document.getElementById('loading-modal');
        document.getElementById('loading-modal-message').textContent = message;

        const bsModal = new bootstrap.Modal(modal);
        bsModal.show();
    }

    hideLoading() {
        const modal = document.getElementById('loading-modal');
        if (modal) {
            bootstrap.Modal.getInstance(modal).hide();
        }
    }

    createLoadingModal() {
        const modal = document.createElement('div');
        modal.className = 'modal fade';
        modal.id = 'loading-modal';
        modal.innerHTML = `
            <div class="modal-dialog modal-dialog-centered modal-sm">
                <div class="modal-content">
                    <div class="modal-body text-center">
                        <div class="spinner-border text-primary mb-3" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                        <div id="loading-modal-message">Loading...</div>
                    </div>
                </div>
            </div>
        `;
        document.body.appendChild(modal);
    }

    // URL Parameter based notifications
    handleUrlNotifications() {
        const urlParams = new URLSearchParams(window.location.search);

        // Success messages
        if (urlParams.get('success')) {
            this.showToast(decodeURIComponent(urlParams.get('success')), 'success');
        }

        // Error messages
        if (urlParams.get('error')) {
            this.showToast(decodeURIComponent(urlParams.get('error')), 'danger');
        }

        // Info messages
        if (urlParams.get('info')) {
            this.showToast(decodeURIComponent(urlParams.get('info')), 'info');
        }

        // Warning messages
        if (urlParams.get('warning')) {
            this.showToast(decodeURIComponent(urlParams.get('warning')), 'warning');
        }

        // Login success
        if (urlParams.get('login') === '1') {
            this.showToast('Login successful! Welcome back.', 'success');
        }

        // Registration success
        if (urlParams.get('registration') === 'success') {
            this.showToast('Registration successful! Please login to continue.', 'success');
        }

        // Booking related
        if (urlParams.get('bookingCreated') === '1') {
            this.showToast('Booking created successfully!', 'success');
        }
        if (urlParams.get('bookingUpdated') === '1') {
            this.showToast('Booking updated successfully!', 'success');
        }
        if (urlParams.get('bookingDeleted') === '1') {
            this.showToast('Booking deleted successfully!', 'success');
        }

        // Payment related
        if (urlParams.get('paymentCompleted') === '1') {
            this.showToast('Payment completed successfully!', 'success');
        }
        if (urlParams.get('paymentFailed') === '1') {
            this.showToast('Payment failed. Please try again.', 'danger');
        }

        // Vehicle related
        if (urlParams.get('vehicleAdded') === '1') {
            this.showToast('Vehicle added successfully!', 'success');
        }
        if (urlParams.get('vehicleUpdated') === '1') {
            this.showToast('Vehicle updated successfully!', 'success');
        }

        // User related
        if (urlParams.get('userCreated') === '1') {
            this.showToast('User created successfully!', 'success');
        }
        if (urlParams.get('userUpdated') === '1') {
            this.showToast('User updated successfully!', 'success');
        }

        // Staff related
        if (urlParams.get('staffAdded') === '1') {
            this.showToast('Staff member added successfully!', 'success');
        }
        if (urlParams.get('staffUpdated') === '1') {
            this.showToast('Staff member updated successfully!', 'success');
        }

        // Campaign related
        if (urlParams.get('campaignSent') === '1') {
            this.showToast('Campaign sent successfully!', 'success');
        }

        // Feedback related
        if (urlParams.get('feedbackSubmitted') === '1') {
            this.showToast('Thank you for your feedback!', 'success');
        }
    }
}

// Create global instance
const notificationManager = new NotificationManager();

// Convenience functions for global use
function showToast(message, type = 'primary', duration = 5000) {
    notificationManager.showToast(message, type, duration);
}

function showAlert(message, type = 'info', dismissible = true) {
    notificationManager.showAlert(message, type, dismissible);
}

function showConfirm(message, onConfirm, onCancel = null, confirmText = 'Yes', cancelText = 'No') {
    return notificationManager.showConfirm(message, onConfirm, onCancel, confirmText, cancelText);
}

function showConfirmModal(title, message, onConfirm, onCancel = null, confirmText = 'Confirm', cancelText = 'Cancel') {
    notificationManager.showConfirmModal(title, message, onConfirm, onCancel, confirmText, cancelText);
}

function showLoading(message = 'Loading...') {
    notificationManager.showLoading(message);
}

function hideLoading() {
    notificationManager.hideLoading();
}

// Initialize URL-based notifications when DOM is ready
document.addEventListener('DOMContentLoaded', function() {
    notificationManager.handleUrlNotifications();
});
