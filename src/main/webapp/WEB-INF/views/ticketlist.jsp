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
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>

    <![endif]-->
</head>
<body>
<script src="${contextPath}/resources/js/filter.js"></script>
<div class="filter" id="filteris">
    <input type="text" id="myFilterT" onkeyup="myFilterTitle()" placeholder="Title.." class="filterTag">
    <input type="text" id="myFilterA" onkeyup="myFilterAssignee()" placeholder="Assignee.." class="filterTag">
    <input type="text" id="myFilterC" onkeyup="myFilterCreatedBy()" placeholder="Created By.." class="filterTag">

</div>
<br>
<h2>All Tickets
    <div class="btn-group" style="float:right">
        <button  type="button" class="btn btn-success" onclick="window.location.href='ticketcreate'">Create Ticket</button>
        <button  type="button" class="btn btn-info" onclick="myFilter()"><i class="fas fa-filter"></i></button>
    </div>
</h2>



    <table class="table table-striped table-light" id="tableTicket">
      <thead class="thead-dark">
        <tr>
          <th scope="col">ID</th>
          <th scope="col">Title</th>
          <th scope="col">Assignee</th>
          <th scope="col">Created By</th>
          <th scope="col">Status</th>
            <th scope="col"></th>

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
                                <div class="btn-group">
                               <sec:authorize access="hasRole('ADMIN')">
                                <button onclick="window.location.href='ticketlist/${lists.getId()}/delete'"  class="btn btn-danger"><i class="fas fa-trash"></i></button>
                                 </sec:authorize>
                               <sec:authorize access="hasAnyRole('ADMIN','SUPERUSER')">
                                 <button onclick="window.location.href='ticketlist/${lists.getId()}/view'"  class="btn btn-primary"><i class="fas fa-eye"></i></button>
                               </sec:authorize>
                                </div>
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