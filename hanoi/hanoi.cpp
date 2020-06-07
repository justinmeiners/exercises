#include <iostream>
#include <vector>
#include <numeric>

void display_disc(int w, int max_width, char c)
{
    int offset = (max_width - w) / 2;

    for (int i = 0; i < offset; ++i)
        std::cout << " ";

    for (int i = 0; i < w; ++i)
        std::cout << c;

    for (int i = 0; i < offset; ++i)
        std::cout << " ";
}

void display_poles(int N,
                   const std::vector<std::vector<int>>& poles)
{
    for (int i = N - 1; i >= 0; --i)
    {
        for (auto& p : poles)
        {
            int w = p.size() > i ? p[i] : N;
            display_disc((N - 1 - w) * 2 + 1, N * 2 + 1, '=');
        }
        std::cout << std::endl;
    }

    std::cout << std::endl;
}

// from -> other -> to
void move_discs(int n,
                int from,
                int other,
                int to, 
                std::vector<std::vector<int>>& poles)
{
    if (n <= 0) return;
    move_discs(n-1, from, to, other, poles);
    poles[to].push_back(poles[from].back());
    poles[from].pop_back();
    display_poles(8, poles);
    move_discs(n-1, other, from, to, poles);
}


int main(int argc, const char* argv[])
{
    constexpr int N = 8;
    std::vector<std::vector<int>> poles(3);
    poles[0].resize(N);
    std::iota(poles[0].begin(), poles[0].end(), 1);
    move_discs(N, 0, 1, 2, poles);
    return 1;
}

