public class LengthNotMatchException extends RuntimeException
{
    private static final long serialVersionUID = 234122996006267687L;
    /**
     * Constructs an {@code LengthNotMatchException} with no detail message.
     */
    public LengthNotMatchException() {
        super();
    }

    /**
     * Constructs an {@code LengthNotMatchException} with the specified detail
     * message.
     *
     * @param s the detail message
     */
    public LengthNotMatchException(String s) {
        super(s);
    }
}