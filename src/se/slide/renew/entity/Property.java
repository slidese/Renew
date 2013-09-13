package se.slide.renew.entity;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Entity
public class Property {

    @Id
    Long id;
    
    @Index
    public String userId;
    public String name;
    public String value;
}
