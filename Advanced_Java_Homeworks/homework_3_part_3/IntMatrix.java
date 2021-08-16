import java.util.Iterator;
import java.util.Vector;

/**
 * 2-dimensional matrix of integers, with virable size.
 * <p>
 * In fact, it's a vector of vector
 * 
 * @author Zhen Xi
 */
public class IntMatrix {
    private Vector<Vector<Integer>> value; // what is stored.

    /**
     * create an empty matrix, with no elements in it.
     */
    public IntMatrix() {
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
    public IntMatrix(int row, int col, int defaultValue) {
        value = new Vector<Vector<Integer>>(row);
        for (int i = 0; i < row; i++) {
            value.add(new Vector<Integer>(col)); // construct the line
            for (int k = 0; k < col; k++) {
                value.get(i).add(defaultValue); // construct every element
            }
        }
    }

    /**
     * create a matrix with this 2-d array
     * 
     * @param arr
     * @throws MatrixNotAlignedException if the array is not aligned
     */
    public IntMatrix(int[][] arr) {
        if (!checkAligned(arr)) {
            throw new MatrixNotAlignedException(); // the length of every line of this array isnot the same
        }
        int row = arr.length;
        int col = arr[0].length;
        value = new Vector<Vector<Integer>>(row);
        for (int i = 0; i < row; i++) {
            value.add(new Vector<Integer>(col)); // construct the line
            for (int k = 0; k < col; k++) {
                value.get(i).add(arr[i][k]); // construct the elements
            }
        }
    }

    /**
     * create a matrix with specified count of column and row full of 0
     * 
     * @param row
     * @param col
     */
    public IntMatrix(int row, int col) {
        this(row, col, 0);
    }

    /**
     * A private ctor to construct with a Vector<Vector<Integer>>
     * 
     * @param in
     */
    private IntMatrix(Vector<Vector<Integer>> in) {
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

    /**
     * 
     * @param row
     * @param col
     * @param value
     * @throws ArrayIndexOutOfBoundsException
     */
    public void set(int row, int col, int value) {
        Vector<Integer> thy = this.value.get(row);
        thy.set(col, value);
        return;
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
    public static IntMatrix add(IntMatrix a, IntMatrix b) {
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
        return new IntMatrix(retarr);
    }

    /**
     * matrix addition
     * 
     * @param other
     * @return
     * @throws SizeNotMatchException
     */
    public IntMatrix add(IntMatrix other) {
        return IntMatrix.add(this, other);
    }

    /**
     * matrix substruction
     * 
     * @param a
     * @param b
     * @return
     * @throws SizeNotMatchException
     */
    public static IntMatrix sub(IntMatrix a, IntMatrix b) {
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
        return new IntMatrix(retarr);
    }

    /**
     * matrix substruction
     * 
     * @param other
     * @return
     * @throws SizeNotMatchException
     */
    public IntMatrix sub(IntMatrix other) {
        return IntMatrix.sub(this, other);
    }

    /**
     * matrix multiple
     * 
     * @param a
     * @param b
     * @return
     * @throws SizeNotMatchException
     */
    public static IntMatrix multiply(IntMatrix a, IntMatrix b) {
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
        return new IntMatrix(ret);
    }

    /**
     * matrix multiply
     * 
     * @param other
     * @return
     * @throws SizeNotMatchException
     */
    public IntMatrix multiply(IntMatrix other) {
        return IntMatrix.multiply(this, other);
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
    public static IntMatrix concat(IntMatrix a, IntMatrix b, int dim) {
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
        return new IntMatrix(new_value);
    }

    /**
     * concat
     * 
     * @param other
     * @param dim   : 0 : concat b below a; 1 : concat b at the right side of a
     */
    public void concat(IntMatrix other, int dim) {
        if (dim == 0) {
            if (this.column() != other.column()) {
                throw new SizeNotMatchException();
            }
            for (var it : other.value) {
                this.value.add((Vector<Integer>) it.clone());
            }
        } else if (dim == 1) {
            if (this.row() != other.row()) {
                throw new SizeNotMatchException();
            }
            int row = this.row();
            int n = other.column();
            for (int i = 0; i < row; i++) {
                for (int k = 0; k < n; k++) {
                    this.value.get(i).add(other.get(i, k));
                }
            }
        }
    }

    /*
     * (non-Javadoc)
     * 
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString() {
        //// return value.toString();
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