; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt -S -passes=instcombine %s | FileCheck %s

declare { float, i32 } @llvm.frexp.f32.i32(float)
declare { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float>)
declare { <4 x float>, <4 x i32> } @llvm.frexp.v4f32.v4i32(<4 x float>)
declare { ppc_fp128, i32 } @llvm.frexp.ppcf128.i32(ppc_fp128)
declare { <vscale x 2 x float>, <vscale x 2 x i32> } @llvm.frexp.nxv2f32.nxv2i32(<vscale x 2 x float>)


define { float, i32 } @frexp_frexp(float %x) {
; CHECK-LABEL: define { float, i32 } @frexp_frexp(
; CHECK-SAME: float [[X:%.*]]) {
; CHECK-NEXT:    [[FREXP0:%.*]] = call { float, i32 } @llvm.frexp.f32.i32(float [[X]])
; CHECK-NEXT:    [[FREXP1:%.*]] = insertvalue { float, i32 } [[FREXP0]], i32 0, 1
; CHECK-NEXT:    ret { float, i32 } [[FREXP1]]
;
  %frexp0 = call { float, i32 } @llvm.frexp.f32.i32(float %x)
  %frexp0.0 = extractvalue { float, i32 } %frexp0, 0
  %frexp1 = call { float, i32 } @llvm.frexp.f32.i32(float %frexp0.0)
  ret { float, i32 } %frexp1
}

define { <2 x float>, <2 x i32> } @frexp_frexp_vector(<2 x float> %x) {
; CHECK-LABEL: define { <2 x float>, <2 x i32> } @frexp_frexp_vector(
; CHECK-SAME: <2 x float> [[X:%.*]]) {
; CHECK-NEXT:    [[FREXP0:%.*]] = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> [[X]])
; CHECK-NEXT:    [[FREXP1:%.*]] = insertvalue { <2 x float>, <2 x i32> } [[FREXP0]], <2 x i32> zeroinitializer, 1
; CHECK-NEXT:    ret { <2 x float>, <2 x i32> } [[FREXP1]]
;
  %frexp0 = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> %x)
  %frexp0.0 = extractvalue { <2 x float>, <2 x i32> } %frexp0, 0
  %frexp1 = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> %frexp0.0)
  ret { <2 x float>, <2 x i32> } %frexp1
}

