// GitHub Stars Fetcher
async function fetchGitHubStars() {
    const repo = 'Hanan-Ali-Haider/Peak-Cut';
    const elements = document.querySelectorAll('#star-count, #stars-count');

    try {
        const response = await fetch(`https://api.github.com/repos/${repo}`, {
            headers: { 'Accept': 'application/vnd.github.v3+json' }
        });

        if (!response.ok) throw new Error('Failed to fetch');

        const data = await response.json();
        const stars = data.stargazers_count;

        elements.forEach(el => {
            el.textContent = formatNumber(stars);
        });
    } catch (error) {
        console.warn('Could not fetch GitHub stars:', error);
        elements.forEach(el => {
            el.textContent = '—';
        });
    }
}

function formatNumber(num) {
    if (num >= 1000000) return (num / 1000000).toFixed(1) + 'M';
    if (num >= 1000) return (num / 1000).toFixed(1) + 'K';
    return num.toString();
}

// Smooth scroll for anchor links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
        const targetId = this.getAttribute('href');
        if (targetId === '#') return;
        const target = document.querySelector(targetId);
        if (target) {
            e.preventDefault();
            const headerHeight = document.querySelector('.header').offsetHeight;
            const targetPosition = target.getBoundingClientRect().top + window.pageYOffset - headerHeight;
            window.scrollTo({ top: targetPosition, behavior: 'smooth' });
        }
    });
});

// Initialize
document.addEventListener('DOMContentLoaded', () => {
    fetchGitHubStars();
});