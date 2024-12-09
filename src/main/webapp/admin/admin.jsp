<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
<div class="admin-dashboard">
  <header class="header">
    <div class="logo">Admin Panel</div>
    <div class="user-info">
      <span>Welcome, Admin</span>
      <button class="logout-btn">Logout</button>
    </div>
  </header>

  <aside class="sidebar">
    <nav>
      <ul>
        <li><a href="#dashboard">Dashboard</a></li>
        <li><a href="#manage-articles">Manage Articles</a></li>
        <li><a href="#manage-users">Manage Users</a></li>
        <li><a href="#settings">Settings</a></li>
      </ul>
    </nav>
  </aside>

  <main class="main-content">
    <h1>Manage Articles</h1>
    <div class="actions">
      <input type="text" placeholder="Search articles..." class="search-bar">
      <select class="filter">
        <option value="">All</option>
        <option value="approved">Approved</option>
        <option value="pending">Pending</option>
      </select>
    </div>
    <table class="data-table">
      <thead>
      <tr>
        <th>Title</th>
        <th>Author</th>
        <th>Date</th>
        <th>Status</th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody>
      <tr>
        <td>Article 1</td>
        <td>John Doe</td>
        <td>2024-12-06</td>
        <td>Approved</td>
        <td>
          <button class="edit-btn">Edit</button>
          <button class="delete-btn">Delete</button>
        </td>
      </tr>
      <tr>
        <td>Article 2</td>
        <td>Jane Smith</td>
        <td>2024-12-05</td>
        <td>Pending</td>
        <td>
          <button class="edit-btn">Edit</button>
          <button class="delete-btn">Delete</button>
        </td>
      </tr>
      </tbody>
    </table>
  </main>
</div>
</body>
</html>
