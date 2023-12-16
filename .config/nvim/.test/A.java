
public class A implements Inter {
    private static final String FOO = "foo";

    private static final String BAR = "bar";

    /**
     * @param args
     */
    public static void main(final String[] args) {
        int n = 10;
        System.out.println(n);
        for (int i = 0; i < n; i++) {
            System.out.println(i);
        }
        System.out.println(FOO);
        System.out.println(BAR);
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
