const inputForm = document.getElementById('input-form');
const outputDiv = document.getElementById('output');

inputForm.addEventListener('submit', (event) => {
  event.preventDefault();
  const formData = new FormData(inputForm);
  fetch('/highlight', {
    method: 'POST',
    body: formData,
  })
    .then(response => response.json())
    .then(data => {
      outputDiv.innerHTML = data.highlighted_text;
    })
    .catch(error => console.error(error));
});
