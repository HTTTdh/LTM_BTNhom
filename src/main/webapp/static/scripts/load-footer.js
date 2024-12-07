// tải phần footer từ file footer.html vào trang hiện tại
function loadFooter() {
    fetch('footer.html')
        .then(response => response.text())
        .then(data => {
            document.getElementById('footer-container').innerHTML = data;
        })
        .catch(error => console.log('Error loading footer: ', error));
}

// Tải footer khi trang web được load
document.addEventListener('DOMContentLoaded', loadFooter);
