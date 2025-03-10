//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// REQUIRES: c++17 || c++20 || c++23

// XFAIL: no-wide-characters

// <codecvt>

// ensure that wbuffer_convert is marked as deprecated

#include <codecvt>
#include <locale>

std::wbuffer_convert<std::codecvt_utf8<wchar_t>> c1; // expected-warning-re {{'wbuffer_convert<std::codecvt_utf8<wchar_t{{.*}}>>' is deprecated}}
// expected-warning-re@-1 {{'codecvt_utf8<wchar_t{{.*}}>' is deprecated}}
