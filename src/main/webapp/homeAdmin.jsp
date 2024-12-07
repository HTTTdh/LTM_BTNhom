<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard</title>
  <link rel="stylesheet" href="homeAdmin.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body>
<div class="dashboard">
  <aside class="sidebar">
    <div class="logo">Trang Admin</div>
    <nav>
      <ul>
        <li><a href="admin?action=listArticle"><i class="fas fa-newspaper"></i> Danh sách bài báo</a></li>
        <li><a href="admin?action=listUser"><i class="fas fa-users"></i> Danh sách người dùng</a></li>
        <li><a href="#settings"><i class="fas fa-cog"></i> Cài đặt </a></li>
        <li><a href="#logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất </a></li>
      </ul>
    </nav>
  </aside>

  <main class="main-content">
    <header class="header">
      <h1>Welcome, Admin</h1>
    </header>

    <section class="cards">
      <div class="card">
        <h2>Danh sách bài báo</h2>
        <p>Quản lý các bài báo</p>
        <button class="btn" onclick="window.location.href='admin?action=listArticle'">Xem chi tiết</button>
      </div>

      <div class="card">
        <h2>Danh sách người dùng</h2>
        <p>Quản lý tài khoản của người dùng</p>
        <button class="btn" onclick="window.location.href='admin?action=listUser'">Xem chi tiết</button>
      </div>
    </section>
  </main>
</div>
</body>
</html>
