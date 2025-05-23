//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef _LIBCPP___TYPE_TRAITS_IS_NOTHROW_DESTRUCTIBLE_H
#define _LIBCPP___TYPE_TRAITS_IS_NOTHROW_DESTRUCTIBLE_H

#include <__config>
#include <__cstddef/size_t.h>
#include <__type_traits/integral_constant.h>
#include <__type_traits/is_destructible.h>
#include <__utility/declval.h>

#if !defined(_LIBCPP_HAS_NO_PRAGMA_SYSTEM_HEADER)
#  pragma GCC system_header
#endif

_LIBCPP_BEGIN_NAMESPACE_STD

#if __has_builtin(__is_nothrow_destructible)

template <class _Tp>
struct _LIBCPP_NO_SPECIALIZATIONS is_nothrow_destructible : integral_constant<bool, __is_nothrow_destructible(_Tp)> {};

#else

template <bool, class _Tp>
struct __libcpp_is_nothrow_destructible;

template <class _Tp>
struct __libcpp_is_nothrow_destructible<false, _Tp> : false_type {};

template <class _Tp>
struct __libcpp_is_nothrow_destructible<true, _Tp> : integral_constant<bool, noexcept(std::declval<_Tp>().~_Tp()) > {};

template <class _Tp>
struct is_nothrow_destructible : __libcpp_is_nothrow_destructible<is_destructible<_Tp>::value, _Tp> {};

template <class _Tp, size_t _Ns>
struct is_nothrow_destructible<_Tp[_Ns]> : is_nothrow_destructible<_Tp> {};

template <class _Tp>
struct is_nothrow_destructible<_Tp&> : true_type {};

template <class _Tp>
struct is_nothrow_destructible<_Tp&&> : true_type {};

#endif // __has_builtin(__is_nothrow_destructible)

#if _LIBCPP_STD_VER >= 17
template <class _Tp>
_LIBCPP_NO_SPECIALIZATIONS inline constexpr bool is_nothrow_destructible_v = is_nothrow_destructible<_Tp>::value;
#endif

_LIBCPP_END_NAMESPACE_STD

#endif // _LIBCPP___TYPE_TRAITS_IS_NOTHROW_DESTRUCTIBLE_H
