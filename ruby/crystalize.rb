# [WIP] [TOD]
# RubyからCrystalに変換するためのツール。
# シングルクォートの文字列をダブルクォートに変換する。
# prepend や unshift を使っている Array は、Deque に変換する。
# 文字列中の中のものは、どうする？

code.gsub!("to_i", "to_i64")
code.gsub!("gets", "gets.to_s")
code.gsub!("to_s.to_s", "to_s")

code.gsub!("readline", "read_line")

eaches = [
  "combination",
  "permutation",
  "repeated_combination",
  "repeated_permutation",
]

syntaxes = {
  "&:to_i" => "&.to_i",
  "&:to_f" => "&.to_f",
  "&:to_s" => "&.to_s"
}

verb_conjugations = {
  "include?" => "includes?",
  "start_with?" => "starts_with?",
  "end_with?" => "ends_with?",
}

different_names = {
  "attr_accessor" => "property",
  "attr_writer" => "setter",
  "attr_reader" => "getter",
  "exclude_end?" => "exclusive?"
}

aliases = {
  "collect" => "map",
  "length" => "size",
  "inject" => "reduce",
  "find_all" => "select",
  "filter" => "select",
  "detect" => "find",
  "find_index" => "index",
  "append" => "push",
  "prepend" => "unshift",
  "take" => "first",
  "delete_if" => "reject!",
  "each_pair" => "each",
  "keep_if" => "select!",
  "filter" => "select!",
  "key?" => "has_key?",
  "member" => "has_key?",
  "include?" => "has_key?",
  "value" => "has_value?",
  "update" => "merge!",
}
