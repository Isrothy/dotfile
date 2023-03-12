#include <algorithm>
#include <cstdio>
#include <cstdlib>
#include <cwchar>
#include <string>
#include <vector>

int add(int x, int y) {
    printf("%d\n", x + y);
    return x + y;
}

double add(double x, double y) {
    printf("%f\n", x + y);
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
    double add(int z) const {
        return x + y + z;
    }
};


int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    printf("%d\n", a + b);
    int n = 10;
    int D = add(double(a), double(b));
    switch (D) {
        case 0: {
        }
    }
    for (int i = 0; i <= n; ++i) {
        if (i % 2 == 0) {
            printf("%d\n", i);
        }
    }
    return 0;
}
