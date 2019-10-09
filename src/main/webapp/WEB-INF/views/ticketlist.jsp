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



    <title>Tickets</title>

    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>

<h2>All Tickets  <button style="float:right;margin-right:20px" type="button" class="btn btn-success" onclick="window.location.href='ticketcreate'">Create Ticket</button> </h2>




    <table class="table table-striped table-dark">
      <thead class="thead-dark">
        <tr>
          <th scope="col">ID</th>
          <th scope="col">Title</th>
          <th scope="col">Assignee</th>
          <th scope="col">Created By</th>
          <th scope="col">Status</th>

        </tr>
      </thead>
      <tbody>
           <c:forEach items="${lists}" var="lists">

                       <tr>
                            <td>${lists.getId()}</td>
                            <td>${lists.getTicketTitle()}</td>
                            <td>${lists.getAssignee()}</td>
                            <td>${lists.getCreatedBy()}</td>
                            <td>${lists.getStatus().getStatusName()}</td>

                            <td>
                               <sec:authorize access="hasRole('ADMIN')">
                                <a style = "margin-right:10px;margin-left:10px;" href="${pageContext.request.contextPath }/ticketlist/${lists.getId()}/delete " class="btn-lg btn-danger pull-right">Delete</a>
                                 </sec:authorize>
                               <sec:authorize access="hasAnyRole('ADMIN','SUPERUSER')">
                                 <a href="${pageContext.request.contextPath }/ticketlist/${lists.getId()}/view" class="btn-lg btn-primary pull-right">View</a>
                               </sec:authorize>
                            </td>
                       </tr>

            </c:forEach>
      </tbody>
    </table>






<!-- /container -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>