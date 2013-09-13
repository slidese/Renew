
package se.slide.renew;

import se.slide.renew.entity.Renew;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import static com.googlecode.objectify.ObjectifyService.ofy;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class CheckServlet extends HttpServlet {

    static long one_day = 86400;
    static long one_week = one_day * 7;
    static long one_month = one_day * 30; // 30...ish?

    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        List<Renew> listOfRenew = ofy().load().type(Renew.class).list();

        StringBuilder builder = new StringBuilder();

        for (Renew r : listOfRenew) {

            if (r.expires != null && r.checked == null) {
                Date today = new Date();
                long now = today.getTime();
                long expires = r.expires.getTime();
                long subtracted_expires = expires - (one_month * 2);

                if (now > subtracted_expires) {
                    Properties props = new Properties();
                    Session session = Session.getDefaultInstance(props, null);

                    String msgBody = "A new Renew was created.";

                    try {
                        Message msg = new MimeMessage(session);
                        msg.setFrom(new InternetAddress("www.slide.se@gmail.com", "Renew Admin"));
                        msg.addRecipient(Message.RecipientType.TO, new InternetAddress(
                                "mike@slide.se", "Mr Mike"));
                        msg.setSubject("Your Renew object has been created.");
                        msg.setText(msgBody);
                        Transport.send(msg);
                        
                        // set the date when we sent the email
                        r.checked = today;
                        ofy().save().entities(r).now();

                    } catch (AddressException e) {
                        mailAdmin(e);
                    } catch (MessagingException e) {
                        mailAdmin(e);
                    }
                }
            }

            // builder.append(r.name);
            // builder.append("\r\n");
        }

        resp.setContentType("text/plain");
        resp.getWriter().println("Check completed: " + builder.toString());

    }

    private void mailAdmin(Exception ex) {
        try {
            Properties props = new Properties();
            Session session = Session.getDefaultInstance(props, null);

            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress("www.slide.se@gmail.com", "Renew Admin"));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress("admins"));
            msg.setSubject("Problem sending email");
            msg.setText(ex.getMessage());
            Transport.send(msg);

        } catch (AddressException e) {
            //
        } catch (MessagingException e) {
            //
        } catch (UnsupportedEncodingException e) {
            //
        }
    }
}
