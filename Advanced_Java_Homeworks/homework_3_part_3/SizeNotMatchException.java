public class SizeNotMatchException extends RuntimeException
{
    private static final long serialVersionUID = 234122996005267687L;
    /**
     * Constructs an {@code SizeNotMatchException} with no detail message.
     */
    public SizeNotMatchException() {
        super();
    }

    /**
     * Constructs an {@code SizeNotMatchException} with the specified detail
     * message.
     *
     * @param s the detail message
     */
    public SizeNotMatchException(String s) {
        super(s);
    }
}