const thumbnails = document.querySelectorAll('.thumbnail');
const overlay = document.querySelector('.overlay');
const overlayImage = document.querySelector('.overlay-image');
const closeBtn = document.querySelector('.close');

overlay.style.display = 'none';

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

closeBtn.addEventListener('click', () => {
    // Close the overlay when the close button is clicked
    overlay.style.display = 'none';
});

overlay.addEventListener('click', (event) => {
    // Close the overlay when clicking outside the image
    if (event.target === overlay) {
        overlay.style.display = 'none';
    }
});
