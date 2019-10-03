<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">

<jsp:include page="header.jsp" />

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">



    <title>Welcome</title>

    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>

<h2>All Users  <button style="float:right;margin-right:20px" type="button" class="btn btn-success" onclick="window.location.href='registration'">Create User</button> </h2>



<c:if test="${not empty lists}">
    <table class="table table-striped table-dark">
      <thead class="thead-dark">
        <tr>
          <th scope="col">ID</th>
          <th scope="col">Username</th>
          <th scope="col">First Name</th>
          <th scope="col">Last Name</th>
          <th scope="col">Staff Position</th>
          <th scope="col">Role</th>
        </tr>
      </thead>
      <tbody>
           <c:forEach items="${lists}" var="lists">

                       <tr>
                            <td>${lists.getId()}</td>
                            <td>${lists.getUsername()}</td>
                            <td>${lists.getFirstName()}</td>
                            <td>${lists.getLastName()}</td>
                            <td>${lists.getStaffPosition()}</td>
                            <td>
                            <c:choose>
                                <c:when test="${lists.getRoleChoose()==1}">
                                    User
                                </c:when>
                                <c:when test="${lists.getRoleChoose()==2}">
                                    Admin
                                </c:when>
                                <c:when test="${lists.getRoleChoose()==3}">
                                    Superuser
                                </c:when>
                            </c:choose>
                            </td>

                            <td>
                            <sec:authorize access="hasRole('ADMIN')">
                            <a style = "margin-right:10px;margin-left:10px;" href="${pageContext.request.contextPath }/useris/${lists.getId()}/delete " class="btn-lg btn-danger pull-right">Delete</a>
                            </sec:authorize>
                            <sec:authorize access="hasAnyRole('ADMIN','SUPERUSER')">
                            <a href="${pageContext.request.contextPath }/useris/${lists.getId()}/update" class="btn-lg btn-primary pull-right">Update</a>
                            </sec:authorize>
                            </td>


                       </tr>

            </c:forEach>
      </tbody>
    </table>

</c:if>




<!-- /container -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>