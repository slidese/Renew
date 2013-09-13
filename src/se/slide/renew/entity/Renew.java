package se.slide.renew.entity;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Entity
public class Renew {

    @Id
    public Long id; // leaving this null will automatically assign value when created
    
    @Index
    public String userId;
    public String name;
    public String url;
    public String comment;
    public Date expires;
    public Date checked;
    
    public List<Key<Property>> properties = new ArrayList<Key<Property>>();
}
