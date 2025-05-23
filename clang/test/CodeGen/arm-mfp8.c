// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 5
// RUN: %clang_cc1 -emit-llvm -triple aarch64-arm-none-eabi -target-feature -fp8 -target-feature +neon -disable-O0-optnone -o -        %s | opt -S --passes=mem2reg | FileCheck %s --check-prefixes=CHECK-C
// RUN: %clang_cc1 -emit-llvm -triple aarch64-arm-none-eabi -target-feature -fp8 -target-feature +neon -disable-O0-optnone -o - -x c++ %s | opt -S --passes=mem2reg | FileCheck %s --check-prefixes=CHECK-CXX

// REQUIRES: aarch64-registered-target


#include <arm_neon.h>

// CHECK-C-LABEL: define dso_local <16 x i8> @test_ret_mfloat8x16_t(
// CHECK-C-SAME: <16 x i8> [[V:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-C-NEXT:  [[ENTRY:.*:]]
// CHECK-C-NEXT:    ret <16 x i8> [[V]]
//
// CHECK-CXX-LABEL: define dso_local <16 x i8> @_Z21test_ret_mfloat8x16_t14__Mfloat8x16_t(
// CHECK-CXX-SAME: <16 x i8> [[V:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-CXX-NEXT:  [[ENTRY:.*:]]
// CHECK-CXX-NEXT:    ret <16 x i8> [[V]]
//
mfloat8x16_t test_ret_mfloat8x16_t(mfloat8x16_t v) {
  return v;
}

// CHECK-C-LABEL: define dso_local <8 x i8> @test_ret_mfloat8x8_t(
// CHECK-C-SAME: <8 x i8> [[V:%.*]]) #[[ATTR0]] {
// CHECK-C-NEXT:  [[ENTRY:.*:]]
// CHECK-C-NEXT:    ret <8 x i8> [[V]]
//
// CHECK-CXX-LABEL: define dso_local <8 x i8> @_Z20test_ret_mfloat8x8_t13__Mfloat8x8_t(
// CHECK-CXX-SAME: <8 x i8> [[V:%.*]]) #[[ATTR0]] {
// CHECK-CXX-NEXT:  [[ENTRY:.*:]]
// CHECK-CXX-NEXT:    ret <8 x i8> [[V]]
//
mfloat8x8_t test_ret_mfloat8x8_t(mfloat8x8_t v) {
  return v;
}

// CHECK-C-LABEL: define dso_local <1 x i8> @func1n(
// CHECK-C-SAME: <1 x i8> [[MFP8:%.*]]) #[[ATTR0]] {
// CHECK-C-NEXT:  [[ENTRY:.*:]]
// CHECK-C-NEXT:    [[F1N:%.*]] = alloca [10 x <1 x i8>], align 1
// CHECK-C-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [10 x <1 x i8>], ptr [[F1N]], i64 0, i64 2
// CHECK-C-NEXT:    store <1 x i8> [[MFP8]], ptr [[ARRAYIDX]], align 1
// CHECK-C-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds [10 x <1 x i8>], ptr [[F1N]], i64 0, i64 2
// CHECK-C-NEXT:    [[TMP0:%.*]] = load <1 x i8>, ptr [[ARRAYIDX1]], align 1
// CHECK-C-NEXT:    ret <1 x i8> [[TMP0]]
//
// CHECK-CXX-LABEL: define dso_local <1 x i8> @_Z6func1nu6__mfp8(
// CHECK-CXX-SAME: <1 x i8> [[MFP8:%.*]]) #[[ATTR0]] {
// CHECK-CXX-NEXT:  [[ENTRY:.*:]]
// CHECK-CXX-NEXT:    [[F1N:%.*]] = alloca [10 x <1 x i8>], align 1
// CHECK-CXX-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [10 x <1 x i8>], ptr [[F1N]], i64 0, i64 2
// CHECK-CXX-NEXT:    store <1 x i8> [[MFP8]], ptr [[ARRAYIDX]], align 1
// CHECK-CXX-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds [10 x <1 x i8>], ptr [[F1N]], i64 0, i64 2
// CHECK-CXX-NEXT:    [[TMP0:%.*]] = load <1 x i8>, ptr [[ARRAYIDX1]], align 1
// CHECK-CXX-NEXT:    ret <1 x i8> [[TMP0]]
//
__mfp8 func1n(__mfp8 mfp8) {
  __mfp8 f1n[10];
  f1n[2] = mfp8;
  return f1n[2];
}

