<%@ page import="java.util.List" %>
<%@ page import="se.slide.renew.Utils" %>
<%@ page import="se.slide.renew.entity.Renew" %>
<%@ page import="se.slide.renew.entity.Settings" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="static com.googlecode.objectify.ObjectifyService.ofy" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<jsp:include page="inc_header.jsp">
	<jsp:param name="active" value="home" />
</jsp:include>

	  <div class="transparent-bg">
	  	<table class="table table-striped">
	  		<thead>
		 		<tr>
		 			<th>Object</th>
		 			<th>Status</th>
					<th>Expires</th>
		 			<th>Website</th>
		 		</tr>
	 		</thead>
	 		<tbody>

		 		<%
			 		UserService userService = UserServiceFactory.getUserService();
			 	    User user = userService.getCurrentUser();
			 	    
			 	    // Handle authentication
			 	    if (user == null || !userService.isUserLoggedIn() || user.getUserId() == null) {
			 	        request.getRequestDispatcher("index.jsp").forward(request, response);
			 	    }
			 	    else {
				 	    
				 	 	// Handle user object and settings for that user
				 	    String userId = user.getUserId();
	            
				 	    Settings settings = ofy().load().type(Settings.class).filter("userId", userId).first().now();
	            		List<Renew> listOfRenew = ofy().load().type(Renew.class).filter("userId", userId).list(); //.list();
	
	            		for (Renew r : listOfRenew) {
	            		    String adress = "";
	            		    if (r.url != null && r.url.length() > 16)
	            		        adress = r.url.substring(0, 16) + "...";
	            		    else if (r.url != null)
	            		        adress = r.url;
	            		    
	            		    String exp = "N/A";
	            		    if (r.expires != null)
	            		        exp = Utils.formatDate(r.expires);
	            		    
	            		    String[] values = Utils.getLabelStatus(r.expires, settings.reminderOption);
	            		    
	            		    //String label = "success";
	            		    //String status = "OK";
	            		    
	            		    out.print("<tr>");
							out.print("\t<td><a href=\"manage.jsp?key=" + r.id + "\">" + r.name + "</a></td>");
							out.print("\t<td><span class=\"label label-" + values[0] + "\">" + values[1] + "</span></td>");
							out.print("\t<td>" + exp + "</td>");
							out.print("\t<td><a href=\"http://" + r.url + "\">" + adress + "</a></td>");
	            		}

			 	    } // else
				%>
	 		</tbody>
		</table>
	  </div>
	  
	  <div class="clearfix">
	  	<a class="btn btn-default pull-right" href="manage.jsp">Add new</a>
	  </div>

	  <%@include file="inc_footer.jsp" %>

    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
  </body>
</html>