define { float, i32 } @frexp_frexp_const(float %x) {
; CHECK-LABEL: define { float, i32 } @frexp_frexp_const(
; CHECK-SAME: float [[X:%.*]]) {
; CHECK-NEXT:    ret { float, i32 } { float 6.562500e-01, i32 0 }
;
  %frexp0 = call { float, i32 } @llvm.frexp.f32.i32(float 42.0)
  %frexp0.0 = extractvalue { float, i32 } %frexp0, 0
  %frexp1 = call { float, i32 } @llvm.frexp.f32.i32(float %frexp0.0)
  ret { float, i32 } %frexp1
}

define { <vscale x 2 x float>, <vscale x 2 x i32> } @frexp_frexp_scalable_vector(<vscale x 2 x float> %x) {
; CHECK-LABEL: define { <vscale x 2 x float>, <vscale x 2 x i32> } @frexp_frexp_scalable_vector(
; CHECK-SAME: <vscale x 2 x float> [[X:%.*]]) {
; CHECK-NEXT:    [[FREXP0:%.*]] = call { <vscale x 2 x float>, <vscale x 2 x i32> } @llvm.frexp.nxv2f32.nxv2i32(<vscale x 2 x float> [[X]])
; CHECK-NEXT:    [[FREXP1:%.*]] = insertvalue { <vscale x 2 x float>, <vscale x 2 x i32> } [[FREXP0]], <vscale x 2 x i32> zeroinitializer, 1
; CHECK-NEXT:    ret { <vscale x 2 x float>, <vscale x 2 x i32> } [[FREXP1]]
;
  %frexp0 = call { <vscale x 2 x float>, <vscale x 2 x i32> } @llvm.frexp.nxv2f32.nxv2i32(<vscale x 2 x float> %x)
  %frexp0.0 = extractvalue { <vscale x 2 x float>, <vscale x 2 x i32> } %frexp0, 0
  %frexp1 = call { <vscale x 2 x float>, <vscale x 2 x i32> } @llvm.frexp.nxv2f32.nxv2i32(<vscale x 2 x float> %frexp0.0)
  ret { <vscale x 2 x float>, <vscale x 2 x i32> } %frexp1
}

define { float, i32 } @frexp_poison() {
; CHECK-LABEL: define { float, i32 } @frexp_poison() {
; CHECK-NEXT:    ret { float, i32 } poison
;
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float poison)
  ret { float, i32 } %ret
}

define { <2 x float>, <2 x i32> } @frexp_poison_vector() {
; CHECK-LABEL: define { <2 x float>, <2 x i32> } @frexp_poison_vector() {
; CHECK-NEXT:    ret { <2 x float>, <2 x i32> } poison
;
  %ret = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> poison)
  ret { <2 x float>, <2 x i32> } %ret
}

define { <vscale x 2 x float>, <vscale x 2 x i32> } @frexp_poison_scaleable_vector() {
; CHECK-LABEL: define { <vscale x 2 x float>, <vscale x 2 x i32> } @frexp_poison_scaleable_vector() {
; CHECK-NEXT:    ret { <vscale x 2 x float>, <vscale x 2 x i32> } poison
;
  %ret = call { <vscale x 2 x float>, <vscale x 2 x i32> } @llvm.frexp.nxv2f32.nxv2i32(<vscale x 2 x float> poison)
  ret { <vscale x 2 x float>, <vscale x 2 x i32> } %ret
}

define { float, i32 } @frexp_undef() {
; CHECK-LABEL: define { float, i32 } @frexp_undef() {
; CHECK-NEXT:    [[RET:%.*]] = call { float, i32 } @llvm.frexp.f32.i32(float undef)
; CHECK-NEXT:    ret { float, i32 } [[RET]]
;
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float undef)
  ret { float, i32 } %ret
}
define { <2 x float>, <2 x i32> } @frexp_undef_vector() {
; CHECK-LABEL: define { <2 x float>, <2 x i32> } @frexp_undef_vector() {
; CHECK-NEXT:    [[RET:%.*]] = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> undef)
; CHECK-NEXT:    ret { <2 x float>, <2 x i32> } [[RET]]
;
  %ret = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> undef)
  ret { <2 x float>, <2 x i32> } %ret
}

define { <2 x float>, <2 x i32> } @frexp_zero_vector() {
; CHECK-LABEL: define { <2 x float>, <2 x i32> } @frexp_zero_vector() {
; CHECK-NEXT:    ret { <2 x float>, <2 x i32> } zeroinitializer
;
  %ret = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> zeroinitializer)
  ret { <2 x float>, <2 x i32> } %ret
}

define { <vscale x 2 x float>, <vscale x 2 x i32> } @frexp_zero_scalable_vector() {
; CHECK-LABEL: define { <vscale x 2 x float>, <vscale x 2 x i32> } @frexp_zero_scalable_vector() {
; CHECK-NEXT:    [[RET:%.*]] = call { <vscale x 2 x float>, <vscale x 2 x i32> } @llvm.frexp.nxv2f32.nxv2i32(<vscale x 2 x float> zeroinitializer)
; CHECK-NEXT:    ret { <vscale x 2 x float>, <vscale x 2 x i32> } [[RET]]
;
  %ret = call { <vscale x 2 x float>, <vscale x 2 x i32> } @llvm.frexp.nxv2f32.nxv2i32(<vscale x 2 x float> zeroinitializer)
  ret { <vscale x 2 x float>, <vscale x 2 x i32> } %ret
}

define { <2 x float>, <2 x i32> } @frexp_zero_negzero_vector() {
; CHECK-LABEL: define { <2 x float>, <2 x i32> } @frexp_zero_negzero_vector() {
; CHECK-NEXT:    ret { <2 x float>, <2 x i32> } { <2 x float> <float 0.000000e+00, float -0.000000e+00>, <2 x i32> zeroinitializer }
;
  %ret = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> <float 0.0, float -0.0>)
  ret { <2 x float>, <2 x i32> } %ret
}

define { <4 x float>, <4 x i32> } @frexp_nonsplat_vector() {
; CHECK-LABEL: define { <4 x float>, <4 x i32> } @frexp_nonsplat_vector() {
; CHECK-NEXT:    [[RET:%.*]] = call { <4 x float>, <4 x i32> } @llvm.frexp.v4f32.v4i32(<4 x float> <float 1.600000e+01, float -3.200000e+01, float undef, float 9.999000e+03>)
; CHECK-NEXT:    ret { <4 x float>, <4 x i32> } [[RET]]
;
  %ret = call { <4 x float>, <4 x i32> } @llvm.frexp.v4f32.v4i32(<4 x float> <float 16.0, float -32.0, float undef, float 9999.0>)
  ret { <4 x float>, <4 x i32> } %ret
}

define { float, i32 } @frexp_zero() {
; CHECK-LABEL: define { float, i32 } @frexp_zero() {
; CHECK-NEXT:    ret { float, i32 } zeroinitializer
;
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float 0.0)
  ret { float, i32 } %ret
}

define { float, i32 } @frexp_negzero() {
; CHECK-LABEL: define { float, i32 } @frexp_negzero() {
; CHECK-NEXT:    ret { float, i32 } { float -0.000000e+00, i32 0 }
;
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float -0.0)
  ret { float, i32 } %ret
}

define { float, i32 } @frexp_one() {
; CHECK-LABEL: define { float, i32 } @frexp_one() {
; CHECK-NEXT:    ret { float, i32 } { float 5.000000e-01, i32 1 }
;
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float 1.0)
  ret { float, i32 } %ret
}

define { float, i32 } @frexp_negone() {
; CHECK-LABEL: define { float, i32 } @frexp_negone() {
; CHECK-NEXT:    ret { float, i32 } { float -5.000000e-01, i32 1 }
;
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float -1.0)
  ret { float, i32 } %ret
}

define { float, i32 } @frexp_two() {
; CHECK-LABEL: define { float, i32 } @frexp_two() {
; CHECK-NEXT:    ret { float, i32 } { float 5.000000e-01, i32 2 }
;
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float 2.0)
  ret { float, i32 } %ret
}

define { float, i32 } @frexp_negtwo() {
; CHECK-LABEL: define { float, i32 } @frexp_negtwo() {
; CHECK-NEXT:    ret { float, i32 } { float -5.000000e-01, i32 2 }
;
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float -2.0)
  ret { float, i32 } %ret
}

define { float, i32 } @frexp_inf() {
; CHECK-LABEL: define { float, i32 } @frexp_inf() {
; CHECK-NEXT:    ret { float, i32 } { float 0x7FF0000000000000, i32 0 }
;
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float 0x7FF0000000000000)
  ret { float, i32 } %ret
}

define { float, i32 } @frexp_neginf() {
; CHECK-LABEL: define { float, i32 } @frexp_neginf() {
; CHECK-NEXT:    ret { float, i32 } { float 0xFFF0000000000000, i32 0 }
;
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float 0xFFF0000000000000)
  ret { float, i32 } %ret
}

define { float, i32 } @frexp_qnan() {
; CHECK-LABEL: define { float, i32 } @frexp_qnan() {
; CHECK-NEXT:    ret { float, i32 } { float 0x7FF8000000000000, i32 0 }
;
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float 0x7FF8000000000000)
  ret { float, i32 } %ret
}

define { float, i32 } @frexp_snan() {
; CHECK-LABEL: define { float, i32 } @frexp_snan() {
; CHECK-NEXT:    ret { float, i32 } { float 0x7FF8000020000000, i32 0 }
;
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float bitcast (i32 2139095041 to float))
  ret { float, i32 } %ret
}

define { float, i32 } @frexp_pos_denorm() {
; CHECK-LABEL: define { float, i32 } @frexp_pos_denorm() {
; CHECK-NEXT:    ret { float, i32 } { float 0x3FEFFFFFC0000000, i32 -126 }
;
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float bitcast (i32 8388607 to float))
  ret { float, i32 } %ret
}

define { float, i32 } @frexp_neg_denorm() {
; CHECK-LABEL: define { float, i32 } @frexp_neg_denorm() {
; CHECK-NEXT:    ret { float, i32 } { float 0xBFEFFFFFC0000000, i32 -126 }
;
  %ret = call { float, i32 } @llvm.frexp.f32.i32(float bitcast (i32 -2139095041 to float))
  ret { float, i32 } %ret
}

define { ppc_fp128, i32 } @frexp_one_ppcf128() {
; CHECK-LABEL: define { ppc_fp128, i32 } @frexp_one_ppcf128() {
; CHECK-NEXT:    ret { ppc_fp128, i32 } { ppc_fp128 0xM3FE00000000000000000000000000000, i32 1 }
;
  %ret = call { ppc_fp128, i32 } @llvm.frexp.ppcf128.i32(ppc_fp128 0xM3FF00000000000000000000000000000)
  ret { ppc_fp128, i32 } %ret
}

define { ppc_fp128, i32 } @frexp_negone_ppcf128() {
; CHECK-LABEL: define { ppc_fp128, i32 } @frexp_negone_ppcf128() {
; CHECK-NEXT:    ret { ppc_fp128, i32 } { ppc_fp128 0xMBFE00000000000000000000000000000, i32 1 }
;
  %ret = call { ppc_fp128, i32 } @llvm.frexp.ppcf128.i32(ppc_fp128 0xMBFF00000000000000000000000000000)
  ret { ppc_fp128, i32 } %ret
}

define { ppc_fp128, i32} @canonicalize_noncanonical_zero_1_ppcf128() {
; CHECK-LABEL: define { ppc_fp128, i32 } @canonicalize_noncanonical_zero_1_ppcf128() {
; CHECK-NEXT:    ret { ppc_fp128, i32 } { ppc_fp128 0xM00000000000000000000000000000001, i32 0 }
;
  %ret = call { ppc_fp128, i32 } @llvm.frexp.ppcf128.i32(ppc_fp128 0xM00000000000000000000000000000001)
  ret { ppc_fp128, i32 } %ret
}

define { <2 x float>, <2 x i32> } @frexp_splat_4() {
; CHECK-LABEL: define { <2 x float>, <2 x i32> } @frexp_splat_4() {
; CHECK-NEXT:    ret { <2 x float>, <2 x i32> } { <2 x float> splat (float 5.000000e-01), <2 x i32> splat (i32 3) }
;
  %ret = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> <float 4.0, float 4.0>)
  ret { <2 x float>, <2 x i32> } %ret
}

define { <2 x float>, <2 x i32> } @frexp_splat_qnan() {
; CHECK-LABEL: define { <2 x float>, <2 x i32> } @frexp_splat_qnan() {
; CHECK-NEXT:    ret { <2 x float>, <2 x i32> } { <2 x float> splat (float 0x7FF8000000000000), <2 x i32> zeroinitializer }
;
  %ret = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> <float 0x7FF8000000000000, float 0x7FF8000000000000>)
  ret { <2 x float>, <2 x i32> } %ret
}

define { <2 x float>, <2 x i32> } @frexp_splat_inf() {
; CHECK-LABEL: define { <2 x float>, <2 x i32> } @frexp_splat_inf() {
; CHECK-NEXT:    ret { <2 x float>, <2 x i32> } { <2 x float> splat (float 0x7FF0000000000000), <2 x i32> zeroinitializer }
;
  %ret = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> <float 0x7FF0000000000000, float 0x7FF0000000000000>)
  ret { <2 x float>, <2 x i32> } %ret
}

define { <2 x float>, <2 x i32> } @frexp_splat_neginf() {
; CHECK-LABEL: define { <2 x float>, <2 x i32> } @frexp_splat_neginf() {
; CHECK-NEXT:    ret { <2 x float>, <2 x i32> } { <2 x float> splat (float 0xFFF0000000000000), <2 x i32> zeroinitializer }
;
  %ret = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> <float 0xFFF0000000000000, float 0xFFF0000000000000>)
  ret { <2 x float>, <2 x i32> } %ret
}

define { <2 x float>, <2 x i32> } @frexp_splat_undef_inf() {
; CHECK-LABEL: define { <2 x float>, <2 x i32> } @frexp_splat_undef_inf() {
; CHECK-NEXT:    [[RET:%.*]] = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> <float undef, float 0x7FF0000000000000>)
; CHECK-NEXT:    ret { <2 x float>, <2 x i32> } [[RET]]
;
  %ret = call { <2 x float>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x float> <float undef, float 0x7FF0000000000000>)
  ret { <2 x float>, <2 x i32> } %ret
}
