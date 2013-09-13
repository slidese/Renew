<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<%@ page import="java.util.List" %>
<%@ page import="se.slide.renew.entity.Renew" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="static com.googlecode.objectify.ObjectifyService.ofy" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<jsp:include page="inc_header.jsp">
	<jsp:param name="active" value="home" />
</jsp:include>



      <!-- div class="jumbotron">
        <h1>Jumbotron heading</h1>
        <p class="lead">Cras justo odio, dapibus ac facilisis in, egestas eget quam. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
        <p><a class="btn btn-lg btn-success" href="#">Sign up today</a></p>
      </div-->

	  <div>
	  	<table class="table table-striped table-hover">
	  		<thead>
		 		<tr>
		 			<th>Object</th>
		 			<th>Status</th>
					<th>Expires</th>
		 			<th>Website</th>
		 		</tr>
	 		</thead>
	 		<tbody>
		 		<!-- tr>
		 			<td><a href="">Yesohmy</a></td>
		 			<td>2013-09-10</td>
		 			<td><a href="#"><span class="glyphicon glyphicon-globe"></span></a></td>
		 		</tr>
		 		<tr class="">
		 			<td><a href="">Crystone</a></td>
		 			<td>2014-01-10</td>
		 			<td><a href="#"><span class="glyphicon glyphicon-globe"></span></a></td>
		 		</tr>
		 		<tr>
		 			<td><a href="">intellus.se</a></td>
		 			<td>2015-09-10</td>
		 			<td><a href="#"><span class="glyphicon glyphicon-globe"></span></a></td>
		 		</tr-->
		 		<%
					//List<RenewObject> renewObjs = DatastoreHelper.getInstance().getRenewObjects();
            
            		List<Renew> listOfRenew = ofy().load().type(Renew.class).list();

            		for (Renew r : listOfRenew) {
            		    String adress = "";
            		    if (r.url != null && r.url.length() > 16)
            		        adress = r.url.substring(0, 16) + "...";
            		    else if (r.url != null)
            		        adress = r.url;
            		    
            		    String exp = "N/A";
            		    if (r.expires != null)
            		        exp = new SimpleDateFormat("yyyy-MM-dd").format(r.expires);
            		    
            		    String label = "success";
            		    String status = "OK";
            		    
            		    out.print("<tr>");
						out.print("\t<td><a href=\"manage.jsp?key=" + r.id + "\">" + r.name + "</a></td>");
						out.print("\t<td><span class=\"label label-" + label + "\">" + status + "</span></td>");
						out.print("\t<td>" + exp + "</td>");
						out.print("\t<td><a href=\"http://" + r.url + "\">" + adress + "</a></td>");
            		}
            
            		/*
					for (RenewObject obj : renewObjs) {
						out.print("<tr>");
						out.print("\t<td><a href=\"manage.jsp?key=" + obj.key.getId() + "\">" + obj.name + "</a></td>");
						out.print("\t<td>" + obj.expires + "</td>");
						out.print("\t<td><a href=\"#\"><span class=\"glyphicon glyphicon-globe\"></span></a></td>");
					}
            		*/

					
				%>
	 		</tbody>
		</table>
	  
	 	
		
		<a class="btn btn-default pull-right" href="manage.jsp">Add new</a>
		
	  </div>

      <!-- div class="row marketing">
        <div class="col-lg-6">
          <h4>Subheading</h4>
          <p>Donec id elit non mi porta gravida at eget metus. Maecenas faucibus mollis interdum.</p>

          <h4>Subheading</h4>
          <p>Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cras mattis consectetur purus sit amet fermentum.</p>

          <h4>Subheading</h4>
          <p>Maecenas sed diam eget risus varius blandit sit amet non magna.</p>
        </div>

        <div class="col-lg-6">
          <h4>Subheading</h4>
          <p>Donec id elit non mi porta gravida at eget metus. Maecenas faucibus mollis interdum.</p>

          <h4>Subheading</h4>
          <p>Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cras mattis consectetur purus sit amet fermentum.</p>

          <h4>Subheading</h4>
          <p>Maecenas sed diam eget risus varius blandit sit amet non magna.</p>
        </div>
      </div-->

      <!-- div class="footer">
        <p>&copy; slide.se 2013</p>
      </div-->

    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
  </body>
</html>