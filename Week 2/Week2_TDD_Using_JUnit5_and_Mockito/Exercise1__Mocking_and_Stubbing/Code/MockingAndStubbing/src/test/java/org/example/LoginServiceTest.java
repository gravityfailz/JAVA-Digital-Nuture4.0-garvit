package org.example;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.*;

public class LoginServiceTest {

    @Test
    void testLoginWithStub(){

        AuthAPI authStub = mock(AuthAPI.class);

        when(authStub.authenticate("john","1234")).thenReturn(true);

        LoginService loginService = new LoginService(authStub);
        boolean result = loginService.login("john","1234");
        assertTrue(result);
    }

}
