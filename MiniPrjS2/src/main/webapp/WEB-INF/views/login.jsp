<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/logreg.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Login</h1>
            <nav>
                <a href="${pageContext.request.contextPath}/">Home</a>
                <a href="${pageContext.request.contextPath}/user/register">Register</a>
            </nav>
        </header>

        <main>
            <div class="form-container">
                <form action="${pageContext.request.contextPath}/user/login" method="post">
                    <h2>User Login</h2>

                    <c:if test="${not empty error}">
                        <div class="error">${error}</div>
                    </c:if>

                    <c:if test="${not empty message}">
                        <div class="success">${message}</div>
                    </c:if>

                    <div class="form-group">
                        <label>Email:</label>
                        <input type="email" name="email" required />
                    </div>

                    <div class="form-group">
                        <label>Password:</label>
                        <input type="password" name="password" required />
                    </div>

                    <button type="submit">Login</button>
                </form>
            </div>
        </main>
    </div>
</body>
</html>
