const container  = document.querySelector(".content");
const imgs       =10;
const baseFolder = "/imgs/fotography_stack/";
const baseURL = 'https://source.unsplash.com/random/';
const nImgs      = 12;
  

function generateUniqueRandomNumbers(min, max, count) {
    if (count > (max - min + 1)) {
        throw new Error("Count must be less than or equal to the range of numbers.");
    }
    const uniqueNumbers = [];
    while (uniqueNumbers.length < count) {
        const randomNumber = Math.floor(Math.random() * (max - min + 1)) + min;
        if (!uniqueNumbers.includes(randomNumber)) {
            uniqueNumbers.push(randomNumber);
        }
    }
    return uniqueNumbers;
}

const randomNumbers = generateUniqueRandomNumbers(1,13, imgs)

for (let i=0; i < imgs; i++ ){
  const img = document.createElement('img');
  img.src = baseFolder+randomNumbers[i]+'.jpeg';
  img.className = 'thumbnail'
  container.appendChild(img);
}