package se.slide.renew;

import com.google.gson.Gson;

import java.util.List;

public class Response {

    public enum Status {
        ERROR, OK, WARNING
    }
    
    public Status status;
    public String message;
    private List<String> parametersOk;
    private List<String> parametersWarning;
    private List<String> parametersError;
    
    public Response(Status status, String message, List<String> parametersOk, List<String> parametersWarning, List<String> parametersError) {
        this.status = status;
        this.message = message;
        this.parametersOk = parametersOk;
        this.parametersWarning = parametersWarning;
        this.parametersError = parametersError;
    }
    
    public String toJson() {
        Gson gson = new Gson();
        String json = gson.toJson(this);
        return json;
    }
    
    public static Response constructFromJson(String json) {
        Gson gson = new Gson();
        return gson.fromJson(json, Response.class);
    }
}
