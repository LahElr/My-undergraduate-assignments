import java.util.Iterator;
import java.util.Vector;

/**
 * 2-dimensional matrix of integers, with virable size.
 * <p>
 * In fact, it's a vector of vector.
 * <p>
 * Unchangable.
 * 
 * @author Zhen Xi
 */
public final class UnmodifiableIntMatrix {
    private final Vector<Vector<Integer>> value;

    /**
     * create an empty matrix, with no elements in it.
     */
    public UnmodifiableIntMatrix() {
        value = new Vector<Vector<Integer>>();
    }

    /**
     * create a matrix with specified count of column and row full of
     * {@code defaultValue}
     * 
     * @param row
     * @param col
     * @param defaultValue
     */
    public UnmodifiableIntMatrix(int row, int col, int defaultValue) {
        value = new Vector<Vector<Integer>>(row);
        for (int i = 0; i < row; i++) {
            value.add(new Vector<Integer>(col));
            for (int k = 0; k < col; k++) {
                value.get(i).add(defaultValue);
            }
        }
    }

    /**
     * create a matrix with this 2-d array
     * <p>
     * ! The count of column(s) is depended on the first line.
     * 
     * @param arr
     * @throws MatrixNotAlignedException if the array is not aligned
     */
    public UnmodifiableIntMatrix(int[][] arr) {
        if (!checkAligned(arr)) {
            throw new MatrixNotAlignedException();
        }
        int row = arr.length;
        int col = arr[0].length;
        value = new Vector<Vector<Integer>>(row);
        for (int i = 0; i < row; i++) {
            value.add(new Vector<Integer>(col));
            for (int k = 0; k < col; k++) {
                value.get(i).add(arr[i][k]);
            }
        }
    }

    /**
     * create a matrix with specified count of column and row full of 0
     * 
     * @param row
     * @param col
     */
    public UnmodifiableIntMatrix(int row, int col) {
        this(row, col, 0);
    }

    /**
     * construct from a modifiable version
     * 
     * @param in
     */
    public UnmodifiableIntMatrix(IntMatrix in) {
        this(in.getAsArray());
    }

    /**
     * A private ctor to construct with a Vector<Vector<Integer>>
     * <p>
     * ! Only used inside the class to save time copying.
     * 
     * @param in
     */
    private UnmodifiableIntMatrix(Vector<Vector<Integer>> in) {
        this.value = in;
    }

    /**
     * 
     * @param row
     * @param col
     * @return the value of the specified position
     * @throws ArrayIndexOutOfBoundsException
     */
    public int get(int row, int col) {
        return value.get(row).get(col);
    }

    public int column() {
        return value.get(0).size();
    }

    public int row() {
        return value.size();
    }

    /**
     * 
     * @return the matrix represented in 2-d array, copied
     */
    public int[][] getAsArray() {
        int col = this.column();
        int row = this.row();
        int[][] ret = new int[row][col];
        for (int i = 0; i < row; i++) {
            for (int k = 0; k < col; k++) {
                ret[i][k] = value.get(i).get(k);
            }
        }
        return ret;
    }

    /**
     * 
     * @return the shape of the matrix
     */
    public Tuple<Integer, Integer> shape() {
        return new Tuple<Integer, Integer>(value.size(), (value.isEmpty() ? 0 : value.get(0).size()));
    }

    /**
     * 
     * @return whether every row has the same length
     */
    public boolean checkAligned() {
        int col = this.column();
        int row = this.row();
        for (int i = 0; i < col; i++) {
            if (value.get(i).size() != row) {
                return false;
            }
        }
        return true;
    }

    /**
     * 
     * @param arr
     * @return whether every row has the same length
     */
    protected static boolean checkAligned(int[][] arr) {
        int row = arr.length;
        int col = arr[0].length;
        for (int i = 0; i < row; i++) {
            if (arr[i].length != col) {
                return false;
            }
        }
        return true;
    }

    /**
     * matrix addition
     * 
     * @param a
     * @param b
     * @return
     * @throws SizeNotMatchException
     */
    public static UnmodifiableIntMatrix add(UnmodifiableIntMatrix a, UnmodifiableIntMatrix b) {
        if (!a.shape().equals(b.shape())) {
            throw new SizeNotMatchException();
        }
        int[][] retarr = a.getAsArray();
        int col = a.column();
        int row = a.row();
        for (int i = 0; i < row; i++) {
            for (int k = 0; k < col; k++) {
                retarr[i][k] += b.value.get(i).get(k);
            }
        }
        return new UnmodifiableIntMatrix(retarr);
    }

