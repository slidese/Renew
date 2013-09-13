
package se.slide.renew;


import static com.googlecode.objectify.ObjectifyService.ofy;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.Key;

import se.slide.renew.entity.Property;
import se.slide.renew.entity.Renew;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class RenewlServlet extends HttpServlet {
    
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/plain");
        resp.getWriter().println("Hello, world");
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
        
        List<String> parametersOk = new ArrayList<String>(); 
        List<String> parametersWarning = new ArrayList<String>();
        List<String> parametersError = new ArrayList<String>();
        
        Response response = new Response(Response.Status.OK, "Put object successfully", parametersOk, parametersWarning, parametersError);
        
        String inputKey =  req.getParameter("InputKey");
        String inputName = checkParam(req, "InputName", response, parametersOk, parametersWarning, parametersError); //(String) req.getParameter("InputName");
        String inputUrl = checkParam(req, "InputURL", response, parametersOk, parametersWarning, parametersError); //(String) req.getParameter("InputURL");
        String inputexpirationDate = checkParam(req, "InputExpirationDate", response, parametersOk, parametersWarning, parametersError); //(String) req.getParameter("InputExpirationDate");
        String inputComment =  req.getParameter("InputComment");
        String[] propNames = req.getParameterValues("PropNames");
        String[] propValues = req.getParameterValues("PropValues");

        // our Renew object
        Renew entity = null;
        
        // is this an update, load object
        if (inputKey != null && inputKey.trim().length() > 0) {
            long existingKey = -1;
            try {
                existingKey = Long.parseLong(inputKey);
                entity = ofy().load().type(Renew.class).id(existingKey).now();
                //entity = ofy().load().type(Renew.class).filter("userId", userId).
            }
            catch (NumberFormatException e) {
                //
            }
        }
        
        List<Property> listOfProperties = new ArrayList<Property>();
        if (propNames == null || propValues == null) {
            // no values
        }
        else if (propNames.length != propValues.length) {
            response.status = Response.Status.ERROR;
            response.message = response.message + " Property are invalid."; 
        }
        else {
            
            for (int i = 0; i < propNames.length; i++) {
                // we should never get blank properties but if we do...
                if (propNames[i] == null || propNames[i].trim().length() < 1 || propValues[i] == null || propValues[i].trim().length() < 1)
                    continue;
                
                //map.put(propNames[i], propValues[i]);
                
                Property prop = new Property();
                prop.name = propNames[i];
                prop.value = propValues[i];
                listOfProperties.add(prop);
            }
            
        }
        
        Date expirationDate = null;
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        try {
            expirationDate = format.parse(inputexpirationDate);
            parametersOk.add("InputExpirationDate");
        } catch (ParseException e) {
            response.status = Response.Status.ERROR;
            parametersOk.remove("InputExpirationDate");
            parametersError.add("InputExpirationDate");
        }
        
        // if everything is ok, put object in datastore
        if (response.status == Response.Status.OK) {
            
            if (entity == null)
                entity = new Renew();
            
            entity.name = inputName;
            entity.url = inputUrl;
            entity.expires = expirationDate;
            entity.comment = inputComment;
            
            // delete old props, this is pretty bad
            if (entity != null) {
                for (Key<Property> k : entity.properties) {
                    ofy().delete().key(k).now();
                }
                entity.properties.clear();
            }
            
            Map<Key<Property>, Property> pmap = ofy().save().entities(listOfProperties).now();
            
            for (Map.Entry<Key<Property>, Property> p : pmap.entrySet()) {
                entity.properties.add(p.getKey());
            }
            
            ofy().save().entity(entity).now();
            
        }
        
        // Send response
        resp.setContentType("application/json"); //  text/plain
        resp.getWriter().print(response.toJson());
        
    }
    
    protected String checkParam(HttpServletRequest req, String id, Response response, List<String> parametersOk, List<String> parametersWarning, List<String> parametersError) {
        String param = null;
        
        try {
            param = req.getParameter(id);
            
            if (param == null || param.trim().length() < 1) {
                parametersError.add(id);
                response.status = Response.Status.ERROR;
            }
            else {
                parametersOk.add(id);
            }
        }
        catch (Exception e) {
            parametersError.add(id);
            response.status = Response.Status.ERROR;
        }
        
        return param;
    }
}
