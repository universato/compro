#include "ruby.h"

void
Init_modint(void)
{
    VALUE rb_cModInt = rb_define_class("ModInt", rb_cObject);

    rb_define_method(rb_cModInt, "initialize", rb_method_unionfind_initialize, 1);
    rb_define_method(rb_cModInt, "", rb_method_unionfind_unite, 2);
    rb_define_method(rb_cModInt, "same?", rb_method_unionfind_same_p, 2);
}
