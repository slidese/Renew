<%
    		String active = request.getParameter("active");
%>
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
    <link href="assets/css/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="assets/css/pages.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="assets/js/html5shiv.js"></script>
      <script src="assets/js/respond.min.js"></script>
    <![endif]-->
    
    <script src="assets/js/jquery-1.10.2.min.js"></script>
    
    <script>
	  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	
	  ga('create', 'UA-44061059-1', 'slide-renew.appspot.com');
	  ga('send', 'pageview');
	
	</script>
    
    <link href='http://fonts.googleapis.com/css?family=Codystar|Fredericka+the+Great|Pacifico|Open+Sans' rel='stylesheet' type='text/css'>
    
  </head>

  <body>

    <div class="container">
    	
    	<%
            if (active != null && !active.equalsIgnoreCase("index")) {
    	%>
    
    
      <div class="header">
        <ul class="nav nav-pills pull-right">
          <!-- li class="active"><a href="#">Home</a></li-->
          <!-- li><a href="#">About</a></li-->
          
          <%@ page import="com.google.appengine.api.users.UserService" %>
		  <%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
          
          <%
			
          
          
          	UserService userService = UserServiceFactory.getUserService();
          	String thisURL = request.getRequestURI();
            
            
          
            
            String home = "";
            String settings = "";
            String manage = "";
            
            if (active.equalsIgnoreCase("home"))
                home = "active";
            else if (active.equalsIgnoreCase("settings"))
                settings = "active";
            else if (active.equalsIgnoreCase("manage"))
                manage = "active";
          
          	if (request.getUserPrincipal() != null) {
          	  	out.println("<li class=\"" + home + "\"><a href=\"list.jsp\">Home</a></li>");
          		out.println("<li class=\"" + settings + "\"><a href=\"settings.jsp\">Settings</a></li>");
          	    out.println("<li><a href=\"" + userService.createLogoutURL("/index.jsp") + "\">Logout</a></li>");
          	}
          
          %>
          
          
        </ul>
        <span class="title title-text-small"><a href="/index.jsp">Renew</a></span>
      </div>
      
      <%
            }
      %>