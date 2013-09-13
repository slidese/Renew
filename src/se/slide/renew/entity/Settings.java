package se.slide.renew.entity;


import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Entity
public class Settings {

    @Id
    public Long id; // leaving this null will automatically assign value when created
    
    @Index
    public String userId;
    public int reminderOption = 1;
    public boolean monthlySummary = true;
}
