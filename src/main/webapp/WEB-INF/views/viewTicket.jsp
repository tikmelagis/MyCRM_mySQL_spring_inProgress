<%--
  Created by IntelliJ IDEA.
  User: jonas
  Date: 09/10/2019
  Time: 18:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<jsp:include page="header.jsp" />
<head>
    <title>View Ticket</title>
    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">

    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>

</head>
<body>

<div class="container">



<table class="table ">
    <div style="display: inline-block">
        <h2><b>General</b></h2>
        <b>Ticket ID:</b> ${ticket.id}
        <br>
        <b>Title:</b> ${ticket.ticketTitle}
        <br>
        <b>Status:</b> ${ticket.status.statusName}
        <br>
        <b>Assignee:</b> ${ticket.assignee}
        <br>
        <b>Created By:</b> ${ticket.createdBy}
    </div>
    <div style="display: inline-block; margin-left: 20%; position: absolute">
        <h2><b>Object</b></h2>
        <b>ID:</b> ${ticket.objectD.id}
        <br>
        <b>Company Name:</b> ${ticket.objectD.companyName}
        <br>
        <b>Address:</b> ${ticket.objectD.street} g. ${ticket.objectD.houseNumber}, ${ticket.objectD.city}
    </div>


</table>

</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>
