const container  = document.querySelector(".content");
const baseFolder = "/imgs/fotography_stack/";
const baseURL    = 'https://source.unsplash.com/random/';
const imgs       = 23
const imgs_disp  = 12
  

function generateUniqueRandomNumbers(min, max, count) {
    if (count > (max - min + 1)) {
        throw new Error("Count must be less than or equal to the range of numbers.");
    }
    const uniqueNumbers = [];
    while (uniqueNumbers.length < count) {
        const randomNumber = Math.floor(Math.random() * (max - min + 1)) + min;
        const formattedNumber = String(randomNumber).padStart(3, '0'); // Format as 3-digit string
        if (!uniqueNumbers.includes(formattedNumber)) {
            uniqueNumbers.push(formattedNumber);
        }
    }
    return uniqueNumbers;
}

const randomNumbers = generateUniqueRandomNumbers(1,imgs, imgs)
console.log(randomNumbers);

for (let i=0; i < imgs_disp; i++ ){
  const img = document.createElement('img');
  img.src = baseFolder+randomNumbers[i]+'.jpg';
  img.className = 'thumbnail'
  img.draggable = false
  container.appendChild(img);
}