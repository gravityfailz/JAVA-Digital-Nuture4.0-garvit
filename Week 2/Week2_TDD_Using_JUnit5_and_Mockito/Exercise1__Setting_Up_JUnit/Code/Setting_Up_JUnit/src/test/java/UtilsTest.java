import org.example.Utils;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class UtilsTest {
    Utils utils = new Utils();

    @Test
    void testEvenNumber(){
        Assertions.assertTrue(utils.isEven(15));
    }

    @Test
    void testOddNumber(){
        Assertions.assertFalse(utils.isEven(45));
    }
}
