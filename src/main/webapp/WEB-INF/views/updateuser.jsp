<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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

    <title>Create an account</title>

    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet">



    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<div class="container" >
<spring:url value="/useris" var="userActionUrl" />

	<form:form class="form-horizontal" method="POST" modelAttribute="userForma" action="${userActionUrl}">

		<form:hidden path="id" />

		<form:hidden path="username" />

		<form:hidden path="password" />

		<spring:bind path="firstName">
        			<div class="form-group ${status.error ? 'has-error' : ''}">
        				<label class="col-sm-2 control-label">First Name</label>
        				<div class="col-sm-10">
        					<form:input path="firstName" type="text" class="form-control " id="firstName" placeholder="First Name" />

        				</div>
        			</div>
        </spring:bind>

        <spring:bind path="lastName">
                			<div class="form-group ${status.error ? 'has-error' : ''}">
                				<label class="col-sm-2 control-label">Last Name</label>
                				<div class="col-sm-10">
                					<form:input path="lastName" type="text" class="form-control " id="lastName" placeholder="Last Name" />

                				</div>
                			</div>
         </spring:bind>





         <spring:bind path="staffPosition_id">
                 			<div class="form-group ${status.error ? 'has-error' : ''}">
                 				<label class="col-sm-2 control-label">Staff Position</label>
                 				<div class="col-sm-10">
                 				    <form:select path="staffPosition_id" type="text" class="form-control " id="staffPosition_id">
										<form:options items="${listStaff}" itemValue="id" itemLabel="staffPosition"/>
                                    </form:select>
                 				</div>
                 			</div>
         </spring:bind>

         <spring:bind path="roleChoose">
                          			<div class="form-group ${status.error ? 'has-error' : ''}">
                          				<label class="col-sm-2 control-label">Role</label>
                          				<div class="col-sm-10">
                          				    <form:select path="roleChoose" type="text" class="form-control " id="roleChoose">

                                               <form:option value="1" label="User"/>
                                               <sec:authorize access="hasRole('ADMIN')">
                                                   <form:option value="2" label="Admin"/>
                                               </sec:authorize>

                                                <form:option value="3" label="Superuser"/>
                                             </form:select>
                          				</div>
                          			</div>
         </spring:bind>




        <div class="form-group">
        			<div class="col-sm-offset-2 col-sm-10">
        						<button type="submit" class="btn-lg btn-primary pull-right">Update</button>
        			</div>
        </div>

	</form:form>

</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>