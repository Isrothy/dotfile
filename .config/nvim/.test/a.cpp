#include <algorithm>
#include <string>
#include <vector>

int add(int x, int y) {
    printf("%d\n", x + y);
    return x + y;
}

double add(double x, double y) {
    printf("%lf\n", x + y);
    return x + y;
}

struct A {
    A(const A &) = delete;
    A(A &&) = default;
    A &operator=(const A &) = default;
    A &operator=(A &&) = default;
    explicit A(double x) : x(x) {}

    static const int y;

private:
    double x;

public:
    [[nodiscard]] double add(int z) const {
        return x + y + z;
    }
};

enum class B {
    A,
    B,
    C,
};

int64_t ex_gcd(int64_t a, int64_t b, int64_t &x, int64_t &y) {
    if (b == 0) {
        x = 1;
        y = 0;
        return a;
    }
    auto d = ex_gcd(b, a % b, y, x);
    y -= a / b * x;
    return d;
}

/**
 *
 * @param a aa
 * @param p pp
 * @return inverse
 * @author Firstname Lastname
 * @date 2020/12/14
 * @description
 * @version 1.0
 */
int64_t inv(int64_t a, int64_t p) {
    int64_t x, y;
    ex_gcd(a, p, x, y);
    x %= p;
    if (x < 0) {
        x += p;
    }
    return x;
}


int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    printf("%d\n", a + b);
    int n = 10;
    auto D = static_cast<int>(add(double(a), double(b)));
    switch (D) {
        case 0:
        case 1: {
            printf("%d\n", a + b);
            break;
        }
        default: {
            printf("%d\n", a + b);
            break;
        }
    }
    for (int i = 0; i <= n; ++i) {
        if (i % 2 == 0) {
            printf("%d\n", i);
        }
    }
    do {


    } while (true);

    return 0;
}