// CHECK-C-LABEL: define dso_local <1 x i8> @test_extract_element(
// CHECK-C-SAME: <16 x i8> [[X:%.*]], i32 noundef [[I:%.*]]) #[[ATTR0]] {
// CHECK-C-NEXT:  [[ENTRY:.*:]]
// CHECK-C-NEXT:    [[RETVAL:%.*]] = alloca <1 x i8>, align 1
// CHECK-C-NEXT:    [[VECEXT:%.*]] = extractelement <16 x i8> [[X]], i32 [[I]]
// CHECK-C-NEXT:    store i8 [[VECEXT]], ptr [[RETVAL]], align 1
// CHECK-C-NEXT:    [[TMP0:%.*]] = load <1 x i8>, ptr [[RETVAL]], align 1
// CHECK-C-NEXT:    ret <1 x i8> [[TMP0]]
//
// CHECK-CXX-LABEL: define dso_local <1 x i8> @_Z20test_extract_element14__Mfloat8x16_ti(
// CHECK-CXX-SAME: <16 x i8> [[X:%.*]], i32 noundef [[I:%.*]]) #[[ATTR0]] {
// CHECK-CXX-NEXT:  [[ENTRY:.*:]]
// CHECK-CXX-NEXT:    [[RETVAL:%.*]] = alloca <1 x i8>, align 1
// CHECK-CXX-NEXT:    [[VECEXT:%.*]] = extractelement <16 x i8> [[X]], i32 [[I]]
// CHECK-CXX-NEXT:    store i8 [[VECEXT]], ptr [[RETVAL]], align 1
// CHECK-CXX-NEXT:    [[TMP0:%.*]] = load <1 x i8>, ptr [[RETVAL]], align 1
// CHECK-CXX-NEXT:    ret <1 x i8> [[TMP0]]
//
mfloat8_t test_extract_element(mfloat8x16_t x, int i) {
  return x[i];
}

// CHECK-C-LABEL: define dso_local <16 x i8> @test_insert_element(
// CHECK-C-SAME: <16 x i8> [[X:%.*]], i32 noundef [[I:%.*]], <1 x i8> [[V:%.*]]) #[[ATTR0]] {
// CHECK-C-NEXT:  [[ENTRY:.*:]]
// CHECK-C-NEXT:    [[TMP0:%.*]] = bitcast <1 x i8> [[V]] to i8
// CHECK-C-NEXT:    [[VECINS:%.*]] = insertelement <16 x i8> [[X]], i8 [[TMP0]], i32 [[I]]
// CHECK-C-NEXT:    ret <16 x i8> [[VECINS]]
//
// CHECK-CXX-LABEL: define dso_local <16 x i8> @_Z19test_insert_element14__Mfloat8x16_tiu6__mfp8(
// CHECK-CXX-SAME: <16 x i8> [[X:%.*]], i32 noundef [[I:%.*]], <1 x i8> [[V:%.*]]) #[[ATTR0]] {
// CHECK-CXX-NEXT:  [[ENTRY:.*:]]
// CHECK-CXX-NEXT:    [[TMP0:%.*]] = bitcast <1 x i8> [[V]] to i8
// CHECK-CXX-NEXT:    [[VECINS:%.*]] = insertelement <16 x i8> [[X]], i8 [[TMP0]], i32 [[I]]
// CHECK-CXX-NEXT:    ret <16 x i8> [[VECINS]]
//
mfloat8x16_t test_insert_element(mfloat8x16_t x, int i, mfloat8_t v) {
  x[i] = v;
  return x;
}
