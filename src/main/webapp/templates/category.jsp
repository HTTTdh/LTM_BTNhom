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
  /* Đặt các bài viết hiển thị theo hàng dọc và cách nhau */
  .article-container {
    display: flex;
    flex-direction: column;
    margin-bottom: 5px;
    padding: 10px;

    background-color: #f9f9f9;
  }

  /* Chỉnh kích thước ảnh */
  .article-container img {
    width: 150px;
    height: 150px;
    object-fit: cover;
    margin-bottom: 10px;
    border-radius: 15px;
  }

  /* Căn chỉnh nội dung bài viết */
  .article-content {
    margin-top: 10px;
  }

  .article-content a {
    text-decoration: none;
    color: #333;
  }

  .article-content a:hover {
    color: purple;
  }

  .article-container p {
    margin: 0;
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
  <h1 style="color: purple;">Kết quả tìm kiếm</h1>
  <%
    List<ArticleShow> articleShows = (List<ArticleShow>) request.getAttribute("ListCategory");
    if (articleShows != null && !articleShows.isEmpty()) {
      for (ArticleShow article : articleShows) {
  %>
  <div class="article-container">
    <div>
      <p>
        <img src="<%= article.getFirst_image() %>" alt="Image" />
      </p>
    </div>
    <div class="article-content" Style = "padding-bottom : 60px;margin-top:0;">
      <a href="article?action=detail&id=<%= article.getId() %>">
        <h2><%= article.getTitle() %></h2>
      </a>
      <p >
        <%= article.getContent().substring(0, Math.min(article.getContent().length(), 100)) + "..." %>
      </p>
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
