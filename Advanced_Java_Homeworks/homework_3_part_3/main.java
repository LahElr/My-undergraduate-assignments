public class main {
    public static void main(String[] args) {
        int[] arr = { 1, 2, 3, 4, 5, 6, 7, 8 };
        IntVector vec = new IntVector(arr);
        IntVector vec2 = new IntVector(arr);
        vec.append(3);
        vec.append(4);
        vec.append(10);
        vec.append(vec2);
        System.out.println(vec);
        System.out.println(vec.capicity());
        vec.trim();
        System.out.println(vec);
        System.out.println(vec.capicity());
        System.out.println(IntVector.add(vec, vec));

        IntVector vec3 = vec2.copy();
        System.out.println(vec3.pop());
        System.out.println(vec3);
        vec3.append(8);

        System.out.printf("%d,%d,%d\n", vec.hashCode(), vec2.hashCode(), vec3.hashCode());
        System.out.println(vec2.equals(vec));

        System.out.println("---------");

        UnmodifiableIntVector uvec = new UnmodifiableIntVector(vec);
        //// var uvec = MathUtils.getUnmodifiableIntVector(vec);
        System.out.println(uvec);
        System.out.println(UnmodifiableIntVector.add(uvec, uvec));
        uvec = new UnmodifiableIntVector(arr);
        System.out.println(uvec);

        System.out.println("---------");

        IntMatrix mat = new IntMatrix(2, 3);
        System.out.println(mat.shape());
        mat.set(1, 2, 3);
        System.out.println(mat.get(1, 2));
        int[][] arr2 = { { 1, 2, 3 }, { 4, 5, 6 }, };
        var mat2 = new IntMatrix(arr2);
        System.out.printf("%d,%s\n", mat2.get(1, 1), mat2.shape());
        int[][] arr3 = mat.getAsArray();
        System.out.println(arr3[1][2]);

        System.out.println(mat.sub(mat2));

        int[][] arr4 = { { 1, 2 }, { 3, 4 }, { 5, 6 } };
        IntMatrix mat3 = new IntMatrix(arr4);
        System.out.println(mat2.multiply(mat3));

        System.out.println(IntMatrix.concat(mat, mat2, 1));
        System.out.println(mat);
        System.out.println(mat2);

        mat.concat(mat2, 0);
        System.out.println(mat);
        System.out.println(mat2);

        System.out.println("----------");
        var umat = new UnmodifiableIntMatrix(mat);
        //// var umat = MathUtils.getUnmodifiableIntMatrix(mat);
        System.out.println(umat);

    }
}