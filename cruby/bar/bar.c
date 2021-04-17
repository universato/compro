#include "ruby.h"

static VALUE
fbar_len(VALUE self, VALUE arg)
{
    /*
     * Bar#len メソッドの中身の arg.size を実行して
     * その結果をBar#lenメソッドの戻り値にする
     */
    return rb_funcall(arg, rb_intern("size"), 0, 0); /* -> bar.size */
}

/* require 'bar' で Bar クラスと Bar#len メソッドが定義されるようにする。*/
void
Init_bar(void)
{
    /* Bar class を Object クラスの派生クラスとして定義する */
    VALUE cBar = rb_define_class("Bar", rb_cObject); /* -> class Bar */

    /*
     * Barクラスのメソッド len を定義する。
     * lenメソッドの中身は、C言語のfbar_len 関数で定義する。
     * lenメソッドの引数は、1つ。
     */
    rb_define_method(cBar, "len", fbar_len, 1); /* -> def len(arg) */
}
