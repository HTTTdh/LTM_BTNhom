<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: url('./static/resources/image.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            font-family: Arial, sans-serif;
        }

        form {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            width: 320px;
            position: relative;
            z-index: 1;
            backdrop-filter: blur(5px);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        label {
            display: block;
            font-size: 14px;
            margin-bottom: 8px;
            color: #555;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 14px;
        }

        input:focus {
            outline: none;
            border-color: #007bff;
        }

        .buttons {
            display: flex;
            justify-content: space-between;
        }

        button {
            padding: 10px 20px;
            border: none;
            background-color: #007bff;
            color: #fff;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s;
        }

        button[type="reset"] {
            background-color: #6c757d;
        }

        button:hover {
            background-color: #0056b3;
        }

        button[type="reset"]:hover {
            background-color: #5a6268;
        }

        .error-message {
            color: red;
            font-size: 14px;
            text-align: center;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
<form action="login" method="POST">
    <h2>Đăng nhập </h2>

    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="error-message">
        <%= request.getAttribute("errorMessage") %>
    </div>
    <% } %>

    <label for="username">Tên đăng nhập:</label>
    <input type="text" name="username" id="username" placeholder="Nhập tên đăng nhập" required />

    <label for="password">Mật khẩu:</label>
    <input type="password" name="password" id="password" placeholder="Nhập mật khẩu " required />

    <div class="buttons">
        <button type="submit">Đăng nhập</button>
        <button type="reset">Hủy</button>
    </div>
</form>
</body>
</html>
