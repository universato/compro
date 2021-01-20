#include <iostream>
#include <algorithm>
#include <cassert>
#include <vector>
using namespace std;

// Implement (union by size) + (path compression)
// Reference:
// Zvi Galil and Giuseppe F. Italiano,
// Data structures and algorithms for disjoint set union problems
struct dsu {
    public:
    dsu() : _n(0) {}
    dsu(int n) : _n(n), parent_or_size(n, -1) {}

    int unite(int a, int b) {
        assert(0 <= a && a < _n);
        assert(0 <= b && b < _n);
        int x = root(a), y = root(b);
        if (x == y) return x;
        if (-parent_or_size[x] < -parent_or_size[y]) std::swap(x, y);
        parent_or_size[x] += parent_or_size[y];
        parent_or_size[y] = x;
        return x;
    }

    bool same(int a, int b) {
        assert(0 <= a && a < _n);
        assert(0 <= b && b < _n);
        return root(a) == root(b);
    }

    int root(int a) {
        assert(0 <= a && a < _n);
        if (parent_or_size[a] < 0) return a;
        return parent_or_size[a] = root(parent_or_size[a]);
    }

    int size(int a) {
        assert(0 <= a && a < _n);
        return -parent_or_size[root(a)];
    }

    std::vector<std::vector<int> > groups() {
        std::vector<int> root_buf(_n), group_size(_n);
        for (int i = 0; i < _n; i++) {
            root_buf[i] = root(i);
            group_size[root_buf[i]]++;
        }
        std::vector<std::vector<int> > result(_n);
        for (int i = 0; i < _n; i++) {
            result[i].reserve(group_size[i]);
        }
        for (int i = 0; i < _n; i++) {
            result[root_buf[i]].push_back(i);
        }
        result.erase(
            std::remove_if(result.begin(), result.end(),
                            [&](const std::vector<int>& v) { return v.empty(); }),
            result.end());
        return result;
    }

    private:
    int _n;
    // root node: -1 * component size
    // otherwise: parent
    std::vector<int> parent_or_size;
};

void example(){
    dsu d(5);
    d.unite(1, 2);
    d.same(1, 2);
}

// https://old.yosupo.jp/submission/36288 159ms
void yosupo(){
    int n, q;
    std::cin >> n >> q;

    dsu uf(n);
    int t, u, v;
    for(int i = 0; i < q; i++){
        std::cin >> t >> u >> v;
        if(t == 0){
            uf.unite(u, v);
        } else {
            std::cout << (uf.same(u, v) ? 1 : 0) << "\n";
        }
    }
}

bool isMultpleTestcases = false;

void solve() {
    yosupo();
}

void run() {
    int _t = 1;
    if (isMultpleTestcases) std::cin >> _t;
    while (_t--) solve();
}

int main() {
    std::cin.tie(nullptr);
    std::ios_base::sync_with_stdio(false);
    // constexpr char endl = '\n';
    // std::cout << std::fixed << std::setprecision(15);
    run();
}
