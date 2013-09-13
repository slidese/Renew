
package se.slide.renew;

import static com.googlecode.objectify.ObjectifyService.ofy;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import se.slide.renew.entity.Settings;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class SettingsServlet extends HttpServlet {

    static long one_day = 86400;
    static long one_week = one_day * 7;
    static long one_month = one_day * 30; // 30...ish?

    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/plain");
        resp.getWriter().println("No?");

    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        
        // Handle authentication
        if (user == null || !userService.isUserLoggedIn() || user.getUserId() == null) {
            Response response = new Response(Response.Status.OK, "Error", null, null, null);
            resp.setContentType("application/json");
            resp.getWriter().print(response.toJson());
            return;
        }
        
        // Handle user object and settings for that user
        String userId = user.getUserId();
        Settings settings = ofy().load().type(Settings.class).filter("userId", userId).first().now();
        if (settings == null)
            settings = new Settings();
        
        // Start logic
        List<String> parametersOk = new ArrayList<String>(); 
        List<String> parametersWarning = new ArrayList<String>();
        List<String> parametersError = new ArrayList<String>();
        
        Response response = new Response(Response.Status.OK, "Saved settings successfully", parametersOk, parametersWarning, parametersError);
        
        String inputOptionReminder =  req.getParameter("optionsReminder");
        String inputMonthlySummary =  req.getParameter("monthlySummary");
        boolean summary = true;
        int reminder = 3; // Default is 1 month

        // Check input
        if (inputOptionReminder == null || inputOptionReminder.trim().length() < 1) {
            response.status = Response.Status.ERROR;
            parametersError.add("optionsReminder");
        }
        else {
            if (inputOptionReminder.equalsIgnoreCase("option1"))
                reminder = 1;
            else if (inputOptionReminder.equalsIgnoreCase("option2"))
                reminder = 2;
            else if (inputOptionReminder.equalsIgnoreCase("option3"))
                reminder = 3;
            else if (inputOptionReminder.equalsIgnoreCase("option4"))
                reminder = 4;
            
            parametersOk.add("optionsReminder");
        }
        
        // Determine monthly summary email
        if (inputMonthlySummary == null || inputMonthlySummary.trim().length() < 1) {
            summary = false;
        }
        else {
            summary = true;
        }
        
        if (response.status == Response.Status.OK) {
            settings.monthlySummary = summary;
            settings.reminderOption = reminder;
            if (settings.userId == null)
                settings.userId = userId;
            
            ofy().save().entity(settings).now();
        }
        
        // Send response
        resp.setContentType("application/json"); //  text/plain
        resp.getWriter().print(response.toJson());
    }

}
