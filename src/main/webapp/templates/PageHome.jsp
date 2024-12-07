<%@ page import="Model.Bean.Article" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.Bean.Category" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Báo Điện Tử</title>
    <link rel="stylesheet" href="../static/css/header_footer.css">
    <link rel="stylesheet" href="../static/css/PageHomeStyle.css">
    <title>HomePage</title>
    <style>
        .weather-info {
            display: flex;
            align-items: center;
            font-size: 16px;
            color: #333;
            margin-left: 10px; /* Khoảng cách giữa địa chỉ và biểu tượng mây */
        }
        .weather-info i {
            margin-right: 5px; /* Khoảng cách giữa biểu tượng mây và nhiệt độ */
        }

        /* Định dạng cho bài báo lớn */
        .main-article {
            margin: 20px;
            padding: 20px;
            background-color: #f9f9f9;
        }

        .main-article h1 {
            font-size: 28px;
            color: #333;
        }

        .main-article p {
            font-size: 16px;
            color: #666;
        }

        .large-article-image {
            width: 100%;
            height: auto;
            margin-top: 20px;
        }

        /* Định dạng cho 3 bài baos nhỏ */
        .small-articles {
            display: flex;
            justify-content: space-between;
            margin: 20px;
        }

        .small-article {
            width: 30%;
            padding: 15px;
            background-color: #f0f0f0;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .small-article img {
            width: 100%;
            height: auto;
        }

        .small-article h3 {
            font-size: 18px;
            color: #333;
        }

        .small-article p {
            font-size: 14px;
            color: #666;
        }

        /* Đảm bảo bài viết nhỏ sẽ xếp chồng lên nhau khi kích thước màn hình nhỏ */
        @media (max-width: 768px) {
            .small-articles {
                flex-direction: column;
            }

            .small-article {
                width: 100%;
            }
        }

        html, body {
            height: 100%;
            margin: 0;
        }

        body {
            display: flex;
            flex-direction: column;
            min-height: 100%;
        }

        /* Phần main sẽ chiếm hết không gian còn lại */
        main {
            flex-grow: 1;
        }

        footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding-top: 25px;
            padding-bottom: 20px;
            width: 100%;
            height: 80px;
            bottom: 0;
        }

        .logo {
            border: 5px solid #FF5733;
            border-radius: 15px;
            width: 65px;
            height: auto; /* Giữ tỷ lệ khung hình gốc */

        }

        /* Định dạng cho các bài viết phía dưới */
        .bottom-articles {
            display: flex;
            justify-content: space-between;
            margin: 20px;
        }

        .left-articles {
            width: 60%;
        }

        .right-articles {
            width: 35%;
        }

        /* Định dạng cho bài viết bên trái */
        .left-article {
            background-color: #f0f0f0;
            padding: 15px;
            margin-bottom: 15px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .left-article h3 {
            font-size: 20px;
            color: #333;
        }

        .left-article p {
            font-size: 14px;
            color: #666;
        }

        /* Định dạng cho bài viết bên phải */
        .right-article {
            background-color: #f0f0f0;
            padding: 20px;
            margin-bottom: 15px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .right-article h3 {
            font-size: 24px;
            color: #333;
        }

        .right-article p {
            font-size: 16px;
            color: #666;
        }

    </style>
</head>
<script>

</script>
<%
    ArrayList<Article> top10Articles = (ArrayList<Article>) request.getAttribute("articles");
    ArrayList<Category> categories = (ArrayList<Category>) request.getAttribute("categories");

    Article mainArticle = top10Articles.get(0);
    ArrayList<Article> sideMainArticles = new ArrayList<>(top10Articles.subList(1, 3));
%>
<body>
<header class="header">
    <div class="header-content">
        <img src="../static/resources/logo.png" alt="Logo" class="logo">
        <div class="text">
            <span id="current-date"></span>
        </div>
        <div>
            <label for="location-select">Địa điểm: </label>
            <select id="location-select">
                <option value="HaNoi">Hà Nội</option>
                <option value="HoChiMinh">Hồ Chí Minh</option>
                <option value="DaNang">Đà Nẵng</option>
                <option value="HaiPhong">Hải Phòng</option>
                <option value="CanTho">Cần Thơ</option>
            </select>
        </div>
        <div>
            <input type="search" placeholder="Tìm kiếm thông tin...">
            <button> Submit </button>
        </div>
        <div>
            <button>
                <i class="fas fa-sign-in-alt"></i> Đăng nhập
            </button>
        </div>
        <div>
            <i class="fas fa-bell"></i>
        </div>
    </div>
    <nav style="padding-top: 25px; padding-bottom: 15px;">
        <ul>
            <li><a href="#"><i class="fas fa-home" style ="font-size: 25px;"></i></a></li>
            <%
                for (Category category : categories) {
            %>
            <li><a href="#"><h3><%= category.getCategory_name() %></h3></a>
            </li>
            <%
                }
            %>
            <li><a href="#">
                <div class="hamburger-menu"></div>
                <div class="hamburger-menu"></div>
                <div class="hamburger-menu"></div>
                </a>
            </li>
        </ul>
    </nav>
</header>

<main>
    <div class="main-article">
        <h1>
            <%= mainArticle.getTitle() %>
<%--            Bài báo lớn: Tiêu đề bài báo--%>
        </h1>
        <p>Đoạn văn mở đầu của bài báo lớn </p>
        <img src="large-article-image.jpg" alt="Hình ảnh bài báo lớn" class="large-article-image">
        <p>
            <%= mainArticle.getContent() %>
<%--            Đoạn nội dung bài báo lớn sẽ được trình bày ở đây...--%>
        </p>
    </div>

    <div class="small-articles">
        <h2>Bài viết liên quan</h2>
        <div class="small-article">
            <img src="small-article-1.jpg" alt="Hình ảnh bài viết 1" class="small-article-image">
            <h3><a href="#">Tiêu đề bài viết nhỏ 1</a></h3>
            <p>Đoạn văn mô tả ngắn về bài viết nhỏ 1...</p>
        </div>
        <div class="small-article">
            <img src="small-article-2.jpg" alt="Hình ảnh bài viết 2" class="small-article-image">
            <h3><a href="#">Tiêu đề bài viết nhỏ 2</a></h3>
            <p>Đoạn văn mô tả ngắn về bài viết nhỏ 2...</p>
        </div>
        <div class="small-article">
            <img src="small-article-3.jpg" alt="Hình ảnh bài viết 3" class="small-article-image">
            <h3><a href="#">Tiêu đề bài viết nhỏ 3</a></h3>
            <p>Đoạn văn mô tả ngắn về bài viết nhỏ 3...</p>
        </div>
    </div>

    <!-- Chia trang làm hai phần: Bên trái 4 bài báo, bên phải 2 bài báo lớn hơn -->
    <div class="bottom-articles">
        <div class="left-articles">
            <div class="left-article">
                <h3>Tiêu đề bài viết 1</h3>
                <img src="left-article-1.jpg" alt="Hình ảnh bài viết 1" class="left-article-image">
                <p>Đoạn mô tả về bài viết 1...</p>
            </div>
            <div class="left-article">
                <h3>Tiêu đề bài viết 2</h3>
                <img src="left-article-1.jpg" alt="Hình ảnh bài viết 1" class="left-article-image">
                <p>Đoạn mô tả về bài viết 2...</p>
            </div>
            <div class="left-article">
                <h3>Tiêu đề bài viết 3</h3>
                <img src="left-article-1.jpg" alt="Hình ảnh bài viết 1" class="left-article-image">
                <p>Đoạn mô tả về bài viết 3...</p>
            </div>
            <div class="left-article">
                <h3>Tiêu đề bài viết 4</h3>
                <img src="left-article-1.jpg" alt="Hình ảnh bài viết 1" class="left-article-image">
                <p>Đoạn mô tả về bài viết 4...</p>
            </div>
        </div>

        <div class="right-articles">
            <div class="right-article">
                <%
                    for (Article article : sideMainArticles) {
                %>
                    <h3><%= article.getTitle() %></h3>
                    <img src="right-article-1.jpg" alt="Hình ảnh bài viết lớn 1" class="right-article-image">
                    <p><%= article.getContent() %></p>
                <%
                 }
                %>
            </div>
        </div>
    </div>
</main>


<footer>
    <div class="footer-container">
        <div class="footer-left">
            <p>© 2024 Báo Điện Tử - Tất cả quyền lợi được bảo vệ</p>
        </div>

        <!-- Liên kết tới các trang quan trọng -->
        <div class="footer-middle">
            <ul>
                <li><a href="#">Giới thiệu</a></li>
                <li><a href="#">Liên hệ</a></li>
                <li><a href="#">Quy chế hoạt động</a></li>
                <li><a href="#">Chính sách bảo mật</a></li>
                <li><a href="#">Tuyển dụng</a></li>
                <li><a href="#">Tin tức mới nhất</a></li>
                <li><a href="#">Hướng dẫn sử dụng</a></li>
            </ul>
        </div>

        <!-- Các lk mạng xã hội -->
        <div class="footer-right">
            <ul>
                <li><a href="#" class="social-icon"><i class="fab fa-facebook-f"></i> Facebook</a></li>
                <li><a href="#" class="social-icon"><i class="fab fa-twitter"></i> Twitter</a></li>
                <li><a href="#" class="social-icon"><i class="fab fa-youtube"></i> YouTube</a></li>
                <li><a href="#" class="social-icon"><i class="fab fa-instagram"></i> Instagram</a></li>
            </ul>
        </div>
    </div>
</footer>

<!-- biểu tượng mạng xã hội -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<script>
    const currentDate = new Date();
    document.getElementById('current-date').textContent = currentDate.toLocaleDateString('vi-VN', {
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric',
    });

    const locationSelect = document.getElementById('location-select');
    locationSelect.addEventListener('change', function() {
        const selectedText = this.options[this.selectedIndex].text; // Lấy giá trị text
        alert('Bạn đã chọn địa điểm: '+ selectedText);
    });
</script>
</body>
</html>
