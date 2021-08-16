import java.util.Arrays;

/**
 * class IntVector contains integers with variable length.
 * 
 * @author Zhen Xi
 */
public class IntVector {
    private int[] value;
    private int length;
    private int capicity;

    private final int INFLATE_METHOD_LIMIT = 120;
    private final int INFLATE_STEP = 15;

    /**
     * default ctor
     */
    public IntVector() {
        value = new int[16];
        capicity = 16;
        length = 0;
    }

    /**
     * ctor from capicity
     * 
     * @param capicity : int
     */
    public IntVector(int capicity) {
        value = new int[capicity];
        this.capicity = capicity;
        length = 0;
    }

    /**
     * ctor from int[]
     * 
     * @param content : int[]
     */
    public IntVector(int[] content) {
        value = Arrays.copyOf(content, content.length);
        capicity = content.length;
        length = content.length;
    }

    /**
     * get the value at the specified index
     * 
     * @param index
     * @return value[index]
     * @throws IndexOutOfBoundsException
     */
    public int valueAt(int index) {
        checkIndexOutOfBound(index);
        return value[index];
    }

    /**
     * set the value of the specified position
     * 
     * @param index
     * @param newValue
     * @throws IndexOutOfBoundsException
     */
    public void setValueAt(int index, int newValue) {
        checkIndexOutOfBound(index);
        value[index] = newValue;
    }

    /**
     * check if the {@code index} is out of bound
     * 
     * @param index
     * @throws IndexOutOfBoundsException
     */
    private void checkIndexOutOfBound(int index) {
        if (index >= this.length) {
            throw new IndexOutOfBoundsException(String.format("Index %d is out of bound %d.", index, length));
        }
    }

    /**
     * @return the length
     */
    public int length() {
        return length;
    }

    /**
     * @return the capicity
     */
    public int capicity() {
        return capicity;
    }

    /*
     * (non-Javadoc)
     * 
     * @see java.lang.Object#hashCode()
     */
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + capicity;
        result = prime * result + length;
        result = prime * result + Arrays.hashCode(value);
        return result;
    }

    /*
     * (non-Javadoc)
     * 
     * @see java.lang.Object#equals(java.lang.Object)
     */
    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        IntVector other = (IntVector) obj;
        if (capicity != other.capicity)
            return false;
        if (length != other.length)
            return false;
        for (int i = 0; i < length; i++) {
            if (value[i] != other.value[i]) {
                return false;
            }
        }

        return true;
    }

    /*
     * (non-Javadoc)
     * 
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString() {
        if (length == 0)
            return "[]";
        int iMax = length - 1;
        StringBuilder b = new StringBuilder();
        b.append('[');
        for (int i = 0;; i++) {
            b.append(value[i]);
            if (i == iMax)
                return b.append(']').toString();
            b.append(", ");
        }
    }

    /**
     * add two vectors
     * 
     * @param a : IntVector
     * @param b : IntVector
     * @return the added vector
     */
    public static IntVector add(IntVector a, IntVector b) {
        if (a.length() != b.length()) {
            throw new LengthNotMatchException();
        }
        int[] new_content = new int[a.length()];
        for (int i = 0; i < a.length(); i++) {
            new_content[i] = a.valueAt(i) + b.valueAt(i);
        }
        IntVector res = new IntVector(new_content);
        return res;
    }

    /**
     * sub two vectors
     * 
     * @param a : IntVector
     * @param b : IntVector
     * @return the subed vector
     */
    public static IntVector sub(IntVector a, IntVector b) {
        if (a.length() != b.length()) {
            throw new LengthNotMatchException();
        }
        int[] new_content = new int[a.length()];
        for (int i = 0; i < a.length(); i++) {
            new_content[i] = a.valueAt(i) - b.valueAt(i);
        }
        IntVector res = new IntVector(new_content);
        return res;
    }

    /**
     * inflate the vector
     */
    private void inflate() {
        if (capicity <= INFLATE_METHOD_LIMIT) {
            int[] new_value = new int[capicity + INFLATE_STEP];
            System.arraycopy(value, 0, new_value, 0, length);
            capicity = capicity + INFLATE_STEP;
            value = new_value;
        } else {
            int[] new_value = new int[capicity * 2];
            System.arraycopy(value, 0, new_value, 0, length);
            capicity = capicity * 2;
            value = new_value;
        }
    }

    /**
     * inflate the vector to certain capicity
     * 
     * @param new_capicity
     */
    private void inflateTo(int new_capicity) {
        if (new_capicity <= capicity) {
            return;
        }
        int[] new_value = new int[new_capicity];
        System.arraycopy(value, 0, new_value, 0, length);
        capicity = new_capicity;
        value = new_value;
    }

    /**
     * append one integer to the tail of the vector
     * 
     * @param newInt
     */
    public void append(int newInt) {
        if (capicity >= length + 1) {
            value[length++] = newInt;
        } else {
            inflate();
            value[length++] = newInt;
        }
    }

    /**
     * append an int[] to the tail of the vector
     * 
     * @param arr
     */
    public void append(int[] arr) {
        int iMax = length + arr.length;
        if (capicity >= iMax) {
            for (int i = length; i < iMax; i++) {
                value[i] = arr[i - length];
            }
        } else {
            inflateTo(iMax + 5);
            for (int i = length; i < iMax; i++) {
                value[i] = arr[i - length];
            }
        }
        length = iMax;
    }

    /**
     * append another IntVector to the tail of this one
     * 
     * @param other
     */
    public void append(IntVector other) {
        append(other.value);
    }

    /**
     * copy the vector
     * 
     * @return the copied one
     */
    public IntVector copy() {
        return new IntVector(value);
    }

    /**
     * pop the last integer
     * 
     * @return the poped one
     */
    public int pop() {
        return value[--length];
    }

    /**
     * trim the vector to a fit size
     */
    public void trim() {
        if (capicity == length) {
            return;
        }
        int[] new_value = new int[length];
        System.arraycopy(value, 0, new_value, 0, length);
        capicity = length;
        value = new_value;
    }
}