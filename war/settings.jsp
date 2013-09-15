<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<%@ page import="java.util.List" %>
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
	<jsp:param name="active" value="settings" />
</jsp:include>

<%
	
	UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    
    // Handle authentication
    if (user == null || !userService.isUserLoggedIn() || user.getUserId() == null) {
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
    
 	// Handle user object and settings for that user
    String userId = user.getUserId();
    Settings settings = ofy().load().type(Settings.class).filter("userId", userId).first().now();
    
%>

      <!-- div class="jumbotron">
        <h1>Jumbotron heading</h1>
        <p class="lead">Cras justo odio, dapibus ac facilisis in, egestas eget quam. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
        <p><a class="btn btn-lg btn-success" href="#">Sign up today</a></p>
      </div-->

	  <form class="form-horizontal" role="form" id="settingsForm">

	  <div class="transparent-bg form-padding">
	  	
		
		
			<div class="form-group">
				<div class="col-lg-10">
					<label for="optionsReminder" class="control-label">Before expiration remind me in</label>
				  
					<div class="radio">
					  <label>
					    <input type="radio" name="optionsReminder" id="optionsReminder1" value="option1" <% if (settings == null || settings.reminderOption == 1) { out.print("checked"); } %>>
					    1 week
					  </label>
					</div>
					<div class="radio">
					  <label>
					    <input type="radio" name="optionsReminder" id="optionsReminder2" value="option2" <% if (settings != null && settings.reminderOption == 2) { out.print("checked"); } %>>
					    2 weeks
					  </label>
					</div>
					<div class="radio">
					  <label>
					    <input type="radio" name="optionsReminder" id="optionsReminder3" value="option3" <% if (settings != null && settings.reminderOption == 3) { out.print("checked"); } %>>
					    4 weeks
					  </label>
					</div>
					<div class="radio">
					  <label>
					    <input type="radio" name="optionsReminder" id="optionsReminder4" value="option4" <% if (settings != null && settings.reminderOption == 4) { out.print("checked"); } %>>
					    8 weeks
					  </label>
					</div>
				</div>
			</div>
			  
			  <div class="form-group">
			    <div class="col-lg-10">
			    	<label for="monthlySummary" class="control-label">One more thing...</label>
			    	
			      <div class="checkbox">
			        <label>
			          <input type="checkbox" name="monthlySummary" id="monthlySummary" <% if (settings != null && settings.monthlySummary) { out.print("checked"); } %>> Send monthly summary
			        </label>
			      </div>
			    </div>
			  </div>
			  
			  
		
	  </div>
	  
	  <div>
	  	<div style="margin-top: 20px;"></div>
	  	
	  	</div>
	  
			  <div class="form-group">
			    <div style="width: 100%; padding-right: 15px;">
			      <button type="submit" id="submitButton" class="btn btn-default pull-right">Save</button>
			    </div>
			  </div>
	  </div>
	  
	  </form>	 

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
    
    <script type="text/javascript">
        $("#submitButton")
            .click(function() {

                var url = "/settings"; // the script where you handle the form input.
                var dataString = $("#settingsForm").serialize()

                $.ajax({
                type : "POST",
                url : url,
                data : dataString, // serializes the form's elements.
                dataType : "json", // set this to json to automatically parse it in the success/error functions
                success : function(data) {
                    if (data.status == "OK") {
                        window.location = "/list.jsp";

                    } else {
                        $.each(data.parametersOk, function(index, value) {
                            $("#" + value + "-div").removeClass("has-error");
                            $("#" + value + "-div").removeClass("has-warning");
                            $("#" + value + "-div").addClass("has-success");
                        });
                        $.each(data.parametersWarning, function(index, value) {
                            $("#" + value + "-div").removeClass("has-success");
                            $("#" + value + "-div").removeClass("has-error");
                            $("#" + value + "-div").addClass("has-warning");
                        });
                        $.each(data.parametersError, function(index, value) {
                            $("#" + value + "-div").removeClass("has-success");
                            $("#" + value + "-div").removeClass("has-warning");
                            $("#" + value + "-div").addClass("has-error");
                        });
                    }

                },
                error : function(data) {
                    console.log("error in reply");
                },
                complete : function(data) {
                    console.log("Put object completed.")
                }

                });

                return false; // avoid to execute the actual submit of the form.
            });
	</script>    
  </body>
</html>
