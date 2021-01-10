
辺を追加するときの容量がInt64にしか対応してないから注意かもしれない。
逆に、頂点はInt32しか対応してないことにも注意だろう。

DFS
  # ac-library auto dfs = [&](auto self, int v, Cap up) {
  #                 f = dfs(dfs, t, flow_limit - flow);
  # ac-library-rb dfs(v, up, s, level, iter)
  # ac-library.cr private def dfs(node, target, flow))
  #               flowed = dfs(start, target, Int64::MAX)
  # 蟻本 dfs(v, t, f) dfs(s, t, INF)

ARC111 - Bで使ったけどTLEした。
ACLのC++でも、1000ms台なので厳しいか。
