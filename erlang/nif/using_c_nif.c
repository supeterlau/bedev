#include <erl_nif.h>

extern int foo(int x);
extern int bar(int y);
extern unsigned long long factorial(int nth);

static ERL_NIF_TERM factorial_nif(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  int nth;
  unsigned long long ret;
  if (!enif_get_int(env, argv[0], &nth)) {
    return enif_make_badarg(env);
  }
  ret = factorial(nth);
  return enif_make_ulong(env, ret);
}

static ERL_NIF_TERM foo_nif(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  int x, ret;
  if (!enif_get_int(env, argv[0], &x)) {
    return enif_make_badarg(env);
  }
  ret = foo(x);
  return enif_make_int(env, ret);
}

static ERL_NIF_TERM bar_nif(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  int y, ret;
  if (!enif_get_int(env, argv[0], &y)) {
    return enif_make_badarg(env);
  }
  ret = bar(y);
  return enif_make_int(env, ret);
}

static ErlNifFunc nif_funcs[] = {
  {"factorial", 1, factorial_nif},
  {"foo", 1, foo_nif},
  {"bar", 1, bar_nif}
};

// TODO
ERL_NIF_INIT(using_c, nif_funcs, NULL, NULL, NULL, NULL)
