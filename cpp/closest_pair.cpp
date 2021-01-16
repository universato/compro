
// 最近点対
// AOJ C++17で通った。
// 蟻本を写経しただけ。
#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>
using namespace std;

typedef pair<double, double> point;

int N;
point A[1000000];
long double INF = 10e9;

bool compare_y(point a, point b){
  return a.second < b.second;
}

double closest_pair(point *a, int n){
  if (n <= 1) return INF;
  int m = n / 2;
  double x = a[m].first;
  double d = min(closest_pair(a, m), closest_pair(a + m, n - m));
  inplace_merge(a, a + m, a + n, compare_y);

  std::vector<point> b;
  for (int i = 0; i < n; i++){
    if (fabs(a[i].first - x) >= d) continue;

    for (int j = 0; j < b.size(); j++){
      double dx = a[i].first - b[b.size() - j - 1].first;
      double dy = a[i].second - b[b.size() - j - 1].second;
      if (dy >= d) break;
      d = min(d, sqrt(dx * dx + dy * dy));
    }
    b.push_back(a[i]);
  }
  return d;
}

int main(void){
  cin >> N;
  for(int i = 0; i < N; i++){ cin >> A[i].first >> A[i].second; }
  sort(A, A + N);
  printf("%.10f\n", closest_pair(A, N));
  return 0;
}
