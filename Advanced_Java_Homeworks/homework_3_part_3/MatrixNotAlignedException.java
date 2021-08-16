public class MatrixNotAlignedException extends RuntimeException
{
    private static final long serialVersionUID = 234122996006267687L;
    /**
     * Constructs an {@code MatrixNotAlignedException} with no detail message.
     */
    public MatrixNotAlignedException() {
        super();
    }

    /**
     * Constructs an {@code MatrixNotAlignedException} with the specified detail
     * message.
     *
     * @param s the detail message
     */
    public MatrixNotAlignedException(String s) {
        super(s);
    }
}