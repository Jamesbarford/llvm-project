//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include <algorithm>
#include <random>

#if _LIBCPP_HAS_THREADS
#  include <mutex>
#  if defined(__ELF__) && defined(_LIBCPP_LINK_PTHREAD_LIB)
#    pragma comment(lib, "pthread")
#  endif
#endif

_LIBCPP_BEGIN_NAMESPACE_STD
_LIBCPP_BEGIN_EXPLICIT_ABI_ANNOTATIONS

#if _LIBCPP_HAS_THREADS
static constinit __libcpp_mutex_t __rs_mut = _LIBCPP_MUTEX_INITIALIZER;
#endif
unsigned __rs_default::__c_ = 0;

__rs_default::__rs_default() {
#if _LIBCPP_HAS_THREADS
  __libcpp_mutex_lock(&__rs_mut);
#endif
  __c_ = 1;
}

__rs_default::__rs_default(const __rs_default&) { ++__c_; }

__rs_default::~__rs_default() {
#if _LIBCPP_HAS_THREADS
  if (--__c_ == 0)
    __libcpp_mutex_unlock(&__rs_mut);
#else
  --__c_;
#endif
}

__rs_default::result_type __rs_default::operator()() {
  static mt19937 __rs_g;
  return __rs_g();
}

__rs_default __rs_get() { return __rs_default(); }

_LIBCPP_END_EXPLICIT_ABI_ANNOTATIONS
_LIBCPP_END_NAMESPACE_STD
