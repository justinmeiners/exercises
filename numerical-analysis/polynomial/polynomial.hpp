/*  Created By: Justin Meiners (2017)

Made for my numerical analysis class
*/
#include <ostream>
#include <assert.h>

template <int N, typename T=double>
class polynomial
{
private:
    static_assert(N > 0, "polynomial must have positive degree");
    // coeffecients of the polynomial with the following ordering
    // p(x) = c[0] + c[1]x^1 + c[2]x^2 + ... c[n]x^n
    T coeff[N];

    static constexpr int factorial(int n)
    {
        int product = 1;
        for (int i = 2; i <= n; ++i)
            product *= i;
        return product;
    }
public:
    using value_type = T;
    static constexpr int size = N;
    int degree() const { return size - 1; }

    // default constructor defaults to 0
    polynomial()
    {
        for (int i = 0; i < N; ++i)
            coeff[i] = T(0);
    }
    // construct with value for coeffecient
    polynomial(T x, int degree)
    {
        assert(degree >= 0 && degree < N);
        for (int i = 0; i < N; ++i)
            coeff[i] = T(0);
        coeff[degree] = x;
    }
    // initialzer list (can be smaller than N)
    polynomial(std::initializer_list<T> l)
    {
        int i = 0;
        for (auto x : l)
        {
            assert(i < N);
            coeff[i] = x;
            ++i;
        }

        while (i < N)
        {
            coeff[i] = T(0);
            ++i;
        }
    }
    // create from alternate dimension
    template <int M>
    polynomial(const polynomial<M, T>& p)
    {
        int min = (N > M) ? M : N;
        for (int i = 0; i < min; ++i)
           coeff[i] = p[i];
        for (int i = min; i < N; ++i)
            coeff[i] = T(0);
    }
    // copy constructor
    polynomial(const polynomial<N, T>& p)
    {
        memcpy(coeff, p.coeff, sizeof(T) * N);
    }
    // assignment operator
    polynomial<N, T>& operator=(const polynomial<N, T>& p)
    {
        memcpy(coeff, p.coeff, sizeof(T) * N);
        return *this;
    } 
    // coeffecient accessor
    T& operator[](int i) 
    {
        assert(i >= 0 && i < N);
        return coeff[i];
    }
    // constant coeffecient accesor
    const T& operator[](int i) const
    {
        assert(i >= 0 && i < N);
        return coeff[i];
    }
    // equality
    friend bool operator==(const polynomial<N, T>& a, const polynomial<N, T>& b)
    {
        for (int i = 0; i < N; ++i)
            if (a[i] != b[i]) return false;
        return true;
    }
    // adding polynomials
    friend polynomial<N, T> operator+(polynomial<N, T> a, const polynomial<N, T>&b)
    {
        for (int i = 0; i < N; ++i)
            a[i] = a[i] + b[i];
        return a;
    }
    // subtracting polynomials
    friend polynomial<N, T> operator-(polynomial<N, T> a, const polynomial<N, T>&b)
    {
        for (int i = 0; i < N; ++i)
            a[i] = a[i] - b[i];
        return a;
    }
    // multiplying polynomials (throws away overflow)
    friend polynomial<N, T> operator*(const polynomial<N, T>& a, const polynomial<N, T>&b)
    {
        polynomial<N, T> c;
        for (int i = 0; i < N; ++i)
        {
            for (int j = 0; j < N; ++j)
            {
                if (i + j < N) // truncates the result
                    c[i + j] += a[i] * b[j];
            }
        }
        return c;
    }
    // evalution at a particular value (very effecient)
    T operator()(T x) const
    {
        // result c_(n-1) * x^(n-1)
        // start with c[N-1];
        T sum = coeff[N - 1];
        // multiply x, (n-1) times
        for (int i = N - 2; i >= 0; --i)
            // add the new coeffecient each iteration
            sum = x * sum + coeff[i];
        // last coeffecient x^0 will not be multipied by x
        return sum;
    }

    std::pair<T, T> evaluate(T x) const 
    {
        T sum = coeff[N - 1];
        // multiply x, (n-1) times
        for (int i = 2; i <= N; ++i)
            // add the new coeffecient each iteration
            sum = x * sum + coeff[N - i]; 

        return std::make_pair(sum, sum);
    }

    // generate a new polynomial representing the derivative
    polynomial<N, T> derivative(int n) const
    {
        assert(n > 0);
        polynomial<N, T> p;
        for (int i = n; i < N; ++i)
            p[i - n] = coeff[i] * T(i) * T(factorial(n));
        return p;
    }
    polynomial<N, T> derivative() const { return derivative(1); }
    polynomial<N, T> integral(T constant) const
    {
        polynomial<N, T> p;
        p[0] = constant;
        for (int i = 1; i < N; ++i)
            p[i] = coeff[i - 1] / T(i);
        return p;
    }
    polynomial<N, T> integral() const { return integral(T(0)); }

    template <typename I, typename Size>
    static polynomial<N, T> interpolate_n(I x, I y, Size count)
    {
        assert(count <= N);
        
        T v[N];
        std::copy_n(x, count, v);
        T c[N];
        std::copy_n(y, count, c);

        int n = count - 1;
        // http://stetekluh.com/NewtonPoly.html
        for (int j = 1; j <= n; ++j)
        {
            for (int i = 0; i <= n - j; ++i)
                c[i] = (c[i + 1] - c[i]) / (v[i + j] - x[i]);
        }

        for (int j = 0; j < n; ++j)
        {
            for (int i = 1; i <= n - j; ++i)
                c[i] = c[i] - v[i + j] * c[i - 1];
        }

        polynomial<N, T> p;
        for (int i = 0; i <= n; ++i)
            p[i] = c[n - i];
        return p;
    }

    // symbolic format output
    // ignores 0 coeffecients except for x^0
    friend std::ostream& operator<<(std::ostream& os, const polynomial<N, T>& p)
    {
        for (int i = N - 1; i >= 0; --i)
        {
            if (i == 0)
            {
                os << p[i];
            }
            else
            {
                if (p[i] != T(0))
                    os << p[i] << "x^" << i << "+";
            }
        }
        return os;
    }
};
