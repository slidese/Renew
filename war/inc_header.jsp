<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="assets/ico/favicon.png">

    <title>Renew</title>

    <!-- Bootstrap core CSS -->
    <link href="/assets/css/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="assets/css/pages.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="assets/js/html5shiv.js"></script>
      <script src="assets/js/respond.min.js"></script>
    <![endif]-->
    
    <script src="assets/js/jquery-1.10.2.min.js"></script>
  </head>

  <body>

    <div class="container">
      <div class="header">
        <ul class="nav nav-pills pull-right">
          <!-- li class="active"><a href="#">Home</a></li-->
          <!-- li><a href="#">About</a></li-->
          
          <%@ page import="com.google.appengine.api.users.UserService" %>
		  <%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
          
          <%
			
          
          
          	UserService userService = UserServiceFactory.getUserService();
          	String thisURL = request.getRequestURI();
            
            
          
            String active = request.getParameter("active");
            String home = "";
            String settings = "";
            String manage = "";
            
            if (active != null) {
                if (active.equalsIgnoreCase("home"))
                    home = "active";
                else if (active.equalsIgnoreCase("settings"))
                    settings = "active";
                else if (active.equalsIgnoreCase("manage"))
                    manage = "active";
            }
          
          	if (request.getUserPrincipal() != null) {
          	  	out.println("<li class=\"" + home + "\"><a href=\"index.jsp\">Home</a></li>");
          		out.println("<li class=\"" + settings + "\"><a href=\"settings.jsp\">Settings</a></li>");
          	    out.println("<li><a href=\"" + userService.createLogoutURL(thisURL) + "\">Logout</a></li>");
          	}
          
          %>
          
          
        </ul>
        <h3 class="text-muted">Renew</h3>
      </div>