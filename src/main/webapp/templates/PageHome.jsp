<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.Bean.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Báo Điện Tử</title>
    <link rel="stylesheet" href="./static/css/header_footer_style.css">
    <link rel="stylesheet" href="./static/css/main_page.css">
    <title>HomePage</title>
</head>
<script>

</script>
<%
    ArrayList<ArticleShow> top10Articles = (ArrayList<ArticleShow>) request.getAttribute("articles");
    ArrayList<Category> categories = (ArrayList<Category>) request.getAttribute("categories");
    ArrayList<String> introductionLines = (ArrayList<String>) request.getAttribute("introductionLines");

    ArticleShow mainArticle = top10Articles.get(0);
    String mainLine = introductionLines.get(0);

    ArrayList<ArticleShow> sideMainArticles = new ArrayList<>(top10Articles.subList(1, 3));
    ArrayList<String> sideMainLines = new ArrayList<>(introductionLines.subList(1, 3));

    ArrayList<ArticleShow> miniArticles = new ArrayList<>(top10Articles.subList(3, 6));
    ArrayList<String> miniLines = new ArrayList<>(introductionLines.subList(3, 6));

    ArrayList<ArticleShow> normalArticles = new ArrayList<>(top10Articles.subList(6, 10));
    ArrayList<String> normalLines = new ArrayList<>(introductionLines.subList(6, 10));
%>
<body>
<header class="header">
    <div class="header-content">
        <img src="./static/resources/logo.png" alt="Logo" class="logo">
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
        <div class="weather-info">
            <i class="fas fa-cloud"></i> <!-- Biểu tượng mây -->
            <span>21°C</span> <!-- Nhiệt độ -->
        </div>
        <div>
            <input type="search" placeholder="Tìm kiếm thông tin...">
            <button> Submit </button>
        </div>

            <%
                if (session.getAttribute("user") != null) {
                    UserShow user = (UserShow) session.getAttribute("user");
            %>
                    <div>
                        <h4>
                            Xin chào,
                            <%=user.getFullName() %>
                        </h4>
                    </div>
                    <div>
                        <button>
                            <i class="fas fa-sign-in-alt"></i> Đăng xuất
                        </button>
                    </div>
        <%
            }else{
        %>
                    <div>
                        <button onclick="navigateToLogin()">
                            <i class="fas fa-sign-in-alt"></i> Đăng nhập
                        </button>
                    </div>
        <%
            }
        %>

        <div style="width: 100%">

    <nav style="padding-top: 25px; padding-bottom: 15px;">
        <ul>
            <li><a href="article?action=home"><h3>Trang chủ</h3></a></li>
            <%
                for (Category category : categories) {
            %>
            <li><a href="#"><h3><%= category.getCategory_name() %></h3></a>
            </li>
            <%
                }
            %>
            <li><a href="article?action=add"><h3>Đăng bài</h3></a>
            <li><a href="#">
                <div class="hamburger-menu"></div>
                <div class="hamburger-menu"></div>
                <div class="hamburger-menu"></div>
                </a>
            </li>
        </ul>
    </nav>
        </div>
</header>

<main>
        <div class="main-article">
            <a href="article?action=detail&id=<%=mainArticle.getId()%>">
                <div class="main-article-content">

                    <img src="<%= mainArticle.getFirst_image() %>" alt="Hình ảnh bài báo lớn" class="large-article-image">

                    <div class="article-content">
                        <h1> <%= mainArticle.getTitle() %> </h1>
                        <p><%= mainLine %></p>
                    </div>
                </div>
            </a>
        </div>

        <h2>Bài viết liên quan</h2>
    <div class="small-articles">
            <% for (int i = 0; i < miniArticles.size(); i++) {
                ArticleShow article = miniArticles.get(i);
                String line = miniLines.get(i);

            %>
            <div class="small-article">
        <a href="article?action=detail&id=<%=article.getId()%>">
            <div>

                <img src="<%= article.getFirst_image() %>" alt="Hình ảnh bài viết <%= i %>" class="small-article-image">
                <h3><%= article.getTitle() %></h3>
                <p><%= line %></p>
            </div>
        </a>
            </div>
            <% } %>

    </div>

    <!-- Chia trang làm hai phần: Bên trái 4 bài báo, bên phải 2 bài báo lớn hơn -->
    <div class="bottom-articles">
        <div class="left-articles">
            <% for (int i = 0; i < normalArticles.size(); i++) {
                ArticleShow article = normalArticles.get(i);
                String line = normalLines.get(i);
            %>
            <a href="article?action=detail&id=<%=article.getId()%>">
                <div class="left-article">
                    <h3> <%= article.getTitle() %></h3>
                    <img src="<%= article.getFirst_image() %>" style="max-width: 400px" alt="Hình ảnh bài viết 1" class="left-article-image">
                    <p> <%=line%> </p>
                </div>
            </a>
            <% } %>
        </div>

        <div class="right-articles">
                <%
                    for (int i = 0; i < sideMainArticles.size(); i++) {
                        ArticleShow article = sideMainArticles.get(i);
                        String line = sideMainLines.get(i);
                %>
                    <a href="article?action=detail&id=<%=article.getId()%>">
                        <div class="right-article">
                                <h3><%= article.getTitle() %></h3>
                                <img src="<%= article.getFirst_image() %>" style="max-width: 480px" alt="Hình ảnh bài viết lớn 1" class="right-article-image">
                                <p><%= line %></p>
                        </div>
                    </a>
                <%
                 }
                %>
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
