// tải phần header từ file header.html vào trang hiện tại
function loadHeader() {
    fetch('header.html')
        .then(response => response.text())
        .then(data => {
            document.getElementById('header-container').innerHTML = data;
        })
        .catch(error => console.log('Error loading header: ', error));
}

// tảii header khi trang web được load
document.addEventListener('DOMContentLoaded', loadHeader);

