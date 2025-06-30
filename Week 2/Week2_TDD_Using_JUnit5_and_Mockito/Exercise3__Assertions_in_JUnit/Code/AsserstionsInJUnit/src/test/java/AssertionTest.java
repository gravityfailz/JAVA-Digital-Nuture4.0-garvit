import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class AssertionTest {

    @Test
    public void testAssertions(){

        //Assert True
        Assertions.assertTrue( 10 > 0);

        //Assert False
        Assertions.assertFalse(20%2 == 1);

        //Assert Equals
        Assertions.assertEquals(5,6-1);

        //Assert Null
        Assertions.assertNull(null);

        //Assert NotNull
        Assertions.assertNotNull(new Object());
    }
}
