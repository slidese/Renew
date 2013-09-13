package se.slide.renew;

import com.googlecode.objectify.ObjectifyService;

import se.slide.renew.entity.Property;
import se.slide.renew.entity.Renew;
import se.slide.renew.entity.Settings;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class StartupListener implements ServletContextListener {

    @Override
    public void contextDestroyed(ServletContextEvent arg0) {

    }

    @Override
    public void contextInitialized(ServletContextEvent arg0) {

        ObjectifyService.register(Renew.class);
        ObjectifyService.register(Property.class);
        ObjectifyService.register(Settings.class);
    }

}
