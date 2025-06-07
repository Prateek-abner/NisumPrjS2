<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>E-Commerce Store</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; padding: 50px; }
        .welcome { background: #f0f0f0; padding: 30px; border-radius: 10px; }
        a { color: #3498db; text-decoration: none; font-size: 18px; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="welcome">
        <h1>Welcome to E-Commerce Store</h1>
        <p>Your one-stop shop for all your needs!</p>
        <p><a href="${pageContext.request.contextPath}/home">Enter Store</a></p>
    </div>
</body>
</html>
