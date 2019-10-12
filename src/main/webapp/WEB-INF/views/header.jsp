<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Welcome</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">
    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<form:form id="logoutForm" method="POST" action="${contextPath}/logout">
           <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      </form:form>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">MyCRM</a>
    </div>
    <ul class="navbar-nav mr-auto">
      <li><a href="/welcome" class="nav-link">Home</a></li>
      <li><a href="/useris" class="nav-link">Users</a></li>
      <li><a href="/ticketlist" class="nav-link">Ticket</a></li>
    </ul>
    <ul class="nav navbar-nav navbar-right">
      <li style="color:white"><a class="nav-link"><i class="fas fa-user"></i>
     ${pageContext.request.userPrincipal.name} </a>
      </li>

        <li><a href="#" onclick="document.forms['logoutForm'].submit()" class="nav-link"><i class="fas fa-sign-out-alt"></i> Logout </a></li>
    </ul>
  </div>
</nav>


<div class="container">
