<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="se.slide.renew.entity.Property"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Map.Entry"%>
<%@ page import="se.slide.renew.entity.Renew"%>
<!-- %@ page import="com.google.appengine.api.datastore.Key"%-->
<%@ page import="static com.googlecode.objectify.ObjectifyService.ofy"%>
<%@ page import="com.googlecode.objectify.Key"%>
<%@ page import="java.util.Map"%>

<jsp:include page="inc_header.jsp">
	<jsp:param name="active" value="manage" />
</jsp:include>

<!-- div class="jumbotron">
        <h1>Jumbotron heading</h1>
        <p class="lead">Cras justo odio, dapibus ac facilisis in, egestas eget quam. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
        <p><a class="btn btn-lg btn-success" href="#">Sign up today</a></p>
      </div-->

<%
		    String key = request.getParameter("key");
							boolean exists = false;

							//RenewObject renObj = null;
							
							Renew renew = null;

							if (key != null && key.trim().length() > 0) {
								//int nKey = -1;
								Long nKey = -1L;
								try {
									//nKey = Integer.parseInt(key);
									nKey = Long.valueOf(key);
									//renObj = DatastoreHelper.getInstance().getRenewObject(nKey);
									renew = ofy().load().type(Renew.class).id(nKey).now();
									
									if (renew != null)
										exists = true;
								} catch (NumberFormatException e) {

								}

							}
							 %>

<div>
	<form role="form" id="manageRenewObject">
		<input type="hidden" name="InputKey" id="InputKey"
			<% if (exists) {
					    out.print("value=" + renew.id);
					}%>>


		<div class="form-group">
			<label for="InputName">Name</label>

			<div class="input-group" id="InputName-div">
				<span class="input-group-addon"><span
					class="glyphicon glyphicon-font"></span></span> <input type="text"
					class="form-control" name="InputName" id="InputName"
					placeholder="Enter name"
					<%if (exists) {
									out.print("value=" + renew.name);
								}%>>
			</div>
		</div>
		<div class="form-group">
			<label for="InputURL">URL</label>

			<div class="input-group" id="InputURL-div">
				<span class="input-group-addon"><span
					class="glyphicon glyphicon-globe"></span></span> <input type="text"
					class="form-control" name="InputURL" id="InputURL"
					placeholder="Enter URL"
					<%if (exists) {
									out.print("value=" + renew.url);
								}%>>
			</div>
		</div>
		<div class="form-group">
			<label for="InputExpirationDate">Expires</label>

			<div class="input-group" id="InputExpirationDate-div">
				<span class="input-group-addon"><span
					class="glyphicon glyphicon-calendar"></span></span> <input type="text"
					class="form-control" name="InputExpirationDate"
					id="InputExpirationDate" placeholder="YYYY-MM-DD"
					<%if (exists) {
								    SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
									out.print("value=" + sf.format(renew.expires));
								}%>>
			</div>
		</div>

		<p>&nbsp;</p>

		<label for="InputComment">Comment</label>

		<%
					String comment = "";
				    if (exists)
				        comment = renew.comment;
				%>

		<textarea class="form-control" rows="3" name="InputComment"><%= comment %></textarea>

		<p>&nbsp;</p>

		<table class="table table-hover" id="propTable">
			<thead>
				<tr>
					<th style="width: 300px;">Property</th>
					<th>Value</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<!-- tr>
							<td><span class="triggeredit">Comment</span></td>
							<td><span class="triggeredit">Enter the comment for this object here</span></td>
							<td><a href="#" class="removeProperty"><span
									class="glyphicon glyphicon-trash pull-right"></span></a></td>
						</tr>
						<tr>
							<td><span class="triggeredit">Fee</span></td>
							<td><span class="triggeredit">0 SEK/month</span></td>
							<td><a href="#" class="removeProperty"><span
									class="glyphicon glyphicon-trash pull-right"></span></a></td>
						</tr-->
				<%
							if (exists) {
							    
							    //Iterator<Key> iteratorKey = renew.properties.iterator();
							    //ofy().load().type(Properties.class).ids(renew.properties.)
							    
								for (Key<Property> props : renew.properties) {
								    Property property = ofy().load().type(Property.class).id(props.getId()).now();
								    
								    if (property != null) {
								        out.append("<tr>");
							        	out.append("\t<td><span class=\"triggeredit\">" + property.name + "</span></td>");
							        	out.append("\t<td><span class=\"triggeredit\">" + property.value + "</span></td>");
							        	out.append("\t<td><a href=\"#\" class=\"removeProperty\"><span class=\"glyphicon glyphicon-trash pull-right\"></span></a></td>");
							        	out.append("</tr>");    
								    }
								    
								}
							    
							    /*
								HashMap<String, String> properties = renObj.properties;
								
								if (properties != null) {
								    for (Map.Entry<String, String> entry : properties.entrySet()) {
							        	out.append("<tr>");
							        	out.append("\t<td><span class=\"triggeredit\">" + entry.getKey() + "</span></td>");
							        	out.append("\t<td><span class=\"triggeredit\">" + entry.getValue() + "</span></td>");
							        	out.append("\t<td><a href=\"#\" class=\"removeProperty\"><span class=\"glyphicon glyphicon-trash pull-right\"></span></a></td>");
							        	out.append("</tr>");
							        }
								}
								*/
							}
						%>
			</tbody>

		</table>

		<div class="clearfix">
			<a class="pull-right" href="#" id="addProperty">Add property</a>
		</div>

		<p>&nbsp;</p>

		<hr />

		<button type="submit" class="btn btn-default pull-right"
			id="submitButton">Save</button>
		<a class="pull-left" href="/list.jsp">Go back</a>
	</form>

	<div id="response"></div>

