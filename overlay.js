const thumbnails = document.querySelectorAll('.thumbnail');
const overlay = document.querySelector('.overlay');
const overlayImage = document.querySelector('.overlay-image');

overlay.style.display = 'none';

function closeOverlay() {
    overlay.style.display = 'none';
}

thumbnails.forEach(thumbnail => {
    thumbnail.addEventListener('click', () => {
        // Get the source of the clicked thumbnail
        const imgSrc = thumbnail.getAttribute('src');

        // Set the source of the overlay image
        overlayImage.setAttribute('src', imgSrc);

        // Display the overlay
        overlay.style.display = 'block';
    });
});

overlayImage.addEventListener('click', closeOverlay);
overlay.addEventListener('click', closeOverlay);