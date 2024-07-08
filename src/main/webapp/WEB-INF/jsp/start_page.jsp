<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.ResourceBundle, java.util.Locale" %>

<%
    HttpSession currentSession = request.getSession();
    Locale locale = (Locale) currentSession.getAttribute("locale");
    if (locale == null) {
        locale = request.getLocale();
    }
    ResourceBundle messages = ResourceBundle.getBundle("localization.messages", locale);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%= messages.getString("title") %></title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }

    header {
        background-color: #333;
        color: #fff;
        padding: 10px;
        text-align: center;
    }

    nav {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: #666;
        color: #fff;
        padding: 10px;
        text-align: center;
    }

    .nav-center {
        flex-grow: 1;
        display: flex;
        justify-content: center;
    }

    .nav-right {
        display: flex;
        gap: 10px;
    }

    section {
        padding: 20px;
        overflow-y: auto;
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        justify-content: center;
        align-items: center;
        height: 100vh;
        flex-direction: column;
        background-image: url('images/cupra.jpg');
        background-size: cover;
        background-position: center;
    }

    article {
        margin-bottom: 20px;
    }

    footer {
        background-color: #333;
        color: #fff;
        padding: 10px;
        text-align: center;
        position: fixed;
        bottom: -180px;
        width: 100%;
        transition: bottom 0.3s;
    }

    footer:hover {
        bottom: 0;
    }

    .news-item {
        align-items: center;
        margin-bottom: 15px;
        padding-bottom: 15px;
        border-bottom: 1px solid #eee;
    }

    .img-fluid {
        width: 200px;
        height: 120px;
        margin-right: 20px;
    }

    .news-content {
        flex-grow: 1;
    }

    .news-title {
        color: #007bff;
        font-size: 20px;
    }

    .news-text {
        font-size: 14px;
        color: #FFFFFF;
    }

    .news-info {
        font-size: 12px;
        color: #999;
    }
</style>
</head>
<body>
    <header>
        <h1><%= messages.getString("title") %></h1>
        <h2><%= messages.getString("subtitle") %></h2>
    </header>
    <nav>
        <div class="nav-center">
            <a href="Controller?command=go_to_log_in_page"><%= messages.getString("login") %></a> | 
            <a href="Controller?command=go_to_registration_page"><%= messages.getString("register") %></a>
        </div>
        <div class="nav-right">
            <a href="Controller?command=set_locale&locale=en">EN</a>
            <a href="Controller?command=set_locale&locale=ru">RU</a>
        </div>
    </nav>
    <section>
        <h2><%= messages.getString("main_news") %></h2>
        <c:if test="${(sessionScope.user eq null)}">
            <div class="news-item">
                <c:forEach var="newsList" items="${newsList}">
                    <div class="news-container">
                        <img src="${newsList.picPath}" class="img-fluid">
                        <div class="news-content">
                            <h3 class="news-title">
                                <a href="Controller?command=go_to_log_in_page" style="color: #27FF00;">${newsList.title}</a>
                            </h3>
                            <p class="news-text"><a href="Controller?command=go_to_log_in_page" style="color: #FF0000;"><%= messages.getString("login_to_read") %></a></p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </section>
    <footer>
        <nav>
            <a href="Controller?command=go_to_in_process_page"><%= messages.getString("contacts") %></a> | 
            <a href="Controller?command=go_to_in_process_page"><%= messages.getString("vacancies") %></a> | 
            <a href="Controller?command=go_to_in_process_page"><%= messages.getString("feedback") %></a> |
            <a href="Controller?command=go_to_in_process_page"><%= messages.getString("support") %></a>
        </nav>
        <p><%= messages.getString("sell_garage") %></p>
        <p><%= messages.getString("sell_house") %></p>
        <p>ООО Главный Автомобильный Вестник &copy; 2024</p>
    </footer>
</body>
</html>