</div>

</div>
<!-- /container -->


<!-- Bootstrap core JavaScript
    ================================================== -->
<!-- Placed at the end of the document so the pages load faster -->

<script type="text/javascript">
    $("a#addProperty")
            .click(function() {

                $("<tr style=\"display: none;\"><td><span class=\"triggeredit\">Name</span></td><td><span class=\"triggeredit\">Value</span></td><td><a href=\"#\" class=\"removeProperty\"><span class=\"glyphicon glyphicon-trash pull-right\"></span></a></td></tr>")
                        .appendTo('#propTable > tbody').fadeIn(200);

                /*
                $('#propTable > tbody')
                		.append(
                				"<tr style=\"display: none;\"><td><span class=\"triggeredit\">Name</span></td><td><span class=\"triggeredit\">Value</span></td><td><a href=\"#\" class=\"removeProperty\"><span class=\"glyphicon glyphicon-trash pull-right\"></span></a></td></tr>").show('slow');
                 */
                return false;
            });

    $(document).on("click", "a.removeProperty", function() {
        $(this).parent().parent().remove(); // see http://stackoverflow.com/questions/170997/what-is-the-best-way-to-remove-a-table-row-with-jquery
        return false;
    });

    $(document).on("focusout", "input.inlineEditNow", function() {
        /*
        var value = $(this).val();
        $(this).parent().html(
        		'<span class="triggeredit">' + value + '</span>');
         */
        showSpan(this);
        return false;
    });

    $(document)
            .on("click", "span.triggeredit", function() {

                var text = $(this).html();
                $(this)
                        .parent()
                        .html('<input type="text" class="inlineEditNow" name="edittext" id="edittext" value="'+ text +'" />');
                $("input.inlineEditNow").focus();
                $("input.inlineEditNow").keypress(function(event) {
                    if (event.keyCode == 13) {
                        showSpan(this);
                        event.preventDefault();
                    }
                });
            });

    function showSpan(element) {
        var value = $(element).val();

        if (!$.trim(value)) {
            value = "(empty)";
        }

        $(element).parent()
                .html('<span class="triggeredit">' + value + '</span>');
    }

    $("#submitButton")
            .click(function() {

                var url = "/renewl"; // the script where you handle the form input.
                var dataString = $("#manageRenewObject").serialize()

                console.log(dataString);

                var dataStringPropNames = [];
                var dataStringPropValues = [];
                var dataStringProps = []; // see http://stackoverflow.com/questions/2087522/does-javascript-have-a-built-in-stringbuilder-class

                // for each row in our props table, get the cells value
                $("#propTable > tbody > tr")
                        .each(function(index, value) {
                            var paramName = $(this).find("td").eq(0)
                                    .find("span").text();
                            var paramValue = $(this).find("td").eq(1)
                                    .find("span").html();

                            if (!$.trim(paramName) || !$.trim(paramValue) || paramName == "(empty)" || paramValue == "(empty)") {
                                return true; // continue with the loop but don't send these properties since either the name or value is empty/null
                            }

                            paramName = encodeURIComponent(paramName);
                            paramValue = encodeURIComponent(paramValue);

                            dataStringPropNames
                                    .push("PropNames" + "=" + paramName);
                            dataStringPropValues
                                    .push("PropValues" + "=" + paramValue);

                        });

                //dataString = dataString + "&" + dataStringProps.join("&");
                dataString = dataString + "&" + dataStringPropNames.join("&") + "&" + dataStringPropValues
                        .join("&");

                console.log(dataString);

                //console.log(dataStringProps.join("&"));
                //alert(dataString);

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
