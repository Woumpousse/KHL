import static org.junit.Assert.*;

import java.lang.reflect.*;

public class ClassChecker
{
    private final Class<?> c;

    public ClassChecker(Class<?> c)
    {
        this.c = c;
    }

    public void assertReturnType(Method method, Class<?> returnType)
    {
        assertEquals( String.format( "Method %s should have return type %s", method.getName(), returnType.getName() ), returnType, method.getReturnType() );
    }

    private void assertPublic(Method method)
    {
        int modifier = method.getModifiers();

        assertTrue( String.format( "Getter %s must be public", method.getName() ), Modifier.isPublic( modifier ) );
    }

    private void assertPrivate(Method method)
    {
        int modifier = method.getModifiers();

        assertTrue( String.format( "Getter %s must be private", method.getName() ), Modifier.isPrivate( modifier ) );
    }

    private Method findMethod(String methodName, Class<?>... parameterTypes)
    {
        try
        {
            return c.getDeclaredMethod( methodName, parameterTypes );
        }
        catch ( NoSuchMethodException e )
        {
            fail( "Missing method " + methodName );
            return null;
        }
    }

    public void assertPublicMethod(Class<?> returnType, String name, Class<?>... parameterTypes)
    {
        Method method = findMethod( name, parameterTypes );

        assertPublic( method );
        assertReturnType( method, returnType );
    }
    
    public void assertPrivateMethod(Class<?> returnType, String name, Class<?> parameterTypes)
    {
        Method method = findMethod( name, parameterTypes );

        assertPrivate( method );
        assertReturnType( method, returnType );
    }
}
