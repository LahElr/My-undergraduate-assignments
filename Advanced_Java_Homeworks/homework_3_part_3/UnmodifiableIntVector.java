import java.util.Arrays;

/**
 * class UnmodifiableIntVector contains some integers
 * 
 * @author Zhen Xi
 */
public final class UnmodifiableIntVector {
    private final int[] value;

    /**
     * ctor from int[]
     * 
     * @param content : int[]
     */
    public UnmodifiableIntVector(int[] content) {
        value = Arrays.copyOf(content, content.length);
    }

    /**
     * return a vector full of 0s with specified length
     * 
     * @param zeroCount
     */
    public static UnmodifiableIntVector zeroUnmodifiableIntVector(int zeroCount) {
        UnmodifiableIntVector ret = new UnmodifiableIntVector(zeroCount);
        return ret;
    }

    /**
     * construct a all-zero vector
     * 
     * @param zero_ct
     */
    public UnmodifiableIntVector(int zeroCount) {
        value = new int[zeroCount];
    }

    /**
     * construct by copying
     * 
     * @param other
     */
    public UnmodifiableIntVector(UnmodifiableIntVector other) {
        this.value = Arrays.copyOf(other.value, other.value.length);
    }

    /**
     * construct from IntVector
     * 
     * @param other
     */
    public UnmodifiableIntVector(IntVector other) {
        this.value = new int[other.length()];
        for (int i = 0; i < other.length(); i++) {
            this.value[i] = other.valueAt(i);
        }
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
     * check if the {@code index} is out of bound
     * 
     * @param index
     * @throws IndexOutOfBoundsException
     */
    private void checkIndexOutOfBound(int index) {
        if (index >= this.value.length) {
            throw new IndexOutOfBoundsException(String.format("Index %d is out of bound %d.", index, value.length));
        }
    }

    /**
     * @return the length
     */
    public int length() {
        return value.length;
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
        UnmodifiableIntVector other = (UnmodifiableIntVector) obj;

        for (int i = 0; i < value.length; i++) {
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
        if (value.length == 0)
            return "[]";
        int iMax = value.length - 1;
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
    public static UnmodifiableIntVector add(UnmodifiableIntVector a, UnmodifiableIntVector b) {
        if (a.length() != b.length()) {
            throw new LengthNotMatchException();
        }
        int[] new_content = new int[a.length()];
        for (int i = 0; i < a.length(); i++) {
            new_content[i] = a.valueAt(i) + b.valueAt(i);
        }
        UnmodifiableIntVector res = new UnmodifiableIntVector(new_content);
        return res;
    }

    /**
     * sub two vectors
     * 
     * @param a : IntVector
     * @param b : IntVector
     * @return the subed vector
     */
    public static UnmodifiableIntVector sub(UnmodifiableIntVector a, UnmodifiableIntVector b) {
        if (a.length() != b.length()) {
            throw new LengthNotMatchException();
        }
        int[] new_content = new int[a.length()];
        for (int i = 0; i < a.length(); i++) {
            new_content[i] = a.valueAt(i) - b.valueAt(i);
        }
        UnmodifiableIntVector res = new UnmodifiableIntVector(new_content);
        return res;
    }

    /**
     * copy the vector
     * 
     * @return the copied one
     */
    public UnmodifiableIntVector copy() {
        return new UnmodifiableIntVector(value);
    }
}