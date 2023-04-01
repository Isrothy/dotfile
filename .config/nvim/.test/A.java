interface Inter {
    String getFoo();

    String getBar();
}

public class A implements Inter
{
    private static final String FOO = "foo";

    private static final String BAR = "bar";

    public static String getFoo() {
        return FOO;
    }

    public static String getBar() {
        return BAR;
    }

    public static void main(String[] args) {
        int n = 10;
        System.out.println(n);
        for (int i = 0; i < n; i++) {
            System.out.println(i);
        }
    }
}
