#include <iostream>
#include <iomanip>
#include <vector>
#include <cmath>
using namespace std;

#define EPS (1e-10)
#define equals(a,b) (fabs((a)-(b))<EPS)

static const int COUNTER_CLOCKWISE = 1;
static const int CLOCKWISE = -1;
static const int ONLINE_BACK = 2;
static const int ONLINE_FRONT = -2;
static const int ON_SEGMENT = 0;

string ans[] = {"ONLINE_FRONT", "CLOCKWISE", "ON_SEGMENT", "COUNTER_CLOCKWISE", "ONLINE_BACK"};

class Point{
    public:
    double x,y;

    Point(double x = 0.0, double y = 0.0): x(x),y(y) {}

    Point operator + (Point p){ return Point(x+p.x, y+p.y); }
    Point operator - (Point p){ return Point(x-p.x, y-p.y); }
    Point operator * (double k){ return Point(x*k, y*k); }
    Point operator / (double k){ return Point(x/k, y/k); }
    Point operator - () const  { return Point(-x, -y); }

    double norm() { return x*x + y*y; }
    double abs() { return sqrt(norm()); }

    bool operator < (const Point &p) const{
        return x != p.x ? p.x : y < p.y;
    }

    bool operator == (const Point &p) const{
        return fabs(x - p.x) < EPS and fabs(y - p.y) < EPS;
    }

    void print(){
        cout << fixed << setprecision(9);
        cout << x << ' ' << y << endl;
    }
};

typedef Point Vector;

double norm(Vector a){
    return a.x*a.x + a.y*a.y;
}

double abs(Vector a){
    return sqrt(norm(a));
}

struct Segment {
    Point p1, p2;
    Segment(Point p1, Point p2): p1(p1),p2(p2) {}
};

typedef Segment Line;

double cross(Vector a, Vector b){
    return a.x * b.y - a.y * b.x;
}

double dot(Vector a, Vector b){
    return a.x * b.x + a.y * b.y;
}

Point project(Segment s, Point p){
    Vector base = s.p2 - s.p1;
    double r = dot(p -s.p1, base) / norm(base);
    return s.p1 + base * r;
}

Point reflect(Segment s, Point p){
    return p + (project(s,p)-p) * 2.0;
}

int ccw(Point p0, Point p1, Point p2){
    Vector a = p1 - p0;
    Vector b = p2 - p0;
    if( cross(a,b) > EPS) return COUNTER_CLOCKWISE;
    if( cross(a,b) < -EPS) return CLOCKWISE;
    if( dot(a,b) < -EPS) return ONLINE_BACK;
    if( a.norm() < b.norm()) return ONLINE_FRONT;
    return ON_SEGMENT;
}

double getDistanceLP(Line l, Point p){
    return abs(cross(l.p2-l.p1, p-l.p1)/abs(l.p2-l.p1));
}

double getDistanceSP(Segment s, Point p){
    if ( dot(s.p2-s.p1, p-s.p1) < 0.0 ) return abs(p-s.p1);
    if ( dot(s.p1-s.p2, p-s.p2) < 0.0 ) return abs(p-s.p2);
    return getDistanceLP(s,p);
}

bool intersect(Point p1, Point p2, Point p3, Point p4){
    return ( ccw(p1, p2, p3) * ccw(p1, p2, p4) <= 0 and  ccw(p3, p4, p1) * ccw(p3, p4, p2) <= 0 );
}

bool intersect(Segment s, Segment t){
    return intersect( s.p1, s.p2, t.p1, t.p2);
}

bool isOrthogonal(Vector a, Vector b){
    return equals(dot(a,b), 0.0);
}

bool isParallel(Vector a, Vector b){
    return equals(cross(a,b), 0.0);
}

Point getCrossPoint(Segment s1, Segment s2){
    Vector base = s2.p2 - s2.p1;
    double d1 = abs(cross(base, s1.p1-s2.p1));
    double d2 = abs(cross(base, s1.p2-s2.p1));
    double t = d1 / (d1 + d2);
    return s1.p1 + (s1.p2 - s1.p1) * t;
}

double getDistance(Segment s, Segment t){
    if(intersect(s,t)) return 0.0;
    return min( min(getDistanceSP(s,t.p1), getDistanceSP(s,t.p2)), min(getDistanceSP(t,s.p1), getDistanceSP(t,s.p2)) );
}

typedef vector<Point> Polygon;

#define curr(P, i) P[(i) % P.size()]
#define next(P, i) P[(i+1) % P.size()]
#define prev(P, i) P[(i+P.size()-1) % P.size()]
bool isconvex(const Polygon &P) {
    for (int i = 0; i < P.size(); ++i)
    if (ccw(prev(P, i), curr(P, i), next(P, i)) == CLOCKWISE or ccw(prev(P, i), curr(P, i), next(P, i)) ==ONLINE_BACK) return false;
    return true;
}

int contains(Polygon g, Point p){
    int n = g.size();
    bool x = false;
    for(int i=0; i<n; i++){
        Point a = g[i] - p,  b = g[(i+1)%n] - p;
        if( abs(cross(a,b)) < EPS  and  dot(a,b) < EPS ) return 1;
        if( a.y > b.y ) swap(a,b);
        if( a.y < EPS  and  EPS < b.y  and  cross(a,b) > EPS ) x = not(x);
    }
    return (x ? 2 : 0);
}

int main(){
    int N;
    cin>>N;
    /*
    if(N==3){
        Point p[3];
        for(int i=0;i<3;i++) cin>>p[i].x>>p[i].y;
        if(ccw(p[0],p[1],p[2])==1 or ccw(p[0],p[1],p[2])==-1 or ccw(p[0],p[1],p[2])==0) cout << 1 << endl;
        else cout << 0 << endl;

        return 0;
    }*/

    Point p;
    Polygon ppp;
    for(int i=0;i<N;i++){
        cin>>p.x>>p.y;
        ppp.push_back(p);
    }

    int q;
    cin>>q;
    int ans;
    while(q--){
        cin>>p.x>>p.y;
        ans = contains(ppp, p);
        cout << ans << endl;
    }
    return 0;
}
