#include "ruby.h"
// 作りかけだけど、あまり作る気がない。
static VALUE
rb_method_unionfind_initialize(VALUE self, VALUE size)
{
    if(FIXNUM_P(size)){
      long c_size = FIX2LONG(size);

      rb_iv_set(self, "data", rb_ary_new2(FIX2LONG(size)));
    }

    return size;
}

static VALUE
rb_method_unionfind_unite(VALUE self, VALUE x, VALUE y)
{
    if(FIXNUM_P(x) && FIXNUM_P(y)){
      return LONG2NUM(FIX2LONG(x) + FIX2LONG(y));
    }

    return x;
}

static VALUE
rb_method_unionfind_same_p(VALUE self, VALUE x, VALUE y)
{
    if(FIXNUM_P(x) && FIXNUM_P(y)){
      return Qfalse;
    }

    return Qtrue;
}

/* require 'union_find' で UnionFind クラスと UnionFind#unite メソッドが定義されるようにする。*/
void
Init_union_find(void)
{
    /* UnionFind class を Object クラスの派生クラスとして定義する */
    VALUE rb_cUnionFind = rb_define_class("UnionFind", rb_cObject); /* -> class Bar */

    /*
     * Barクラスのメソッド len を定義する。
     * lenメソッドの中身は、C言語のfbar_len 関数で定義する。
     * lenメソッドの引数は、1つ。
     */
    rb_define_method(rb_cUnionFind, "initialize", rb_method_unionfind_initialize, 1);
    rb_define_method(rb_cUnionFind, "unite", rb_method_unionfind_unite, 2); /* -> def len(arg) */
    rb_define_method(rb_cUnionFind, "same?", rb_method_unionfind_same_p, 2);
}
