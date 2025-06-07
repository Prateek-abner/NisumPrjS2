<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/logreg.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Register</h1>
            <nav>
                <a href="${pageContext.request.contextPath}/">Home</a>
                <a href="${pageContext.request.contextPath}/user/login">Login</a>
            </nav>
        </header>

        <main>
            <div class="form-container">
                <form action="${pageContext.request.contextPath}/user/register" method="post">
                    <h2>Create Account</h2>

                    <c:if test="${not empty error}">
                        <div class="error">${error}</div>
                    </c:if>

                    <div class="form-group">
                        <label>First Name:</label>
                        <input type="text" name="firstName" required />
                    </div>

                    <div class="form-group">
                        <label>Last Name:</label>
                        <input type="text" name="lastName" required />
                    </div>

                    <div class="form-group">
                        <label>Email:</label>
                        <input type="email" name="email" required />
                    </div>

                    <div class="form-group">
                        <label>Password:</label>
                        <input type="password" name="password" required />
                    </div>

                    <div class="form-group">
                        <label>Phone Number:</label>
                        <input type="text" name="phoneNumber" />
                    </div>

                    <button type="submit">Register</button>
                </form>
            </div>
        </main>
    </div>
</body>
</html>
