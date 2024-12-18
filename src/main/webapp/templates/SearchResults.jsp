<%@ page import="Model.Bean.ArticleShow" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.Bean.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Kết quả tìm kiếm</title>
  <link rel="stylesheet" href="./static/css/header_footer_style.css">
  <link rel="stylesheet" href="./static/css/main_page.css">
</head>

<style>
  html, body {
    height: 100%; /* Đảm bảo body và html chiếm toàn bộ chiều cao của trang */
    margin: 0;
    display: flex;
    flex-direction: column;
  }

  main {
    flex: 1; /* Main sẽ chiếm toàn bộ không gian còn lại */
  }

  footer {
    padding: 20px;
    text-align: center;
  }

  .list-article {
    display : flex;
  }
  .article-container {
    display: flex;
    flex-wrap: wrap; /* Cho phép xuống dòng nếu không đủ không gian */
    align-items: flex-start;
    gap: 15px;
    margin-bottom: 20px;
    padding: 10px;
    /*border: 1px solid #ddd;*/
    border-radius: 8px;
    background-color: #f9f9f9;
  }


  .article-container img {
    width: 150px; /* Kích thước cố định cho ảnh */
    height: auto;
    object-fit: cover; /* Giữ tỉ lệ ảnh */
  }

  .article-content {
    flex: 1; /* Nội dung sẽ chiếm phần còn lại */
    word-wrap: break-word; /* Xuống dòng tự động nếu quá dài */
  }

  .article-content h2 {
    margin: 0 0 10px 0;
    font-size: 1.2em;
    color: #333;
  }

  .article-content p {
    margin: 0;
    color: #555;
    line-height: 1.4;
  }
  .article-content a {
    text-decoration: none;
    color: #333;
  }
  hr {
    margin: 10px 0; /* Khoảng cách trên và dưới */
    border: none; /* Xoá đường viền mặc định */
    height: 1px; /* Độ dày của <hr> */
    background-color: #ddd; /* Màu nền */
  }
  .search-result-header {
    text-align: center; /* Căn giữa tiêu đề */
    color: purple; /* Màu chữ tím */
    margin-bottom: 20px; /* Khoảng cách giữa tiêu đề và danh sách bài báo */
    font-size: 1.5em; /* Kích thước chữ */
  }



</style>

<%


%>
<body>
<!-- Header -->
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
    <%--        <div>--%>
    <%--            <input type="search" placeholder="Tìm kiếm thông tin...">--%>
    <%--            <button> Submit </button>--%>
    <%--        </div>--%>
    <div>
      <form action="article?action=searchinfor" method="POST">
        <input type="search" name="query" id = "query" placeholder="Tìm kiếm thông tin...">
        <button type="submit">Submit</button>
      </form>
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
        <% ArrayList<Category> categories = (ArrayList<Category>) request.getAttribute("categories"); %>
        <ul>
          <li><a href="article?action=home"><h3>Trang chủ</h3></a></li>
          <%
            for (Category category : categories) {
          %>
          <!-- Liên kết tới trang chủ để lọc bài viết theo chủ đề -->
          <li><a href="article?action=categorize&category=<%= category.name() %>"><h3><%= category.getCategory_name() %></h3></a></li>
          <%
            }
          %>
          <li><a href="article?action=add"><h3>Đăng bài</h3></a></li>
          <li><a href="#">
            <div class="hamburger-menu"></div>
            <div class="hamburger-menu"></div>
            <div class="hamburger-menu"></div>
          </a></li>
        </ul>
      </nav>
    </div>
</header>

<main>
  <% String keyword = (String) request.getAttribute("keyword"); %>
  <h1 class="search-result-header">Kết quả tìm kiếm cho từ khóa "<%= keyword%>"</h1>

  <div class="list-article">

    <%
      List<ArticleShow> articleShows = (List<ArticleShow>) request.getAttribute("articleShows");
      if (articleShows != null && !articleShows.isEmpty()) {
        for (ArticleShow article : articleShows) {
    %>
    <div class="article-container">
      <img src="<%= article.getFirst_image() %>" alt="Image" />
      <div class="article-content">
        <i>Ngày đăng bài: <%= article.getCreated_at() %></i>
        <a href="article?action=detail&id=<%= article.getId() %>">
          <h2><%= article.getTitle() %></h2>
        </a>
        <p>
          <%= article.getContent().substring(0, Math.min(article.getContent().length(), 100)) + "..." %>
        </p>
        <hr>
      </div>
    </div>
    <%
      }
    } else {
    %>
    <p>Không tìm thấy bài viết nào.</p>
    <%
      }
    %>

  </div>
</main>

<!-- Footer -->
<footer>
  <div class="footer-container">
    <div class="footer-left">
      <p>© 2024 Báo Điện Tử - Tất cả quyền lợi được bảo vệ</p>
    </div>

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
    const selectedText = this.options[this.selectedIndex].text;
    alert('Bạn đã chọn địa điểm: ' + selectedText);
  });
</script>
</body>
</html>
