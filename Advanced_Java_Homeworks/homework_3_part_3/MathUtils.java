public class MathUtils {
    public static UnmodifiableIntVector getUnmodifiableIntVector(IntVector v) {
        return new UnmodifiableIntVector(v);
    }

    public static UnmodifiableIntMatrix getUnmodifiableIntMatrix(IntMatrix m) {
        return new UnmodifiableIntMatrix(m);
    }
}
