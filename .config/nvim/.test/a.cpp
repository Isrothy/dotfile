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
  private:
    double x, y;

  public:
    A(A &&) = delete;
    A(const A &) = delete;
    A &operator=(const A &) = default;
    A &operator=(A &&) = default;
    A(double x, double y) : x(x), y(y) {}
    double getX() const {
        return x;
    }
    double getY() const {
        return y;
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