    /**
     * matrix addition
     * 
     * @param other
     * @return
     * @throws SizeNotMatchException
     */
    public UnmodifiableIntMatrix add(UnmodifiableIntMatrix other) {
        return UnmodifiableIntMatrix.add(this, other);
    }

    /**
     * matrix substruction
     * 
     * @param a
     * @param b
     * @return
     * @throws SizeNotMatchException
     */
    public static UnmodifiableIntMatrix sub(UnmodifiableIntMatrix a, UnmodifiableIntMatrix b) {
        if (!a.shape().equals(b.shape())) {
            throw new SizeNotMatchException();
        }
        int[][] retarr = a.getAsArray();
        int col = a.column();
        int row = a.row();
        for (int i = 0; i < row; i++) {
            for (int k = 0; k < col; k++) {
                retarr[i][k] -= b.value.get(i).get(k);
            }
        }
        return new UnmodifiableIntMatrix(retarr);
    }

    /**
     * matrix substruction
     * 
     * @param other
     * @return
     * @throws SizeNotMatchException
     */
    public UnmodifiableIntMatrix sub(UnmodifiableIntMatrix other) {
        return UnmodifiableIntMatrix.sub(this, other);
    }

    /**
     * matrix multiple
     * 
     * @param a
     * @param b
     * @return
     * @throws SizeNotMatchException
     */
    public static UnmodifiableIntMatrix multiply(UnmodifiableIntMatrix a, UnmodifiableIntMatrix b) {
        if (a.column() != b.row()) {
            throw new SizeNotMatchException();
        }
        int mlt;
        int len = a.column();
        int row = a.row();
        int col = b.column();
        int[][] ret = new int[row][col];
        for (int i = 0; i < row; i++) {
            for (int k = 0; k < col; k++) {
                mlt = 0;
                for (int j = 0; j < len; j++) {
                    mlt += a.get(i, j) * b.get(j, k);
                }
                ret[i][k] = mlt;
            }
        }
        return new UnmodifiableIntMatrix(ret);
    }

    /**
     * matrix multiply
     * 
     * @param other
     * @return
     * @throws SizeNotMatchException
     */
    public UnmodifiableIntMatrix multiply(UnmodifiableIntMatrix other) {
        return UnmodifiableIntMatrix.multiply(this, other);
    }

    /**
     * concat
     * 
     * @param a   : the first martix
     * @param b   : the second matrix
     * @param dim : 0 : concat b below a; 1 : concat b at the right side of a
     * @return
     * @throws SizeNotMatchException
     */
    public static UnmodifiableIntMatrix concat(UnmodifiableIntMatrix a, UnmodifiableIntMatrix b, int dim) {
        Vector<Vector<Integer>> new_value = new Vector<Vector<Integer>>();
        for (var it : a.value) {
            new_value.add((Vector<Integer>) it.clone());
        }
        if (dim == 0) {
            if (a.column() != b.column()) {
                throw new SizeNotMatchException();
            }
            for (var it : b.value) {
                new_value.add((Vector<Integer>) it.clone());
            }
        } else if (dim == 1) {
            if (a.row() != b.row()) {
                throw new SizeNotMatchException();
            }
            int row = a.row();
            int n = b.column();
            for (int i = 0; i < row; i++) {
                for (int k = 0; k < n; k++) {
                    new_value.get(i).add(b.get(i, k));
                }
            }
        }
        return new UnmodifiableIntMatrix(new_value);
    }

    /**
     * concat
     * 
     * @param other
     * @param dim   : 0 : concat b below a; 1 : concat b at the right side of a
     */
    public void concat(IntMatrix other, int dim) {
        return UnmodifiableIntMatrix.concat(this, other, dim);
    }

    /*
     * (non-Javadoc)
     * 
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString() {
        Iterator<Vector<Integer>> it = value.iterator();
        if (!it.hasNext())
            return "[]";

        StringBuilder sb = new StringBuilder();
        sb.append('[');
        for (;;) {
            Vector<Integer> e = it.next();
            sb.append(' ').append(e.toString());
            if (!it.hasNext())
                return sb.append(' ').append(']').toString();
            sb.append(',').append('\n').append(' ');
        }
    }
}