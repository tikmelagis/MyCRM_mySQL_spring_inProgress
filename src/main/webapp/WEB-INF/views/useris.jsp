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

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">

    <title>Welcome</title>

    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div class="filter" id="filteris">
    <input type="text" id="myFilterUN" onkeyup="myFilterUsername()" placeholder="Username.." class="filterTag">
    <input type="text" id="myFilterFN" onkeyup="myFilterFirstName()" placeholder="First name.." class="filterTag">
    <input type="text" id="myFilterLN" onkeyup="myFilterLastName()" placeholder="Last name.." class="filterTag">
<select class="filterTag" id="myFilterSP" onclick="myFilterStaffPosition()">
    <option value="">Staff Position</option>
    <c:forEach items="${listStaff}" var="listStaff">
        <option value="${listStaff.staffPosition}">${listStaff.staffPosition}</option>
    </c:forEach>
</select>

</div>

<script src="${contextPath}/resources/js/filter.js"></script>

<br>
<h2>All Users
    <div class="btn-group" style="float:right">
    <button  type="button" class="btn btn-success" onclick="window.location.href='registration'">Create User</button>
    <button  type="button" class="btn btn-info" onclick="myFilter()"><i class="fas fa-filter"></i></button>
    </div>
</h2>



<c:if test="${not empty lists}">
    <table class="table table-striped table-light" id="myTable">
      <thead class="thead-dark">
        <tr>
          <th scope="col">ID</th>
          <th scope="col">Username</th>
          <th scope="col">First Name</th>
          <th scope="col">Last Name</th>
          <th scope="col">Staff Position</th>
          <th scope="col">Role</th>
            <th scope="col"></th>
        </tr>
      </thead>
      <tbody>
           <c:forEach items="${lists}" var="lists">

                       <tr>
                            <td>${lists.getId()}</td>
                            <td>${lists.getUsername()}</td>
                            <td>${lists.getFirstName()}</td>
                            <td>${lists.getLastName()}</td>
                            <td>${lists.staffPosition.staffPosition}</td>
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
                                <div class="btn-group">
                            <sec:authorize access="hasRole('ADMIN')">
                                <button onclick="window.location.href='useris/${lists.getId()}/delete'"  class="btn btn-danger"><i class="fas fa-trash"></i></button>
                            </sec:authorize>
                            <sec:authorize access="hasAnyRole('ADMIN','SUPERUSER')">
                                <button onclick="window.location.href='useris/${lists.getId()}/update'"  class="btn btn-primary"><i class="fas fa-edit"></i></button>
                            </sec:authorize>
                                </div>
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