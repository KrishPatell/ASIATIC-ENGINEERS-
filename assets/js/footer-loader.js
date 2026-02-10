/**
 * Universal Footer Loader
 * Loads the footer component into all pages
 */
(function() {
	'use strict';
	
	// Load footer when DOM is ready
	if (document.readyState === 'loading') {
		document.addEventListener('DOMContentLoaded', loadFooter);
	} else {
		loadFooter();
	}
	
	function loadFooter() {
		var footerContainer = document.getElementById('footer-container');
		
		if (!footerContainer) {
			console.warn('Footer container not found. Make sure you have <div id="footer-container"></div> in your HTML.');
			return;
		}
		
		// Fetch footer HTML
		fetch('assets/components/footer.html')
			.then(function(response) {
				if (!response.ok) {
					throw new Error('Failed to load footer: ' + response.status);
				}
				return response.text();
			})
			.then(function(html) {
				footerContainer.innerHTML = html;
				
				// Trigger any initialization scripts that depend on footer being loaded
				if (typeof window.footerLoaded === 'function') {
					window.footerLoaded();
				}
			})
			.catch(function(error) {
				console.error('Error loading footer:', error);
				// Fallback: show error message or use inline footer
				footerContainer.innerHTML = '<div style="padding: 20px; text-align: center; color: #999;">Footer could not be loaded.</div>';
			});
	}
})();
