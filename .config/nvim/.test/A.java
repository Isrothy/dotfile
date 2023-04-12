public class A implements Inter
{
    private static final String FOO = "foo";

    private static final String BAR = "bar";

    public static void main(final String[] args) {
        final int n = 10;
        System.out.println(n);
        for (int i = 0; i < n; i++) {
            System.out.println(i);
        }
    }

    public String getFoo() {
        return FOO;
    }

    public String getBar() {
        return BAR;
    }
}

interface Inter {
    String getFoo();

    String getBar();
}
