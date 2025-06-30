package org.example;

public class LoginService {

    private AuthAPI authAPI;

    public LoginService (AuthAPI authAPI){
        this.authAPI = authAPI;
    }

    public boolean login(String username, String password){
        return authAPI.authenticate(username,password);
    }
}
