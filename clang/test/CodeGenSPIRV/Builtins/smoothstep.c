// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 5

// RUN: %clang_cc1 -O1 -triple spirv-pc-vulkan-compute %s -emit-llvm -o - | FileCheck %s

typedef float float2 __attribute__((ext_vector_type(2)));
typedef float float3 __attribute__((ext_vector_type(3)));
typedef float float4 __attribute__((ext_vector_type(4)));

// CHECK-LABEL: define spir_func float @test_smoothstep_float(
// CHECK-SAME: float noundef [[MIN:%.*]], float noundef [[MAX:%.*]], float noundef [[X:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    [[SPV_SMOOTHSTEP:%.*]] = tail call float @llvm.spv.smoothstep.f32(float [[MIN]], float [[MAX]], float [[X]])
// CHECK-NEXT:    ret float [[SPV_SMOOTHSTEP]]
//
float test_smoothstep_float(float Min, float Max, float X) { return __builtin_spirv_smoothstep(Min, Max, X); }

// CHECK-LABEL: define spir_func <2 x float> @test_smoothstep_float2(
// CHECK-SAME: <2 x float> noundef [[MIN:%.*]], <2 x float> noundef [[MAX:%.*]], <2 x float> noundef [[X:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    [[SPV_SMOOTHSTEP:%.*]] = tail call <2 x float> @llvm.spv.smoothstep.v2f32(<2 x float> [[MIN]], <2 x float> [[MAX]], <2 x float> [[X]])
// CHECK-NEXT:    ret <2 x float> [[SPV_SMOOTHSTEP]]
//
float2 test_smoothstep_float2(float2 Min, float2 Max, float2 X) { return __builtin_spirv_smoothstep(Min, Max, X); }

// CHECK-LABEL: define spir_func <3 x float> @test_smoothstep_float3(
// CHECK-SAME: <3 x float> noundef [[MIN:%.*]], <3 x float> noundef [[MAX:%.*]], <3 x float> noundef [[X:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    [[SPV_SMOOTHSTEP:%.*]] = tail call <3 x float> @llvm.spv.smoothstep.v3f32(<3 x float> [[MIN]], <3 x float> [[MAX]], <3 x float> [[X]])
// CHECK-NEXT:    ret <3 x float> [[SPV_SMOOTHSTEP]]
//
float3 test_smoothstep_float3(float3 Min, float3 Max, float3 X) { return __builtin_spirv_smoothstep(Min, Max, X); }

// CHECK-LABEL: define spir_func <4 x float> @test_smoothstep_float4(
// CHECK-SAME: <4 x float> noundef [[MIN:%.*]], <4 x float> noundef [[MAX:%.*]], <4 x float> noundef [[X:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    [[SPV_SMOOTHSTEP:%.*]] = tail call <4 x float> @llvm.spv.smoothstep.v4f32(<4 x float> [[MIN]], <4 x float> [[MAX]], <4 x float> [[X]])
// CHECK-NEXT:    ret <4 x float> [[SPV_SMOOTHSTEP]]
//
float4 test_smoothstep_float4(float4 Min, float4 Max, float4 X) { return __builtin_spirv_smoothstep(Min, Max, X); }
