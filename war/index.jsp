<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<%@ page import="java.util.List" %>
<%@ page import="se.slide.renew.entity.Renew" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="static com.googlecode.objectify.ObjectifyService.ofy" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<jsp:include page="inc_header.jsp">
	<jsp:param name="active" value="index" />
</jsp:include>



      <!-- div class="jumbotron">
        <h1>Jumbotron heading</h1>
        <p class="lead">Cras justo odio, dapibus ac facilisis in, egestas eget quam. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
        <p><a class="btn btn-lg btn-success" href="#">Sign up today</a></p>
      </div-->

	  <div style="margin-top: 160px;"></div>

	  <div class="transparent-bg">
		
		
		
		<div class="title title-text">Renew</div>
		
		<hr class="title-hr" />
		
		<div class="title-content" >
			<p>
				Welcome to the simple web app that will help you to renew your stuff. What stuff? Any stuff you want.
			</p>
			<p>
				It's simple, follow these steps:
			</p>
			<ol>
				<li>Create your stuff</li>
				<li>Chose when to be reminded</li>
				<li>Done!</li>
			</ol>
			<p>
				Renew will now send you and email when the expiration date is coming up. Please use your Google account to login and you're on your way!
			</p>
			<p>
				
			</p>
		</div>
		
		<div style="text-align: center; padding-bottom: 20px;">
			<a href="/list.jsp">
				<img src="assets/img/Red-signin-Long-base-20dp.png" />
			</a>
		</div>
		
		
		
		
		
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
