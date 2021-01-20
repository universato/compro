#include <bits/stdc++.h>
using namespace std;

#define rep(i,n) for (int i = 0; i < (n); ++i)
#define times(n) for (int i = 0; i < (n); ++i)
using lint = long long;
using ll = long long;
using int64 = long long;
using P = std::pair<int, int>;
using point = std::pair<int, int>;

struct edge{
    int from,to,trm;
    ll cost,trmc;
    edge(int a, int b, ll c, int d, ll e) :from(a),to(b),cost(c){}
};
typedef pair<ll,int> P;

ll INF = LONG_MAX/2;
vector<edge> G[25260];
vector<ll> d(25260, INF);
vector<ll> c(25260, INF);

void dijkstra(int s){
    priority_queue<P, vector<P>, greater<P>> que;
    d[s] = 0;
    que.push(P(0, s));

    while(!que.empty()){
        P p = que.top();
        que.pop();
        int v = p.second;
        if(d[v] < p.first) continue;
        for(int i = 0;  i < G[v].size(); i++){
            edge e = G[v][i];
            if(d[e.to] > d[v] + e.cost){
                d[e.to] = d[v] + e.cost;
                que.push(P(d[e.to], e.to));
            }
        }
    }
}

void solve() {
  int n, m, s, t;
  cin >> n >> m >> s >> t;

  int a, b, c;
  for(int i = 0; i < m; i++){
    cin >> a >> b >> c;
  }

  cout << dijkstra(s)[t] << '\n';
}

bool isMultpleTestcases = false;

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
