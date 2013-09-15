package se.slide.renew;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Utils {
    
    // http://www.epochconverter.com/
    static long one_day = 86400000L;
    static long one_week = 604800000L;

    public static String formatDate(Date d) {
        return new SimpleDateFormat("yyyy-MM-dd").format(d);
    }
    
    public static String[] getLabelStatus(Date expires, int optionReminder) {
        long subtractExpiration = getSubtractedExpiration(expires, optionReminder);
        return getLabelStatus(expires, subtractExpiration);
    }
    
    public static String[] getLabelStatus(Date expires, long subtractedExpiration) {
        String[] values = new String[2];
        
        long exp = expires.getTime();
        long now = new Date().getTime();
        
        if (now > exp) {
            values[0] = "danger";
            values[1] = "Check me!";
        }
        else {
            if (now > subtractedExpiration) {
                values[0] = "warning";
                values[1] = "Warning";
            }
            else {
                values[0] = "success";
                values[1] = "OK";
            }
            
        }
        
        return values;
    }
    
    public static long getSubtractedExpiration(Date expires, int optionReminder) {
        long res = expires.getTime();
        long result = expires.getTime();
        
        if (optionReminder == 1)
            result = res - one_week;
        else if (optionReminder == 2)
            result = res - (one_week * 2);
        else if (optionReminder == 3)
            result = res - (one_week * 4);
        else if (optionReminder == 4)
            result = res - (one_week * 8);
        
        return result;
    }
}
