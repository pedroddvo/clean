#include <lean/lean.h>
#include <stdio.h>

#define def_int(idn, sz) \
    idn##_t idn##_of_uidn##_mk(u##idn##_t n) { return (idn##_t)n; } \
    idn##_t idn##_neg(idn##_t n) { return -n; } \
    u##idn##_t idn##_to_uint32(idn##_t n) { return (u##idn##_t)n; } \
    idn##_t idn##_of_nat(lean_object* nat) { return (idn##_t)lean_u##idn##_of_nat(nat); } \
    lean_object* idn##_to_int(idn##_t n) { return lean_int64_to_int(n); } \
    idn##_t idn##_add(idn##_t a1, idn##_t a2) { return a1+a2; } \
    idn##_t idn##_sub(idn##_t a1, idn##_t a2) { return a1-a2; } \
    idn##_t idn##_mul(idn##_t a1, idn##_t a2) { return a1*a2; } \
    idn##_t idn##_div(idn##_t a1, idn##_t a2) { return a2 == 0 ? 0  : a1/a2; } \
    idn##_t idn##_mod(idn##_t a1, idn##_t a2) { return a2 == 0 ? a1 : a1%a2; } \
    idn##_t idn##_land(idn##_t a, idn##_t b) { return a & b; } \
    idn##_t idn##_lor(idn##_t a, idn##_t b) { return a | b; } \
    idn##_t idn##_xor(idn##_t a, idn##_t b) { return a ^ b; } \
    idn##_t idn##_shift_left(idn##_t a, idn##_t b) { return a << (b % sz); } \
    idn##_t idn##_shift_right(idn##_t a, idn##_t b) { return a >> (b % sz); } \
    idn##_t idn##_complement(idn##_t a) { return ~a; }

def_int(int8, 8)
def_int(int16, 16)
def_int(int32, 32)
def_int(int64, 64)