; ModuleID = 'MicroC'
source_filename = "MicroC"

@fmt = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmt.1 = private unnamed_addr constant [4 x i8] c"%g\0A\00"
@fmt.2 = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@fmt.3 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmt.4 = private unnamed_addr constant [4 x i8] c"%g\0A\00"
@fmt.5 = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@fmt.6 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmt.7 = private unnamed_addr constant [4 x i8] c"%g\0A\00"
@fmt.8 = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@init_arr_bn = global { i32, i32, i32, i32* } zeroinitializer
@fmt.9 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmt.10 = private unnamed_addr constant [4 x i8] c"%g\0A\00"
@fmt.11 = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@.str = private unnamed_addr constant [28 x i8] c"error! arr shape not equal!\00"
@init_arr_bn.12 = global { i32, i32, i32, i32* } zeroinitializer
@fmt.13 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmt.14 = private unnamed_addr constant [4 x i8] c"%g\0A\00"
@fmt.15 = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@init_arr_bn.16 = global { i32, i32, i32, i32* } zeroinitializer
@fmt.17 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmt.18 = private unnamed_addr constant [4 x i8] c"%g\0A\00"
@fmt.19 = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@init_arr_bn.20 = global { i32, i32, i32, i32* } zeroinitializer
@init_arr_bn.21 = global { i32, i32, i32, i32* } zeroinitializer
@init_arr_bn.22 = global { i32, i32, i32, i32* } zeroinitializer
@fmt.23 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmt.24 = private unnamed_addr constant [4 x i8] c"%g\0A\00"
@fmt.25 = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@init_arr_bn.26 = global { i32, i32, i32, i32* } zeroinitializer
@fmt.27 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmt.28 = private unnamed_addr constant [4 x i8] c"%g\0A\00"
@fmt.29 = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@init_arr_bn.30 = global { i32, i32, i32, i32* } zeroinitializer

declare i32 @printf(i8*, ...)

declare { i32, i32, i32, i32* }* @load(i8*)

declare i32 @close({ i32, i32, i32, i32* }*, i32)

declare i32 @save({ i32, i32, i32, i32* }*, i8*)

define i32 @exp(i32 %pow, i32 %num) {
entry:
  %pow1 = alloca i32
  store i32 %pow, i32* %pow1
  %num2 = alloca i32
  store i32 %num, i32* %num2
  %res = alloca i32
  %j = alloca i32
  %j3 = alloca i32
  %res4 = alloca i32
  store i32 1, i32* %res4
  store i32 0, i32* %j3
  br label %while

while:                                            ; preds = %while_body, %entry
  %j9 = load i32, i32* %j3
  %pow10 = load i32, i32* %pow1
  %tmp11 = icmp slt i32 %j9, %pow10
  br i1 %tmp11, label %while_body, label %merge

while_body:                                       ; preds = %while
  %res5 = load i32, i32* %res4
  %num6 = load i32, i32* %num2
  %tmp = mul i32 %res5, %num6
  store i32 %tmp, i32* %res4
  %j7 = load i32, i32* %j3
  %tmp8 = add i32 %j7, 1
  store i32 %tmp8, i32* %j3
  br label %while

merge:                                            ; preds = %while
  %res12 = load i32, i32* %res4
  ret i32 %res12
}

define double @exp2(double %num, i32 %pow) {
entry:
  %num1 = alloca double
  store double %num, double* %num1
  %pow2 = alloca i32
  store i32 %pow, i32* %pow2
  %res = alloca double
  %j = alloca i32
  %j3 = alloca i32
  %res4 = alloca double
  store double 1.000000e+00, double* %res4
  store i32 0, i32* %j3
  br label %while

while:                                            ; preds = %while_body, %entry
  %j9 = load i32, i32* %j3
  %pow10 = load i32, i32* %pow2
  %tmp11 = icmp slt i32 %j9, %pow10
  br i1 %tmp11, label %while_body, label %merge

while_body:                                       ; preds = %while
  %res5 = load double, double* %res4
  %num6 = load double, double* %num1
  %tmp = fmul double %res5, %num6
  store double %tmp, double* %res4
  %j7 = load i32, i32* %j3
  %tmp8 = add i32 %j7, 1
  store i32 %tmp8, i32* %j3
  br label %while

merge:                                            ; preds = %while
  %res12 = load double, double* %res4
  ret double %res12
}

define { i32, i32, i32, i32* }* @transpose({ i32, i32, i32, i32* }* %img) {
entry:
  %img1 = alloca { i32, i32, i32, i32* }*
  store { i32, i32, i32, i32* }* %img, { i32, i32, i32, i32* }** %img1
  %img2 = alloca { i32, i32, i32, i32* }*
  %w = alloca i32
  %o22 = alloca i32
  %o21 = alloca i32
  %o2 = alloca i32
  %o12 = alloca i32
  %o11 = alloca i32
  %o1 = alloca i32
  %len = alloca i32
  %j = alloca i32
  %i = alloca i32
  %h = alloca i32
  %img22 = alloca { i32, i32, i32, i32* }*
  %len3 = alloca i32
  %i4 = alloca i32
  %j5 = alloca i32
  %h6 = alloca i32
  %w7 = alloca i32
  %o18 = alloca i32
  %o29 = alloca i32
  %o1110 = alloca i32
  %o2111 = alloca i32
  %o1212 = alloca i32
  %o2213 = alloca i32
  store i32 1, i32* %len3
  store i32 2, i32* %h6
  store i32 3, i32* %w7
  %len14 = load i32, i32* %len3
  %w15 = load i32, i32* %w7
  %h16 = load i32, i32* %h6
  %mallocsize = mul i32 %len14, ptrtoint (i32* getelementptr (i32, i32* null, i32 1) to i32)
  %malloccall = tail call i8* @malloc(i32 %mallocsize)
  %tmp_bn = bitcast i8* %malloccall to i32*
  store i32 %len14, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn, i32 0, i32 0)
  store i32 %w15, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn, i32 0, i32 1)
  store i32 %h16, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn, i32 0, i32 2)
  store i32* %tmp_bn, i32** getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn, i32 0, i32 3)
  store { i32, i32, i32, i32* }* @init_arr_bn, { i32, i32, i32, i32* }** %img22
  store i32 0, i32* %i4
  br label %while

while:                                            ; preds = %merge, %entry
  %i108 = load i32, i32* %i4
  %h109 = load i32, i32* %h6
  %tmp110 = icmp slt i32 %i108, %h109
  br i1 %tmp110, label %while_body, label %merge111

while_body:                                       ; preds = %while
  store i32 0, i32* %j5
  br label %while17

while17:                                          ; preds = %while_body18, %while_body
  %j103 = load i32, i32* %j5
  %w104 = load i32, i32* %w7
  %tmp105 = icmp slt i32 %j103, %w104
  br i1 %tmp105, label %while_body18, label %merge

while_body18:                                     ; preds = %while17
  %i19 = load i32, i32* %i4
  %w20 = load i32, i32* %w7
  %tmp = mul i32 %i19, %w20
  %j21 = load i32, i32* %j5
  %tmp22 = add i32 %tmp, %j21
  %tmp23 = mul i32 %tmp22, 3
  store i32 %tmp23, i32* %o18
  %j24 = load i32, i32* %j5
  %h25 = load i32, i32* %h6
  %tmp26 = mul i32 %j24, %h25
  %i27 = load i32, i32* %i4
  %tmp28 = add i32 %tmp26, %i27
  %tmp29 = mul i32 %tmp28, 3
  store i32 %tmp29, i32* %o29
  %img30 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp31 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img30, i32 0, i32 2
  %tmp32 = load i32, i32* %tmp31
  %tmp33 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img30, i32 0, i32 1
  %tmp34 = load i32, i32* %tmp33
  %tmp35 = mul i32 %tmp32, %tmp34
  %o136 = load i32, i32* %o18
  %tmp37 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img30, i32 0, i32 3
  %tmp38 = load i32*, i32** %tmp37
  %tmp39 = getelementptr inbounds i32, i32* %tmp38, i32 %o136
  %tmp40 = load i32, i32* %tmp39
  %img241 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img22
  %tmp42 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img241, i32 0, i32 2
  %tmp43 = load i32, i32* %tmp42
  %tmp44 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img241, i32 0, i32 1
  %tmp45 = load i32, i32* %tmp44
  %tmp46 = mul i32 %tmp43, %tmp45
  %o247 = load i32, i32* %o29
  %tmp48 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img241, i32 0, i32 3
  %tmp49 = load i32*, i32** %tmp48
  %tmp50 = getelementptr inbounds i32, i32* %tmp49, i32 %o247
  store i32 %tmp40, i32* %tmp50
  %o251 = load i32, i32* %o29
  %tmp52 = add i32 %o251, 1
  store i32 %tmp52, i32* %o2111
  %o153 = load i32, i32* %o18
  %tmp54 = add i32 %o153, 1
  store i32 %tmp54, i32* %o1110
  %o255 = load i32, i32* %o29
  %tmp56 = add i32 %o255, 2
  store i32 %tmp56, i32* %o2213
  %o157 = load i32, i32* %o18
  %tmp58 = add i32 %o157, 2
  store i32 %tmp58, i32* %o1212
  %img59 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp60 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img59, i32 0, i32 2
  %tmp61 = load i32, i32* %tmp60
  %tmp62 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img59, i32 0, i32 1
  %tmp63 = load i32, i32* %tmp62
  %tmp64 = mul i32 %tmp61, %tmp63
  %o1165 = load i32, i32* %o1110
  %tmp66 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img59, i32 0, i32 3
  %tmp67 = load i32*, i32** %tmp66
  %tmp68 = getelementptr inbounds i32, i32* %tmp67, i32 %o1165
  %tmp69 = load i32, i32* %tmp68
  %img270 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img22
  %tmp71 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img270, i32 0, i32 2
  %tmp72 = load i32, i32* %tmp71
  %tmp73 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img270, i32 0, i32 1
  %tmp74 = load i32, i32* %tmp73
  %tmp75 = mul i32 %tmp72, %tmp74
  %o2176 = load i32, i32* %o2111
  %tmp77 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img270, i32 0, i32 3
  %tmp78 = load i32*, i32** %tmp77
  %tmp79 = getelementptr inbounds i32, i32* %tmp78, i32 %o2176
  store i32 %tmp69, i32* %tmp79
  %img80 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp81 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img80, i32 0, i32 2
  %tmp82 = load i32, i32* %tmp81
  %tmp83 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img80, i32 0, i32 1
  %tmp84 = load i32, i32* %tmp83
  %tmp85 = mul i32 %tmp82, %tmp84
  %o1286 = load i32, i32* %o1212
  %tmp87 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img80, i32 0, i32 3
  %tmp88 = load i32*, i32** %tmp87
  %tmp89 = getelementptr inbounds i32, i32* %tmp88, i32 %o1286
  %tmp90 = load i32, i32* %tmp89
  %img291 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img22
  %tmp92 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img291, i32 0, i32 2
  %tmp93 = load i32, i32* %tmp92
  %tmp94 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img291, i32 0, i32 1
  %tmp95 = load i32, i32* %tmp94
  %tmp96 = mul i32 %tmp93, %tmp95
  %o2297 = load i32, i32* %o2213
  %tmp98 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img291, i32 0, i32 3
  %tmp99 = load i32*, i32** %tmp98
  %tmp100 = getelementptr inbounds i32, i32* %tmp99, i32 %o2297
  store i32 %tmp90, i32* %tmp100
  %j101 = load i32, i32* %j5
  %tmp102 = add i32 %j101, 1
  store i32 %tmp102, i32* %j5
  br label %while17

merge:                                            ; preds = %while17
  %i106 = load i32, i32* %i4
  %tmp107 = add i32 %i106, 1
  store i32 %tmp107, i32* %i4
  br label %while

merge111:                                         ; preds = %while
  %img112 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %close = call i32 @close({ i32, i32, i32, i32* }* %img112, i32 1)
  %img113 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %img2114 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img22
  %tmp_bn115 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img113, i32 0, i32 0
  %tmp_bn116 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img113, i32 0, i32 1
  %tmp_bn117 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img113, i32 0, i32 2
  %tmp_bn118 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img113, i32 0, i32 3
  %tmp_bn119 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2114, i32 0, i32 0
  %tmp_len = load i32, i32* %tmp_bn119
  %tmp_bn120 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2114, i32 0, i32 1
  %tmp_h = load i32, i32* %tmp_bn120
  %tmp_bn121 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2114, i32 0, i32 2
  %tmp_w = load i32, i32* %tmp_bn121
  %tmp_bn122 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2114, i32 0, i32 3
  %tmp_img = load i32*, i32** %tmp_bn122
  store i32 %tmp_len, i32* %tmp_bn115
  store i32 %tmp_h, i32* %tmp_bn116
  store i32 %tmp_w, i32* %tmp_bn117
  store i32* %tmp_img, i32** %tmp_bn118
  %img123 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  ret { i32, i32, i32, i32* }* %img123
}

define { i32, i32, i32, i32* }* @mtimes({ i32, i32, i32, i32* }* %img2, { i32, i32, i32, i32* }* %img1) {
entry:
  %img21 = alloca { i32, i32, i32, i32* }*
  store { i32, i32, i32, i32* }* %img2, { i32, i32, i32, i32* }** %img21
  %img12 = alloca { i32, i32, i32, i32* }*
  store { i32, i32, i32, i32* }* %img1, { i32, i32, i32, i32* }** %img12
  %img3 = alloca { i32, i32, i32, i32* }*
  %w = alloca i32
  %l2 = alloca i32
  %l1 = alloca i32
  %i = alloca i32
  %h = alloca i32
  %i3 = alloca i32
  %l14 = alloca i32
  %l25 = alloca i32
  %h6 = alloca i32
  %w7 = alloca i32
  %img38 = alloca { i32, i32, i32, i32* }*
  %img19 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img12
  %tmp_bn = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img19, i32 0, i32 0
  %tmp_bn10 = load i32, i32* %tmp_bn
  store i32 %tmp_bn10, i32* %l14
  %img211 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img21
  %tmp_bn12 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img211, i32 0, i32 0
  %tmp_bn13 = load i32, i32* %tmp_bn12
  store i32 %tmp_bn13, i32* %l25
  %img114 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img12
  %tmp_bn15 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img114, i32 0, i32 1
  %tmp_bn16 = load i32, i32* %tmp_bn15
  store i32 %tmp_bn16, i32* %h6
  %img117 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img12
  %tmp_bn18 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img117, i32 0, i32 2
  %tmp_bn19 = load i32, i32* %tmp_bn18
  store i32 %tmp_bn19, i32* %w7
  %h20 = load i32, i32* %h6
  %img221 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img21
  %tmp_bn22 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img221, i32 0, i32 1
  %tmp_bn23 = load i32, i32* %tmp_bn22
  %tmp = icmp ne i32 %h20, %tmp_bn23
  %w24 = load i32, i32* %w7
  %img225 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img21
  %tmp_bn26 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img225, i32 0, i32 2
  %tmp_bn27 = load i32, i32* %tmp_bn26
  %tmp28 = icmp ne i32 %w24, %tmp_bn27
  %tmp29 = or i1 %tmp, %tmp28
  br i1 %tmp29, label %then, label %else

merge:                                            ; preds = %else
  %l131 = load i32, i32* %l14
  %h32 = load i32, i32* %h6
  %w33 = load i32, i32* %w7
  %mallocsize = mul i32 %l131, ptrtoint (i32* getelementptr (i32, i32* null, i32 1) to i32)
  %malloccall = tail call i8* @malloc(i32 %mallocsize)
  %tmp_bn34 = bitcast i8* %malloccall to i32*
  store i32 %l131, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.12, i32 0, i32 0)
  store i32 %h32, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.12, i32 0, i32 1)
  store i32 %w33, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.12, i32 0, i32 2)
  store i32* %tmp_bn34, i32** getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.12, i32 0, i32 3)
  store { i32, i32, i32, i32* }* @init_arr_bn.12, { i32, i32, i32, i32* }** %img38
  store i32 0, i32* %i3
  br label %while

then:                                             ; preds = %entry
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @fmt.11, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str, i32 0, i32 0))
  %img130 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img12
  ret { i32, i32, i32, i32* }* %img130

else:                                             ; preds = %entry
  br label %merge

while:                                            ; preds = %while_body, %merge
  %i70 = load i32, i32* %i3
  %l171 = load i32, i32* %l14
  %tmp72 = icmp slt i32 %i70, %l171
  br i1 %tmp72, label %while_body, label %merge73

while_body:                                       ; preds = %while
  %img135 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img12
  %tmp36 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img135, i32 0, i32 2
  %tmp37 = load i32, i32* %tmp36
  %tmp38 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img135, i32 0, i32 1
  %tmp39 = load i32, i32* %tmp38
  %tmp40 = mul i32 %tmp37, %tmp39
  %i41 = load i32, i32* %i3
  %tmp42 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img135, i32 0, i32 3
  %tmp43 = load i32*, i32** %tmp42
  %tmp44 = getelementptr inbounds i32, i32* %tmp43, i32 %i41
  %tmp45 = load i32, i32* %tmp44
  %img246 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img21
  %tmp47 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img246, i32 0, i32 2
  %tmp48 = load i32, i32* %tmp47
  %tmp49 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img246, i32 0, i32 1
  %tmp50 = load i32, i32* %tmp49
  %tmp51 = mul i32 %tmp48, %tmp50
  %i52 = load i32, i32* %i3
  %tmp53 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img246, i32 0, i32 3
  %tmp54 = load i32*, i32** %tmp53
  %tmp55 = getelementptr inbounds i32, i32* %tmp54, i32 %i52
  %tmp56 = load i32, i32* %tmp55
  %tmp57 = mul i32 %tmp45, %tmp56
  %img358 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img38
  %tmp59 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img358, i32 0, i32 2
  %tmp60 = load i32, i32* %tmp59
  %tmp61 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img358, i32 0, i32 1
  %tmp62 = load i32, i32* %tmp61
  %tmp63 = mul i32 %tmp60, %tmp62
  %i64 = load i32, i32* %i3
  %tmp65 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img358, i32 0, i32 3
  %tmp66 = load i32*, i32** %tmp65
  %tmp67 = getelementptr inbounds i32, i32* %tmp66, i32 %i64
  store i32 %tmp57, i32* %tmp67
  %i68 = load i32, i32* %i3
  %tmp69 = add i32 %i68, 1
  store i32 %tmp69, i32* %i3
  br label %while

merge73:                                          ; preds = %while
  %img374 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img38
  ret { i32, i32, i32, i32* }* %img374
}

define { i32, i32, i32, i32* }* @collage({ i32, i32, i32, i32* }* %img2, { i32, i32, i32, i32* }* %img1) {
entry:
  %img21 = alloca { i32, i32, i32, i32* }*
  store { i32, i32, i32, i32* }* %img2, { i32, i32, i32, i32* }** %img21
  %img12 = alloca { i32, i32, i32, i32* }*
  store { i32, i32, i32, i32* }* %img1, { i32, i32, i32, i32* }** %img12
  %img3 = alloca { i32, i32, i32, i32* }*
  %len2 = alloca i32
  %len1 = alloca i32
  %j = alloca i32
  %i = alloca i32
  %img33 = alloca { i32, i32, i32, i32* }*
  %i4 = alloca i32
  %j5 = alloca i32
  %len16 = alloca i32
  %len27 = alloca i32
  %img18 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img12
  %tmp_bn = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img18, i32 0, i32 0
  %tmp_bn9 = load i32, i32* %tmp_bn
  store i32 %tmp_bn9, i32* %len16
  %img210 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img21
  %tmp_bn11 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img210, i32 0, i32 0
  %tmp_bn12 = load i32, i32* %tmp_bn11
  store i32 %tmp_bn12, i32* %len27
  %img113 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img12
  %tmp_bn14 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img113, i32 0, i32 0
  %tmp_bn15 = load i32, i32* %tmp_bn14
  %img216 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img21
  %tmp_bn17 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img216, i32 0, i32 0
  %tmp_bn18 = load i32, i32* %tmp_bn17
  %tmp = add i32 %tmp_bn15, %tmp_bn18
  %img119 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img12
  %tmp_bn20 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img119, i32 0, i32 1
  %tmp_bn21 = load i32, i32* %tmp_bn20
  %img222 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img21
  %tmp_bn23 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img222, i32 0, i32 1
  %tmp_bn24 = load i32, i32* %tmp_bn23
  %tmp25 = add i32 %tmp_bn21, %tmp_bn24
  %img126 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img12
  %tmp_bn27 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img126, i32 0, i32 2
  %tmp_bn28 = load i32, i32* %tmp_bn27
  %mallocsize = mul i32 %tmp, ptrtoint (i32* getelementptr (i32, i32* null, i32 1) to i32)
  %malloccall = tail call i8* @malloc(i32 %mallocsize)
  %tmp_bn29 = bitcast i8* %malloccall to i32*
  store i32 %tmp, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.16, i32 0, i32 0)
  store i32 %tmp25, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.16, i32 0, i32 1)
  store i32 %tmp_bn28, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.16, i32 0, i32 2)
  store i32* %tmp_bn29, i32** getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.16, i32 0, i32 3)
  store { i32, i32, i32, i32* }* @init_arr_bn.16, { i32, i32, i32, i32* }** %img33
  store i32 0, i32* %i4
  br label %while

while:                                            ; preds = %while_body, %entry
  %i53 = load i32, i32* %i4
  %len154 = load i32, i32* %len16
  %tmp55 = icmp slt i32 %i53, %len154
  br i1 %tmp55, label %while_body, label %merge

while_body:                                       ; preds = %while
  %img130 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img12
  %tmp31 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img130, i32 0, i32 2
  %tmp32 = load i32, i32* %tmp31
  %tmp33 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img130, i32 0, i32 1
  %tmp34 = load i32, i32* %tmp33
  %tmp35 = mul i32 %tmp32, %tmp34
  %i36 = load i32, i32* %i4
  %tmp37 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img130, i32 0, i32 3
  %tmp38 = load i32*, i32** %tmp37
  %tmp39 = getelementptr inbounds i32, i32* %tmp38, i32 %i36
  %tmp40 = load i32, i32* %tmp39
  %img341 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img33
  %tmp42 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img341, i32 0, i32 2
  %tmp43 = load i32, i32* %tmp42
  %tmp44 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img341, i32 0, i32 1
  %tmp45 = load i32, i32* %tmp44
  %tmp46 = mul i32 %tmp43, %tmp45
  %i47 = load i32, i32* %i4
  %tmp48 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img341, i32 0, i32 3
  %tmp49 = load i32*, i32** %tmp48
  %tmp50 = getelementptr inbounds i32, i32* %tmp49, i32 %i47
  store i32 %tmp40, i32* %tmp50
  %i51 = load i32, i32* %i4
  %tmp52 = add i32 %i51, 1
  store i32 %tmp52, i32* %i4
  br label %while

merge:                                            ; preds = %while
  store i32 0, i32* %i4
  br label %while56

while56:                                          ; preds = %while_body57, %merge
  %i83 = load i32, i32* %i4
  %len284 = load i32, i32* %len27
  %tmp85 = icmp slt i32 %i83, %len284
  br i1 %tmp85, label %while_body57, label %merge86

while_body57:                                     ; preds = %while56
  %img258 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img21
  %tmp59 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img258, i32 0, i32 2
  %tmp60 = load i32, i32* %tmp59
  %tmp61 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img258, i32 0, i32 1
  %tmp62 = load i32, i32* %tmp61
  %tmp63 = mul i32 %tmp60, %tmp62
  %i64 = load i32, i32* %i4
  %tmp65 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img258, i32 0, i32 3
  %tmp66 = load i32*, i32** %tmp65
  %tmp67 = getelementptr inbounds i32, i32* %tmp66, i32 %i64
  %tmp68 = load i32, i32* %tmp67
  %img369 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img33
  %tmp70 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img369, i32 0, i32 2
  %tmp71 = load i32, i32* %tmp70
  %tmp72 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img369, i32 0, i32 1
  %tmp73 = load i32, i32* %tmp72
  %tmp74 = mul i32 %tmp71, %tmp73
  %len175 = load i32, i32* %len16
  %i76 = load i32, i32* %i4
  %tmp77 = add i32 %len175, %i76
  %tmp78 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img369, i32 0, i32 3
  %tmp79 = load i32*, i32** %tmp78
  %tmp80 = getelementptr inbounds i32, i32* %tmp79, i32 %tmp77
  store i32 %tmp68, i32* %tmp80
  %i81 = load i32, i32* %i4
  %tmp82 = add i32 %i81, 1
  store i32 %tmp82, i32* %i4
  br label %while56

merge86:                                          ; preds = %while56
  %img387 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img33
  ret { i32, i32, i32, i32* }* %img387
}

define void @rotate({ i32, i32, i32, i32* }* %img, i32 %angle) {
entry:
  %img1 = alloca { i32, i32, i32, i32* }*
  store { i32, i32, i32, i32* }* %img, { i32, i32, i32, i32* }** %img1
  %angle2 = alloca i32
  store i32 %angle, i32* %angle2
  %img2 = alloca { i32, i32, i32, i32* }*
  %w = alloca i32
  %o22 = alloca i32
  %o21 = alloca i32
  %o2 = alloca i32
  %o12 = alloca i32
  %o11 = alloca i32
  %o1 = alloca i32
  %len = alloca i32
  %j = alloca i32
  %i = alloca i32
  %h = alloca i32
  %len3 = alloca i32
  %i4 = alloca i32
  %j5 = alloca i32
  %h6 = alloca i32
  %w7 = alloca i32
  %o18 = alloca i32
  %o29 = alloca i32
  %o1110 = alloca i32
  %o1211 = alloca i32
  %o2112 = alloca i32
  %o2213 = alloca i32
  %img214 = alloca { i32, i32, i32, i32* }*
  %img15 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp_bn = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img15, i32 0, i32 0
  %tmp_bn16 = load i32, i32* %tmp_bn
  store i32 %tmp_bn16, i32* %len3
  %img17 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp_bn18 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img17, i32 0, i32 1
  %tmp_bn19 = load i32, i32* %tmp_bn18
  store i32 %tmp_bn19, i32* %h6
  %img20 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp_bn21 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img20, i32 0, i32 2
  %tmp_bn22 = load i32, i32* %tmp_bn21
  store i32 %tmp_bn22, i32* %w7
  %angle23 = load i32, i32* %angle2
  %tmp = icmp eq i32 %angle23, 180
  br i1 %tmp, label %then, label %else

merge:                                            ; preds = %merge116, %merge113
  %img338 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %close = call i32 @close({ i32, i32, i32, i32* }* %img338, i32 1)
  %img339 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %img2340 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img214
  %tmp_bn341 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img339, i32 0, i32 0
  %tmp_bn342 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img339, i32 0, i32 1
  %tmp_bn343 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img339, i32 0, i32 2
  %tmp_bn344 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img339, i32 0, i32 3
  %tmp_bn345 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2340, i32 0, i32 0
  %tmp_len = load i32, i32* %tmp_bn345
  %tmp_bn346 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2340, i32 0, i32 1
  %tmp_h = load i32, i32* %tmp_bn346
  %tmp_bn347 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2340, i32 0, i32 2
  %tmp_w = load i32, i32* %tmp_bn347
  %tmp_bn348 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2340, i32 0, i32 3
  %tmp_img = load i32*, i32** %tmp_bn348
  store i32 %tmp_len, i32* %tmp_bn341
  store i32 %tmp_h, i32* %tmp_bn342
  store i32 %tmp_w, i32* %tmp_bn343
  store i32* %tmp_img, i32** %tmp_bn344
  ret void

then:                                             ; preds = %entry
  %len24 = load i32, i32* %len3
  %h25 = load i32, i32* %h6
  %w26 = load i32, i32* %w7
  %mallocsize = mul i32 %len24, ptrtoint (i32* getelementptr (i32, i32* null, i32 1) to i32)
  %malloccall = tail call i8* @malloc(i32 %mallocsize)
  %tmp_bn27 = bitcast i8* %malloccall to i32*
  store i32 %len24, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.20, i32 0, i32 0)
  store i32 %h25, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.20, i32 0, i32 1)
  store i32 %w26, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.20, i32 0, i32 2)
  store i32* %tmp_bn27, i32** getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.20, i32 0, i32 3)
  store { i32, i32, i32, i32* }* @init_arr_bn.20, { i32, i32, i32, i32* }** %img214
  store i32 0, i32* %i4
  br label %while

while:                                            ; preds = %while_body, %then
  %i108 = load i32, i32* %i4
  %tmp109 = mul i32 %i108, 3
  %tmp110 = add i32 %tmp109, 2
  %len111 = load i32, i32* %len3
  %tmp112 = icmp slt i32 %tmp110, %len111
  br i1 %tmp112, label %while_body, label %merge113

while_body:                                       ; preds = %while
  %i28 = load i32, i32* %i4
  %tmp29 = mul i32 %i28, 3
  store i32 %tmp29, i32* %o18
  %len30 = load i32, i32* %len3
  %i31 = load i32, i32* %i4
  %tmp32 = add i32 %i31, 1
  %tmp33 = mul i32 %tmp32, 3
  %tmp34 = sub i32 %len30, %tmp33
  store i32 %tmp34, i32* %o29
  %o135 = load i32, i32* %o18
  %tmp36 = add i32 %o135, 1
  store i32 %tmp36, i32* %o1110
  %o237 = load i32, i32* %o29
  %tmp38 = add i32 %o237, 1
  store i32 %tmp38, i32* %o2112
  %o139 = load i32, i32* %o18
  %tmp40 = add i32 %o139, 2
  store i32 %tmp40, i32* %o1211
  %o241 = load i32, i32* %o29
  %tmp42 = add i32 %o241, 2
  store i32 %tmp42, i32* %o2213
  %img43 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp44 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img43, i32 0, i32 2
  %tmp45 = load i32, i32* %tmp44
  %tmp46 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img43, i32 0, i32 1
  %tmp47 = load i32, i32* %tmp46
  %tmp48 = mul i32 %tmp45, %tmp47
  %o249 = load i32, i32* %o29
  %tmp50 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img43, i32 0, i32 3
  %tmp51 = load i32*, i32** %tmp50
  %tmp52 = getelementptr inbounds i32, i32* %tmp51, i32 %o249
  %tmp53 = load i32, i32* %tmp52
  %img254 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img214
  %tmp55 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img254, i32 0, i32 2
  %tmp56 = load i32, i32* %tmp55
  %tmp57 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img254, i32 0, i32 1
  %tmp58 = load i32, i32* %tmp57
  %tmp59 = mul i32 %tmp56, %tmp58
  %o160 = load i32, i32* %o18
  %tmp61 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img254, i32 0, i32 3
  %tmp62 = load i32*, i32** %tmp61
  %tmp63 = getelementptr inbounds i32, i32* %tmp62, i32 %o160
  store i32 %tmp53, i32* %tmp63
  %img64 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp65 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img64, i32 0, i32 2
  %tmp66 = load i32, i32* %tmp65
  %tmp67 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img64, i32 0, i32 1
  %tmp68 = load i32, i32* %tmp67
  %tmp69 = mul i32 %tmp66, %tmp68
  %o2170 = load i32, i32* %o2112
  %tmp71 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img64, i32 0, i32 3
  %tmp72 = load i32*, i32** %tmp71
  %tmp73 = getelementptr inbounds i32, i32* %tmp72, i32 %o2170
  %tmp74 = load i32, i32* %tmp73
  %img275 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img214
  %tmp76 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img275, i32 0, i32 2
  %tmp77 = load i32, i32* %tmp76
  %tmp78 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img275, i32 0, i32 1
  %tmp79 = load i32, i32* %tmp78
  %tmp80 = mul i32 %tmp77, %tmp79
  %o1181 = load i32, i32* %o1110
  %tmp82 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img275, i32 0, i32 3
  %tmp83 = load i32*, i32** %tmp82
  %tmp84 = getelementptr inbounds i32, i32* %tmp83, i32 %o1181
  store i32 %tmp74, i32* %tmp84
  %img85 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp86 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img85, i32 0, i32 2
  %tmp87 = load i32, i32* %tmp86
  %tmp88 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img85, i32 0, i32 1
  %tmp89 = load i32, i32* %tmp88
  %tmp90 = mul i32 %tmp87, %tmp89
  %o2291 = load i32, i32* %o2213
  %tmp92 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img85, i32 0, i32 3
  %tmp93 = load i32*, i32** %tmp92
  %tmp94 = getelementptr inbounds i32, i32* %tmp93, i32 %o2291
  %tmp95 = load i32, i32* %tmp94
  %img296 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img214
  %tmp97 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img296, i32 0, i32 2
  %tmp98 = load i32, i32* %tmp97
  %tmp99 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img296, i32 0, i32 1
  %tmp100 = load i32, i32* %tmp99
  %tmp101 = mul i32 %tmp98, %tmp100
  %o12102 = load i32, i32* %o1211
  %tmp103 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img296, i32 0, i32 3
  %tmp104 = load i32*, i32** %tmp103
  %tmp105 = getelementptr inbounds i32, i32* %tmp104, i32 %o12102
  store i32 %tmp95, i32* %tmp105
  %i106 = load i32, i32* %i4
  %tmp107 = add i32 %i106, 1
  store i32 %tmp107, i32* %i4
  br label %while

merge113:                                         ; preds = %while
  br label %merge

else:                                             ; preds = %entry
  %angle114 = load i32, i32* %angle2
  %tmp115 = icmp eq i32 %angle114, 90
  br i1 %tmp115, label %then117, label %else225

merge116:                                         ; preds = %merge228, %merge224
  br label %merge

then117:                                          ; preds = %else
  %len118 = load i32, i32* %len3
  %w119 = load i32, i32* %w7
  %h120 = load i32, i32* %h6
  %mallocsize121 = mul i32 %len118, ptrtoint (i32* getelementptr (i32, i32* null, i32 1) to i32)
  %malloccall122 = tail call i8* @malloc(i32 %mallocsize121)
  %tmp_bn123 = bitcast i8* %malloccall122 to i32*
  store i32 %len118, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.21, i32 0, i32 0)
  store i32 %w119, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.21, i32 0, i32 1)
  store i32 %h120, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.21, i32 0, i32 2)
  store i32* %tmp_bn123, i32** getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.21, i32 0, i32 3)
  store { i32, i32, i32, i32* }* @init_arr_bn.21, { i32, i32, i32, i32* }** %img214
  store i32 0, i32* %i4
  br label %while124

while124:                                         ; preds = %merge218, %then117
  %i221 = load i32, i32* %i4
  %h222 = load i32, i32* %h6
  %tmp223 = icmp slt i32 %i221, %h222
  br i1 %tmp223, label %while_body125, label %merge224

while_body125:                                    ; preds = %while124
  store i32 0, i32* %j5
  br label %while126

while126:                                         ; preds = %while_body127, %while_body125
  %j215 = load i32, i32* %j5
  %w216 = load i32, i32* %w7
  %tmp217 = icmp slt i32 %j215, %w216
  br i1 %tmp217, label %while_body127, label %merge218

while_body127:                                    ; preds = %while126
  %i128 = load i32, i32* %i4
  %w129 = load i32, i32* %w7
  %tmp130 = mul i32 %i128, %w129
  %j131 = load i32, i32* %j5
  %tmp132 = add i32 %tmp130, %j131
  %tmp133 = mul i32 %tmp132, 3
  store i32 %tmp133, i32* %o18
  %j134 = load i32, i32* %j5
  %h135 = load i32, i32* %h6
  %tmp136 = mul i32 %j134, %h135
  %h137 = load i32, i32* %h6
  %i138 = load i32, i32* %i4
  %tmp139 = sub i32 %h137, %i138
  %tmp140 = add i32 %tmp136, %tmp139
  %tmp141 = mul i32 %tmp140, 3
  store i32 %tmp141, i32* %o29
  %o1142 = load i32, i32* %o18
  %tmp143 = add i32 %o1142, 1
  store i32 %tmp143, i32* %o1110
  %o2144 = load i32, i32* %o29
  %tmp145 = add i32 %o2144, 1
  store i32 %tmp145, i32* %o2112
  %o1146 = load i32, i32* %o18
  %tmp147 = add i32 %o1146, 2
  store i32 %tmp147, i32* %o1211
  %o2148 = load i32, i32* %o29
  %tmp149 = add i32 %o2148, 2
  store i32 %tmp149, i32* %o2213
  %img150 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp151 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img150, i32 0, i32 2
  %tmp152 = load i32, i32* %tmp151
  %tmp153 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img150, i32 0, i32 1
  %tmp154 = load i32, i32* %tmp153
  %tmp155 = mul i32 %tmp152, %tmp154
  %o1156 = load i32, i32* %o18
  %tmp157 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img150, i32 0, i32 3
  %tmp158 = load i32*, i32** %tmp157
  %tmp159 = getelementptr inbounds i32, i32* %tmp158, i32 %o1156
  %tmp160 = load i32, i32* %tmp159
  %img2161 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img214
  %tmp162 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2161, i32 0, i32 2
  %tmp163 = load i32, i32* %tmp162
  %tmp164 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2161, i32 0, i32 1
  %tmp165 = load i32, i32* %tmp164
  %tmp166 = mul i32 %tmp163, %tmp165
  %o2167 = load i32, i32* %o29
  %tmp168 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2161, i32 0, i32 3
  %tmp169 = load i32*, i32** %tmp168
  %tmp170 = getelementptr inbounds i32, i32* %tmp169, i32 %o2167
  store i32 %tmp160, i32* %tmp170
  %img171 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp172 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img171, i32 0, i32 2
  %tmp173 = load i32, i32* %tmp172
  %tmp174 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img171, i32 0, i32 1
  %tmp175 = load i32, i32* %tmp174
  %tmp176 = mul i32 %tmp173, %tmp175
  %o11177 = load i32, i32* %o1110
  %tmp178 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img171, i32 0, i32 3
  %tmp179 = load i32*, i32** %tmp178
  %tmp180 = getelementptr inbounds i32, i32* %tmp179, i32 %o11177
  %tmp181 = load i32, i32* %tmp180
  %img2182 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img214
  %tmp183 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2182, i32 0, i32 2
  %tmp184 = load i32, i32* %tmp183
  %tmp185 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2182, i32 0, i32 1
  %tmp186 = load i32, i32* %tmp185
  %tmp187 = mul i32 %tmp184, %tmp186
  %o21188 = load i32, i32* %o2112
  %tmp189 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2182, i32 0, i32 3
  %tmp190 = load i32*, i32** %tmp189
  %tmp191 = getelementptr inbounds i32, i32* %tmp190, i32 %o21188
  store i32 %tmp181, i32* %tmp191
  %img192 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp193 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img192, i32 0, i32 2
  %tmp194 = load i32, i32* %tmp193
  %tmp195 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img192, i32 0, i32 1
  %tmp196 = load i32, i32* %tmp195
  %tmp197 = mul i32 %tmp194, %tmp196
  %o12198 = load i32, i32* %o1211
  %tmp199 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img192, i32 0, i32 3
  %tmp200 = load i32*, i32** %tmp199
  %tmp201 = getelementptr inbounds i32, i32* %tmp200, i32 %o12198
  %tmp202 = load i32, i32* %tmp201
  %img2203 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img214
  %tmp204 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2203, i32 0, i32 2
  %tmp205 = load i32, i32* %tmp204
  %tmp206 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2203, i32 0, i32 1
  %tmp207 = load i32, i32* %tmp206
  %tmp208 = mul i32 %tmp205, %tmp207
  %o22209 = load i32, i32* %o2213
  %tmp210 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2203, i32 0, i32 3
  %tmp211 = load i32*, i32** %tmp210
  %tmp212 = getelementptr inbounds i32, i32* %tmp211, i32 %o22209
  store i32 %tmp202, i32* %tmp212
  %j213 = load i32, i32* %j5
  %tmp214 = add i32 %j213, 1
  store i32 %tmp214, i32* %j5
  br label %while126

merge218:                                         ; preds = %while126
  %i219 = load i32, i32* %i4
  %tmp220 = add i32 %i219, 1
  store i32 %tmp220, i32* %i4
  br label %while124

merge224:                                         ; preds = %while124
  br label %merge116

else225:                                          ; preds = %else
  %angle226 = load i32, i32* %angle2
  %tmp227 = icmp eq i32 %angle226, -90
  br i1 %tmp227, label %then229, label %else337

merge228:                                         ; preds = %else337, %merge336
  br label %merge116

then229:                                          ; preds = %else225
  %len230 = load i32, i32* %len3
  %w231 = load i32, i32* %w7
  %h232 = load i32, i32* %h6
  %mallocsize233 = mul i32 %len230, ptrtoint (i32* getelementptr (i32, i32* null, i32 1) to i32)
  %malloccall234 = tail call i8* @malloc(i32 %mallocsize233)
  %tmp_bn235 = bitcast i8* %malloccall234 to i32*
  store i32 %len230, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.22, i32 0, i32 0)
  store i32 %w231, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.22, i32 0, i32 1)
  store i32 %h232, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.22, i32 0, i32 2)
  store i32* %tmp_bn235, i32** getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.22, i32 0, i32 3)
  store { i32, i32, i32, i32* }* @init_arr_bn.22, { i32, i32, i32, i32* }** %img214
  store i32 0, i32* %i4
  br label %while236

while236:                                         ; preds = %merge330, %then229
  %i333 = load i32, i32* %i4
  %h334 = load i32, i32* %h6
  %tmp335 = icmp slt i32 %i333, %h334
  br i1 %tmp335, label %while_body237, label %merge336

while_body237:                                    ; preds = %while236
  store i32 0, i32* %j5
  br label %while238

while238:                                         ; preds = %while_body239, %while_body237
  %j327 = load i32, i32* %j5
  %w328 = load i32, i32* %w7
  %tmp329 = icmp slt i32 %j327, %w328
  br i1 %tmp329, label %while_body239, label %merge330

while_body239:                                    ; preds = %while238
  %i240 = load i32, i32* %i4
  %w241 = load i32, i32* %w7
  %tmp242 = mul i32 %i240, %w241
  %j243 = load i32, i32* %j5
  %tmp244 = add i32 %tmp242, %j243
  %tmp245 = mul i32 %tmp244, 3
  store i32 %tmp245, i32* %o18
  %w246 = load i32, i32* %w7
  %j247 = load i32, i32* %j5
  %tmp248 = sub i32 %w246, %j247
  %h249 = load i32, i32* %h6
  %tmp250 = mul i32 %tmp248, %h249
  %i251 = load i32, i32* %i4
  %tmp252 = add i32 %tmp250, %i251
  %tmp253 = mul i32 %tmp252, 3
  store i32 %tmp253, i32* %o29
  %o1254 = load i32, i32* %o18
  %tmp255 = add i32 %o1254, 1
  store i32 %tmp255, i32* %o1110
  %o2256 = load i32, i32* %o29
  %tmp257 = add i32 %o2256, 1
  store i32 %tmp257, i32* %o2112
  %o1258 = load i32, i32* %o18
  %tmp259 = add i32 %o1258, 2
  store i32 %tmp259, i32* %o1211
  %o2260 = load i32, i32* %o29
  %tmp261 = add i32 %o2260, 2
  store i32 %tmp261, i32* %o2213
  %img262 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp263 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img262, i32 0, i32 2
  %tmp264 = load i32, i32* %tmp263
  %tmp265 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img262, i32 0, i32 1
  %tmp266 = load i32, i32* %tmp265
  %tmp267 = mul i32 %tmp264, %tmp266
  %o1268 = load i32, i32* %o18
  %tmp269 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img262, i32 0, i32 3
  %tmp270 = load i32*, i32** %tmp269
  %tmp271 = getelementptr inbounds i32, i32* %tmp270, i32 %o1268
  %tmp272 = load i32, i32* %tmp271
  %img2273 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img214
  %tmp274 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2273, i32 0, i32 2
  %tmp275 = load i32, i32* %tmp274
  %tmp276 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2273, i32 0, i32 1
  %tmp277 = load i32, i32* %tmp276
  %tmp278 = mul i32 %tmp275, %tmp277
  %o2279 = load i32, i32* %o29
  %tmp280 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2273, i32 0, i32 3
  %tmp281 = load i32*, i32** %tmp280
  %tmp282 = getelementptr inbounds i32, i32* %tmp281, i32 %o2279
  store i32 %tmp272, i32* %tmp282
  %img283 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp284 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img283, i32 0, i32 2
  %tmp285 = load i32, i32* %tmp284
  %tmp286 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img283, i32 0, i32 1
  %tmp287 = load i32, i32* %tmp286
  %tmp288 = mul i32 %tmp285, %tmp287
  %o11289 = load i32, i32* %o1110
  %tmp290 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img283, i32 0, i32 3
  %tmp291 = load i32*, i32** %tmp290
  %tmp292 = getelementptr inbounds i32, i32* %tmp291, i32 %o11289
  %tmp293 = load i32, i32* %tmp292
  %img2294 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img214
  %tmp295 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2294, i32 0, i32 2
  %tmp296 = load i32, i32* %tmp295
  %tmp297 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2294, i32 0, i32 1
  %tmp298 = load i32, i32* %tmp297
  %tmp299 = mul i32 %tmp296, %tmp298
  %o21300 = load i32, i32* %o2112
  %tmp301 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2294, i32 0, i32 3
  %tmp302 = load i32*, i32** %tmp301
  %tmp303 = getelementptr inbounds i32, i32* %tmp302, i32 %o21300
  store i32 %tmp293, i32* %tmp303
  %img304 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp305 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img304, i32 0, i32 2
  %tmp306 = load i32, i32* %tmp305
  %tmp307 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img304, i32 0, i32 1
  %tmp308 = load i32, i32* %tmp307
  %tmp309 = mul i32 %tmp306, %tmp308
  %o12310 = load i32, i32* %o1211
  %tmp311 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img304, i32 0, i32 3
  %tmp312 = load i32*, i32** %tmp311
  %tmp313 = getelementptr inbounds i32, i32* %tmp312, i32 %o12310
  %tmp314 = load i32, i32* %tmp313
  %img2315 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img214
  %tmp316 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2315, i32 0, i32 2
  %tmp317 = load i32, i32* %tmp316
  %tmp318 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2315, i32 0, i32 1
  %tmp319 = load i32, i32* %tmp318
  %tmp320 = mul i32 %tmp317, %tmp319
  %o22321 = load i32, i32* %o2213
  %tmp322 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2315, i32 0, i32 3
  %tmp323 = load i32*, i32** %tmp322
  %tmp324 = getelementptr inbounds i32, i32* %tmp323, i32 %o22321
  store i32 %tmp314, i32* %tmp324
  %j325 = load i32, i32* %j5
  %tmp326 = add i32 %j325, 1
  store i32 %tmp326, i32* %j5
  br label %while238

merge330:                                         ; preds = %while238
  %i331 = load i32, i32* %i4
  %tmp332 = add i32 %i331, 1
  store i32 %tmp332, i32* %i4
  br label %while236

merge336:                                         ; preds = %while236
  br label %merge228

else337:                                          ; preds = %else225
  br label %merge228
}

define void @scifi_filter({ i32, i32, i32, i32* }* %img) {
entry:
  %img1 = alloca { i32, i32, i32, i32* }*
  store { i32, i32, i32, i32* }* %img, { i32, i32, i32, i32* }** %img1
  %img2 = alloca { i32, i32, i32, i32* }*
  %o = alloca i32
  %len = alloca i32
  %i = alloca i32
  %len2 = alloca i32
  %i3 = alloca i32
  %img24 = alloca { i32, i32, i32, i32* }*
  %o5 = alloca i32
  %img6 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp_bn = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img6, i32 0, i32 0
  %tmp_bn7 = load i32, i32* %tmp_bn
  store i32 %tmp_bn7, i32* %len2
  %len8 = load i32, i32* %len2
  %img9 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp_bn10 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img9, i32 0, i32 1
  %tmp_bn11 = load i32, i32* %tmp_bn10
  %img12 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp_bn13 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img12, i32 0, i32 2
  %tmp_bn14 = load i32, i32* %tmp_bn13
  %mallocsize = mul i32 %len8, ptrtoint (i32* getelementptr (i32, i32* null, i32 1) to i32)
  %malloccall = tail call i8* @malloc(i32 %mallocsize)
  %tmp_bn15 = bitcast i8* %malloccall to i32*
  store i32 %len8, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.26, i32 0, i32 0)
  store i32 %tmp_bn11, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.26, i32 0, i32 1)
  store i32 %tmp_bn14, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.26, i32 0, i32 2)
  store i32* %tmp_bn15, i32** getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.26, i32 0, i32 3)
  store { i32, i32, i32, i32* }* @init_arr_bn.26, { i32, i32, i32, i32* }** %img24
  store i32 0, i32* %i3
  br label %while

while:                                            ; preds = %while_body, %entry
  %i42 = load i32, i32* %i3
  %len43 = load i32, i32* %len2
  %tmp44 = icmp slt i32 %i42, %len43
  br i1 %tmp44, label %while_body, label %merge

while_body:                                       ; preds = %while
  %len16 = load i32, i32* %len2
  %tmp = sub i32 %len16, 1
  %i17 = load i32, i32* %i3
  %tmp18 = sub i32 %tmp, %i17
  store i32 %tmp18, i32* %o5
  %img19 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp20 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img19, i32 0, i32 2
  %tmp21 = load i32, i32* %tmp20
  %tmp22 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img19, i32 0, i32 1
  %tmp23 = load i32, i32* %tmp22
  %tmp24 = mul i32 %tmp21, %tmp23
  %o25 = load i32, i32* %o5
  %tmp26 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img19, i32 0, i32 3
  %tmp27 = load i32*, i32** %tmp26
  %tmp28 = getelementptr inbounds i32, i32* %tmp27, i32 %o25
  %tmp29 = load i32, i32* %tmp28
  %img230 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img24
  %tmp31 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img230, i32 0, i32 2
  %tmp32 = load i32, i32* %tmp31
  %tmp33 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img230, i32 0, i32 1
  %tmp34 = load i32, i32* %tmp33
  %tmp35 = mul i32 %tmp32, %tmp34
  %i36 = load i32, i32* %i3
  %tmp37 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img230, i32 0, i32 3
  %tmp38 = load i32*, i32** %tmp37
  %tmp39 = getelementptr inbounds i32, i32* %tmp38, i32 %i36
  store i32 %tmp29, i32* %tmp39
  %i40 = load i32, i32* %i3
  %tmp41 = add i32 %i40, 1
  store i32 %tmp41, i32* %i3
  br label %while

merge:                                            ; preds = %while
  %img245 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img24
  call void @rotate({ i32, i32, i32, i32* }* %img245, i32 180)
  %img46 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %close = call i32 @close({ i32, i32, i32, i32* }* %img46, i32 1)
  %img47 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %img248 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img24
  %tmp_bn49 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img47, i32 0, i32 0
  %tmp_bn50 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img47, i32 0, i32 1
  %tmp_bn51 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img47, i32 0, i32 2
  %tmp_bn52 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img47, i32 0, i32 3
  %tmp_bn53 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img248, i32 0, i32 0
  %tmp_len = load i32, i32* %tmp_bn53
  %tmp_bn54 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img248, i32 0, i32 1
  %tmp_h = load i32, i32* %tmp_bn54
  %tmp_bn55 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img248, i32 0, i32 2
  %tmp_w = load i32, i32* %tmp_bn55
  %tmp_bn56 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img248, i32 0, i32 3
  %tmp_img = load i32*, i32** %tmp_bn56
  store i32 %tmp_len, i32* %tmp_bn49
  store i32 %tmp_h, i32* %tmp_bn50
  store i32 %tmp_w, i32* %tmp_bn51
  store i32* %tmp_img, i32** %tmp_bn52
  ret void
}

define void @apply_conv_filter({ i32, i32, i32, i32* }* %img, { i32, i32, i32, i32* }* %filter) {
entry:
  %img1 = alloca { i32, i32, i32, i32* }*
  store { i32, i32, i32, i32* }* %img, { i32, i32, i32, i32* }** %img1
  %filter2 = alloca { i32, i32, i32, i32* }*
  store { i32, i32, i32, i32* }* %filter, { i32, i32, i32, i32* }** %filter2
  %img2 = alloca { i32, i32, i32, i32* }*
  %y_offset = alloca i32
  %x_offset = alloca i32
  %width = alloca i32
  %sum = alloca i32
  %span = alloca i32
  %r_tmp = alloca i32
  %r = alloca i32
  %o = alloca i32
  %n = alloca i32
  %min = alloca i32
  %max = alloca i32
  %m = alloca i32
  %len = alloca i32
  %kernel_r = alloca i32
  %kernel_g = alloca i32
  %kernel_b = alloca i32
  %k = alloca i32
  %j = alloca i32
  %i = alloca i32
  %height = alloca i32
  %g_tmp = alloca i32
  %g = alloca i32
  %filter_width = alloca i32
  %filter_height = alloca i32
  %b_tmp = alloca i32
  %b = alloca i32
  %len3 = alloca i32
  %i4 = alloca i32
  %j5 = alloca i32
  %img26 = alloca { i32, i32, i32, i32* }*
  %o7 = alloca i32
  %r8 = alloca i32
  %g9 = alloca i32
  %b10 = alloca i32
  %height11 = alloca i32
  %width12 = alloca i32
  %kernel_r13 = alloca i32
  %kernel_g14 = alloca i32
  %kernel_b15 = alloca i32
  %r_tmp16 = alloca i32
  %g_tmp17 = alloca i32
  %b_tmp18 = alloca i32
  %m19 = alloca i32
  %n20 = alloca i32
  %sum21 = alloca i32
  store i32 0, i32* %sum21
  store i32 0, i32* %i4
  br label %while

while:                                            ; preds = %while_body, %entry
  %i36 = load i32, i32* %i4
  %filter37 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %filter2
  %tmp_bn = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %filter37, i32 0, i32 0
  %tmp_bn38 = load i32, i32* %tmp_bn
  %tmp39 = icmp slt i32 %i36, %tmp_bn38
  br i1 %tmp39, label %while_body, label %merge

while_body:                                       ; preds = %while
  %sum22 = load i32, i32* %sum21
  %filter23 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %filter2
  %tmp = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %filter23, i32 0, i32 2
  %tmp24 = load i32, i32* %tmp
  %tmp25 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %filter23, i32 0, i32 1
  %tmp26 = load i32, i32* %tmp25
  %tmp27 = mul i32 %tmp24, %tmp26
  %i28 = load i32, i32* %i4
  %tmp29 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %filter23, i32 0, i32 3
  %tmp30 = load i32*, i32** %tmp29
  %tmp31 = getelementptr inbounds i32, i32* %tmp30, i32 %i28
  %tmp32 = load i32, i32* %tmp31
  %tmp33 = add i32 %sum22, %tmp32
  store i32 %tmp33, i32* %sum21
  %i34 = load i32, i32* %i4
  %tmp35 = add i32 %i34, 1
  store i32 %tmp35, i32* %i4
  br label %while

merge:                                            ; preds = %while
  %filter_height40 = alloca i32
  %filter41 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %filter2
  %tmp_bn42 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %filter41, i32 0, i32 1
  %tmp_bn43 = load i32, i32* %tmp_bn42
  store i32 %tmp_bn43, i32* %filter_height40
  %filter_width44 = alloca i32
  %filter45 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %filter2
  %tmp_bn46 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %filter45, i32 0, i32 2
  %tmp_bn47 = load i32, i32* %tmp_bn46
  store i32 %tmp_bn47, i32* %filter_width44
  %x_offset48 = alloca i32
  %filter_height49 = load i32, i32* %filter_height40
  %tmp50 = sub i32 %filter_height49, 1
  %tmp51 = sdiv i32 %tmp50, 2
  store i32 %tmp51, i32* %x_offset48
  %y_offset52 = alloca i32
  %filter_width53 = load i32, i32* %filter_width44
  %tmp54 = sub i32 %filter_width53, 1
  %tmp55 = sdiv i32 %tmp54, 2
  store i32 %tmp55, i32* %y_offset52
  %img56 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp_bn57 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img56, i32 0, i32 0
  %tmp_bn58 = load i32, i32* %tmp_bn57
  store i32 %tmp_bn58, i32* %len3
  %img59 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp_bn60 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img59, i32 0, i32 1
  %tmp_bn61 = load i32, i32* %tmp_bn60
  store i32 %tmp_bn61, i32* %height11
  %img62 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp_bn63 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img62, i32 0, i32 2
  %tmp_bn64 = load i32, i32* %tmp_bn63
  store i32 %tmp_bn64, i32* %width12
  %len65 = load i32, i32* %len3
  %height66 = load i32, i32* %height11
  %img67 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp_bn68 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img67, i32 0, i32 2
  %tmp_bn69 = load i32, i32* %tmp_bn68
  %mallocsize = mul i32 %len65, ptrtoint (i32* getelementptr (i32, i32* null, i32 1) to i32)
  %malloccall = tail call i8* @malloc(i32 %mallocsize)
  %tmp_bn70 = bitcast i8* %malloccall to i32*
  store i32 %len65, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.30, i32 0, i32 0)
  store i32 %height66, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.30, i32 0, i32 1)
  store i32 %tmp_bn69, i32* getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.30, i32 0, i32 2)
  store i32* %tmp_bn70, i32** getelementptr inbounds ({ i32, i32, i32, i32* }, { i32, i32, i32, i32* }* @init_arr_bn.30, i32 0, i32 3)
  store { i32, i32, i32, i32* }* @init_arr_bn.30, { i32, i32, i32, i32* }** %img26
  store i32 0, i32* %i4
  br label %while71

while71:                                          ; preds = %merge335, %merge
  %i338 = load i32, i32* %i4
  %height339 = load i32, i32* %height11
  %tmp340 = icmp slt i32 %i338, %height339
  br i1 %tmp340, label %while_body72, label %merge341

while_body72:                                     ; preds = %while71
  store i32 0, i32* %j5
  br label %while73

while73:                                          ; preds = %merge106, %while_body72
  %j332 = load i32, i32* %j5
  %width333 = load i32, i32* %width12
  %tmp334 = icmp slt i32 %j332, %width333
  br i1 %tmp334, label %while_body74, label %merge335

while_body74:                                     ; preds = %while73
  %width75 = load i32, i32* %width12
  %i76 = load i32, i32* %i4
  %tmp77 = mul i32 %width75, %i76
  %j78 = load i32, i32* %j5
  %tmp79 = add i32 %tmp77, %j78
  %tmp80 = mul i32 %tmp79, 3
  store i32 %tmp80, i32* %r8
  %r81 = load i32, i32* %r8
  %tmp82 = add i32 %r81, 1
  store i32 %tmp82, i32* %g9
  %r83 = load i32, i32* %r8
  %tmp84 = add i32 %r83, 2
  store i32 %tmp84, i32* %b10
  %i85 = load i32, i32* %i4
  %x_offset86 = load i32, i32* %x_offset48
  %tmp87 = sub i32 %i85, %x_offset86
  %tmp88 = icmp sge i32 %tmp87, 0
  %i89 = load i32, i32* %i4
  %x_offset90 = load i32, i32* %x_offset48
  %tmp91 = add i32 %i89, %x_offset90
  %height92 = load i32, i32* %height11
  %tmp93 = icmp slt i32 %tmp91, %height92
  %tmp94 = and i1 %tmp88, %tmp93
  %j95 = load i32, i32* %j5
  %y_offset96 = load i32, i32* %y_offset52
  %tmp97 = sub i32 %j95, %y_offset96
  %tmp98 = icmp sge i32 %tmp97, 0
  %tmp99 = and i1 %tmp94, %tmp98
  %j100 = load i32, i32* %j5
  %y_offset101 = load i32, i32* %y_offset52
  %tmp102 = add i32 %j100, %y_offset101
  %width103 = load i32, i32* %width12
  %tmp104 = icmp slt i32 %tmp102, %width103
  %tmp105 = and i1 %tmp99, %tmp104
  br i1 %tmp105, label %then, label %else

merge106:                                         ; preds = %else, %merge227
  %j330 = load i32, i32* %j5
  %tmp331 = add i32 %j330, 1
  store i32 %tmp331, i32* %j5
  br label %while73

then:                                             ; preds = %while_body74
  store i32 0, i32* %kernel_r13
  store i32 0, i32* %kernel_g14
  store i32 0, i32* %kernel_b15
  store i32 0, i32* %m19
  br label %while107

while107:                                         ; preds = %merge221, %then
  %m224 = load i32, i32* %m19
  %filter_height225 = load i32, i32* %filter_height40
  %tmp226 = icmp slt i32 %m224, %filter_height225
  br i1 %tmp226, label %while_body108, label %merge227

while_body108:                                    ; preds = %while107
  store i32 0, i32* %n20
  br label %while109

while109:                                         ; preds = %while_body110, %while_body108
  %n218 = load i32, i32* %n20
  %filter_width219 = load i32, i32* %filter_width44
  %tmp220 = icmp slt i32 %n218, %filter_width219
  br i1 %tmp220, label %while_body110, label %merge221

while_body110:                                    ; preds = %while109
  %width111 = load i32, i32* %width12
  %i112 = load i32, i32* %i4
  %m113 = load i32, i32* %m19
  %tmp114 = add i32 %i112, %m113
  %x_offset115 = load i32, i32* %x_offset48
  %tmp116 = sub i32 %tmp114, %x_offset115
  %tmp117 = mul i32 %width111, %tmp116
  %j118 = load i32, i32* %j5
  %tmp119 = add i32 %tmp117, %j118
  %n120 = load i32, i32* %n20
  %tmp121 = add i32 %tmp119, %n120
  %y_offset122 = load i32, i32* %y_offset52
  %tmp123 = sub i32 %tmp121, %y_offset122
  %tmp124 = mul i32 %tmp123, 3
  store i32 %tmp124, i32* %r_tmp16
  %r_tmp125 = load i32, i32* %r_tmp16
  %tmp126 = add i32 %r_tmp125, 1
  store i32 %tmp126, i32* %g_tmp17
  %r_tmp127 = load i32, i32* %r_tmp16
  %tmp128 = add i32 %r_tmp127, 2
  store i32 %tmp128, i32* %b_tmp18
  %kernel_r129 = load i32, i32* %kernel_r13
  %filter130 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %filter2
  %tmp131 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %filter130, i32 0, i32 2
  %tmp132 = load i32, i32* %tmp131
  %tmp133 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %filter130, i32 0, i32 1
  %tmp134 = load i32, i32* %tmp133
  %tmp135 = mul i32 %tmp132, %tmp134
  %m136 = load i32, i32* %m19
  %filter_width137 = load i32, i32* %filter_width44
  %tmp138 = mul i32 %m136, %filter_width137
  %n139 = load i32, i32* %n20
  %tmp140 = add i32 %tmp138, %n139
  %tmp141 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %filter130, i32 0, i32 3
  %tmp142 = load i32*, i32** %tmp141
  %tmp143 = getelementptr inbounds i32, i32* %tmp142, i32 %tmp140
  %tmp144 = load i32, i32* %tmp143
  %img145 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp146 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img145, i32 0, i32 2
  %tmp147 = load i32, i32* %tmp146
  %tmp148 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img145, i32 0, i32 1
  %tmp149 = load i32, i32* %tmp148
  %tmp150 = mul i32 %tmp147, %tmp149
  %r_tmp151 = load i32, i32* %r_tmp16
  %tmp152 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img145, i32 0, i32 3
  %tmp153 = load i32*, i32** %tmp152
  %tmp154 = getelementptr inbounds i32, i32* %tmp153, i32 %r_tmp151
  %tmp155 = load i32, i32* %tmp154
  %tmp156 = mul i32 %tmp144, %tmp155
  %tmp157 = add i32 %kernel_r129, %tmp156
  store i32 %tmp157, i32* %kernel_r13
  %kernel_g158 = load i32, i32* %kernel_g14
  %filter159 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %filter2
  %tmp160 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %filter159, i32 0, i32 2
  %tmp161 = load i32, i32* %tmp160
  %tmp162 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %filter159, i32 0, i32 1
  %tmp163 = load i32, i32* %tmp162
  %tmp164 = mul i32 %tmp161, %tmp163
  %m165 = load i32, i32* %m19
  %filter_width166 = load i32, i32* %filter_width44
  %tmp167 = mul i32 %m165, %filter_width166
  %n168 = load i32, i32* %n20
  %tmp169 = add i32 %tmp167, %n168
  %tmp170 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %filter159, i32 0, i32 3
  %tmp171 = load i32*, i32** %tmp170
  %tmp172 = getelementptr inbounds i32, i32* %tmp171, i32 %tmp169
  %tmp173 = load i32, i32* %tmp172
  %img174 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp175 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img174, i32 0, i32 2
  %tmp176 = load i32, i32* %tmp175
  %tmp177 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img174, i32 0, i32 1
  %tmp178 = load i32, i32* %tmp177
  %tmp179 = mul i32 %tmp176, %tmp178
  %g_tmp180 = load i32, i32* %g_tmp17
  %tmp181 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img174, i32 0, i32 3
  %tmp182 = load i32*, i32** %tmp181
  %tmp183 = getelementptr inbounds i32, i32* %tmp182, i32 %g_tmp180
  %tmp184 = load i32, i32* %tmp183
  %tmp185 = mul i32 %tmp173, %tmp184
  %tmp186 = add i32 %kernel_g158, %tmp185
  store i32 %tmp186, i32* %kernel_g14
  %kernel_b187 = load i32, i32* %kernel_b15
  %filter188 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %filter2
  %tmp189 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %filter188, i32 0, i32 2
  %tmp190 = load i32, i32* %tmp189
  %tmp191 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %filter188, i32 0, i32 1
  %tmp192 = load i32, i32* %tmp191
  %tmp193 = mul i32 %tmp190, %tmp192
  %m194 = load i32, i32* %m19
  %filter_width195 = load i32, i32* %filter_width44
  %tmp196 = mul i32 %m194, %filter_width195
  %n197 = load i32, i32* %n20
  %tmp198 = add i32 %tmp196, %n197
  %tmp199 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %filter188, i32 0, i32 3
  %tmp200 = load i32*, i32** %tmp199
  %tmp201 = getelementptr inbounds i32, i32* %tmp200, i32 %tmp198
  %tmp202 = load i32, i32* %tmp201
  %img203 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp204 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img203, i32 0, i32 2
  %tmp205 = load i32, i32* %tmp204
  %tmp206 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img203, i32 0, i32 1
  %tmp207 = load i32, i32* %tmp206
  %tmp208 = mul i32 %tmp205, %tmp207
  %b_tmp209 = load i32, i32* %b_tmp18
  %tmp210 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img203, i32 0, i32 3
  %tmp211 = load i32*, i32** %tmp210
  %tmp212 = getelementptr inbounds i32, i32* %tmp211, i32 %b_tmp209
  %tmp213 = load i32, i32* %tmp212
  %tmp214 = mul i32 %tmp202, %tmp213
  %tmp215 = add i32 %kernel_b187, %tmp214
  store i32 %tmp215, i32* %kernel_b15
  %n216 = load i32, i32* %n20
  %tmp217 = add i32 %n216, 1
  store i32 %tmp217, i32* %n20
  br label %while109

merge221:                                         ; preds = %while109
  %m222 = load i32, i32* %m19
  %tmp223 = add i32 %m222, 1
  store i32 %tmp223, i32* %m19
  br label %while107

merge227:                                         ; preds = %while107
  %kernel_r228 = load i32, i32* %kernel_r13
  %sum229 = load i32, i32* %sum21
  %tmp230 = sdiv i32 %kernel_r228, %sum229
  %img2231 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img26
  %tmp232 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2231, i32 0, i32 2
  %tmp233 = load i32, i32* %tmp232
  %tmp234 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2231, i32 0, i32 1
  %tmp235 = load i32, i32* %tmp234
  %tmp236 = mul i32 %tmp233, %tmp235
  %r237 = load i32, i32* %r8
  %tmp238 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2231, i32 0, i32 3
  %tmp239 = load i32*, i32** %tmp238
  %tmp240 = getelementptr inbounds i32, i32* %tmp239, i32 %r237
  store i32 %tmp230, i32* %tmp240
  %kernel_g241 = load i32, i32* %kernel_g14
  %sum242 = load i32, i32* %sum21
  %tmp243 = sdiv i32 %kernel_g241, %sum242
  %img2244 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img26
  %tmp245 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2244, i32 0, i32 2
  %tmp246 = load i32, i32* %tmp245
  %tmp247 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2244, i32 0, i32 1
  %tmp248 = load i32, i32* %tmp247
  %tmp249 = mul i32 %tmp246, %tmp248
  %g250 = load i32, i32* %g9
  %tmp251 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2244, i32 0, i32 3
  %tmp252 = load i32*, i32** %tmp251
  %tmp253 = getelementptr inbounds i32, i32* %tmp252, i32 %g250
  store i32 %tmp243, i32* %tmp253
  %kernel_b254 = load i32, i32* %kernel_b15
  %sum255 = load i32, i32* %sum21
  %tmp256 = sdiv i32 %kernel_b254, %sum255
  %img2257 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img26
  %tmp258 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2257, i32 0, i32 2
  %tmp259 = load i32, i32* %tmp258
  %tmp260 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2257, i32 0, i32 1
  %tmp261 = load i32, i32* %tmp260
  %tmp262 = mul i32 %tmp259, %tmp261
  %b263 = load i32, i32* %b10
  %tmp264 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2257, i32 0, i32 3
  %tmp265 = load i32*, i32** %tmp264
  %tmp266 = getelementptr inbounds i32, i32* %tmp265, i32 %b263
  store i32 %tmp256, i32* %tmp266
  br label %merge106

else:                                             ; preds = %while_body74
  %img267 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp268 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img267, i32 0, i32 2
  %tmp269 = load i32, i32* %tmp268
  %tmp270 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img267, i32 0, i32 1
  %tmp271 = load i32, i32* %tmp270
  %tmp272 = mul i32 %tmp269, %tmp271
  %r273 = load i32, i32* %r8
  %tmp274 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img267, i32 0, i32 3
  %tmp275 = load i32*, i32** %tmp274
  %tmp276 = getelementptr inbounds i32, i32* %tmp275, i32 %r273
  %tmp277 = load i32, i32* %tmp276
  %img2278 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img26
  %tmp279 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2278, i32 0, i32 2
  %tmp280 = load i32, i32* %tmp279
  %tmp281 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2278, i32 0, i32 1
  %tmp282 = load i32, i32* %tmp281
  %tmp283 = mul i32 %tmp280, %tmp282
  %r284 = load i32, i32* %r8
  %tmp285 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2278, i32 0, i32 3
  %tmp286 = load i32*, i32** %tmp285
  %tmp287 = getelementptr inbounds i32, i32* %tmp286, i32 %r284
  store i32 %tmp277, i32* %tmp287
  %img288 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp289 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img288, i32 0, i32 2
  %tmp290 = load i32, i32* %tmp289
  %tmp291 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img288, i32 0, i32 1
  %tmp292 = load i32, i32* %tmp291
  %tmp293 = mul i32 %tmp290, %tmp292
  %g294 = load i32, i32* %g9
  %tmp295 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img288, i32 0, i32 3
  %tmp296 = load i32*, i32** %tmp295
  %tmp297 = getelementptr inbounds i32, i32* %tmp296, i32 %g294
  %tmp298 = load i32, i32* %tmp297
  %img2299 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img26
  %tmp300 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2299, i32 0, i32 2
  %tmp301 = load i32, i32* %tmp300
  %tmp302 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2299, i32 0, i32 1
  %tmp303 = load i32, i32* %tmp302
  %tmp304 = mul i32 %tmp301, %tmp303
  %g305 = load i32, i32* %g9
  %tmp306 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2299, i32 0, i32 3
  %tmp307 = load i32*, i32** %tmp306
  %tmp308 = getelementptr inbounds i32, i32* %tmp307, i32 %g305
  store i32 %tmp298, i32* %tmp308
  %img309 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %tmp310 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img309, i32 0, i32 2
  %tmp311 = load i32, i32* %tmp310
  %tmp312 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img309, i32 0, i32 1
  %tmp313 = load i32, i32* %tmp312
  %tmp314 = mul i32 %tmp311, %tmp313
  %b315 = load i32, i32* %b10
  %tmp316 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img309, i32 0, i32 3
  %tmp317 = load i32*, i32** %tmp316
  %tmp318 = getelementptr inbounds i32, i32* %tmp317, i32 %b315
  %tmp319 = load i32, i32* %tmp318
  %img2320 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img26
  %tmp321 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2320, i32 0, i32 2
  %tmp322 = load i32, i32* %tmp321
  %tmp323 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2320, i32 0, i32 1
  %tmp324 = load i32, i32* %tmp323
  %tmp325 = mul i32 %tmp322, %tmp324
  %b326 = load i32, i32* %b10
  %tmp327 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2320, i32 0, i32 3
  %tmp328 = load i32*, i32** %tmp327
  %tmp329 = getelementptr inbounds i32, i32* %tmp328, i32 %b326
  store i32 %tmp319, i32* %tmp329
  br label %merge106

merge335:                                         ; preds = %while73
  %i336 = load i32, i32* %i4
  %tmp337 = add i32 %i336, 1
  store i32 %tmp337, i32* %i4
  br label %while71

merge341:                                         ; preds = %while71
  %img342 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %close = call i32 @close({ i32, i32, i32, i32* }* %img342, i32 1)
  %k343 = alloca i32
  store i32 0, i32* %k343
  br label %while344

while344:                                         ; preds = %merge459, %merge341
  %k462 = load i32, i32* %k343
  %tmp463 = icmp slt i32 %k462, 3
  br i1 %tmp463, label %while_body345, label %merge464

while_body345:                                    ; preds = %while344
  %min346 = alloca i32
  store i32 255, i32* %min346
  %max347 = alloca i32
  store i32 0, i32* %max347
  store i32 0, i32* %i4
  br label %while348

while348:                                         ; preds = %merge389, %while_body345
  %i392 = load i32, i32* %i4
  %height393 = load i32, i32* %height11
  %tmp394 = icmp slt i32 %i392, %height393
  br i1 %tmp394, label %while_body349, label %merge395

while_body349:                                    ; preds = %while348
  store i32 0, i32* %j5
  br label %while350

while350:                                         ; preds = %merge380, %while_body349
  %j386 = load i32, i32* %j5
  %width387 = load i32, i32* %width12
  %tmp388 = icmp slt i32 %j386, %width387
  br i1 %tmp388, label %while_body351, label %merge389

while_body351:                                    ; preds = %while350
  %img2352 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img26
  %tmp353 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2352, i32 0, i32 2
  %tmp354 = load i32, i32* %tmp353
  %tmp355 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2352, i32 0, i32 1
  %tmp356 = load i32, i32* %tmp355
  %tmp357 = mul i32 %tmp354, %tmp356
  %i358 = load i32, i32* %i4
  %width359 = load i32, i32* %width12
  %tmp360 = mul i32 %i358, %width359
  %j361 = load i32, i32* %j5
  %tmp362 = add i32 %tmp360, %j361
  %tmp363 = mul i32 %tmp362, 3
  %k364 = load i32, i32* %k343
  %tmp365 = add i32 %tmp363, %k364
  %tmp366 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2352, i32 0, i32 3
  %tmp367 = load i32*, i32** %tmp366
  %tmp368 = getelementptr inbounds i32, i32* %tmp367, i32 %tmp365
  %tmp369 = load i32, i32* %tmp368
  store i32 %tmp369, i32* %r8
  %min370 = load i32, i32* %min346
  %r371 = load i32, i32* %r8
  %tmp372 = icmp sgt i32 %min370, %r371
  br i1 %tmp372, label %then374, label %else376

merge373:                                         ; preds = %else376, %then374
  %max377 = load i32, i32* %max347
  %r378 = load i32, i32* %r8
  %tmp379 = icmp slt i32 %max377, %r378
  br i1 %tmp379, label %then381, label %else383

then374:                                          ; preds = %while_body351
  %r375 = load i32, i32* %r8
  store i32 %r375, i32* %min346
  br label %merge373

else376:                                          ; preds = %while_body351
  br label %merge373

merge380:                                         ; preds = %else383, %then381
  %j384 = load i32, i32* %j5
  %tmp385 = add i32 %j384, 1
  store i32 %tmp385, i32* %j5
  br label %while350

then381:                                          ; preds = %merge373
  %r382 = load i32, i32* %r8
  store i32 %r382, i32* %max347
  br label %merge380

else383:                                          ; preds = %merge373
  br label %merge380

merge389:                                         ; preds = %while350
  %i390 = load i32, i32* %i4
  %tmp391 = add i32 %i390, 1
  store i32 %tmp391, i32* %i4
  br label %while348

merge395:                                         ; preds = %while348
  %span396 = alloca i32
  %max397 = load i32, i32* %max347
  %min398 = load i32, i32* %min346
  %tmp399 = sub i32 %max397, %min398
  store i32 %tmp399, i32* %span396
  store i32 0, i32* %i4
  br label %while400

while400:                                         ; preds = %merge453, %merge395
  %i456 = load i32, i32* %i4
  %height457 = load i32, i32* %height11
  %tmp458 = icmp slt i32 %i456, %height457
  br i1 %tmp458, label %while_body401, label %merge459

while_body401:                                    ; preds = %while400
  store i32 0, i32* %j5
  br label %while402

while402:                                         ; preds = %while_body403, %while_body401
  %j450 = load i32, i32* %j5
  %width451 = load i32, i32* %width12
  %tmp452 = icmp slt i32 %j450, %width451
  br i1 %tmp452, label %while_body403, label %merge453

while_body403:                                    ; preds = %while402
  %img2404 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img26
  %tmp405 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2404, i32 0, i32 2
  %tmp406 = load i32, i32* %tmp405
  %tmp407 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2404, i32 0, i32 1
  %tmp408 = load i32, i32* %tmp407
  %tmp409 = mul i32 %tmp406, %tmp408
  %i410 = load i32, i32* %i4
  %width411 = load i32, i32* %width12
  %tmp412 = mul i32 %i410, %width411
  %j413 = load i32, i32* %j5
  %tmp414 = add i32 %tmp412, %j413
  %tmp415 = mul i32 %tmp414, 3
  %k416 = load i32, i32* %k343
  %tmp417 = add i32 %tmp415, %k416
  %tmp418 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2404, i32 0, i32 3
  %tmp419 = load i32*, i32** %tmp418
  %tmp420 = getelementptr inbounds i32, i32* %tmp419, i32 %tmp417
  %tmp421 = load i32, i32* %tmp420
  store i32 %tmp421, i32* %r8
  %r422 = load i32, i32* %r8
  %min423 = load i32, i32* %min346
  %tmp424 = sub i32 %r422, %min423
  %tmp_bn425 = sitofp i32 %tmp424 to double
  %span426 = load i32, i32* %span396
  %tmp_bn427 = sitofp i32 %span426 to double
  %tmp428 = fdiv double %tmp_bn425, %tmp_bn427
  %tmp429 = fmul double %tmp428, 2.550000e+02
  %tmp_bn430 = fptosi double %tmp429 to i32
  %img2431 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img26
  %tmp432 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2431, i32 0, i32 2
  %tmp433 = load i32, i32* %tmp432
  %tmp434 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2431, i32 0, i32 1
  %tmp435 = load i32, i32* %tmp434
  %tmp436 = mul i32 %tmp433, %tmp435
  %i437 = load i32, i32* %i4
  %width438 = load i32, i32* %width12
  %tmp439 = mul i32 %i437, %width438
  %j440 = load i32, i32* %j5
  %tmp441 = add i32 %tmp439, %j440
  %tmp442 = mul i32 %tmp441, 3
  %k443 = load i32, i32* %k343
  %tmp444 = add i32 %tmp442, %k443
  %tmp445 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2431, i32 0, i32 3
  %tmp446 = load i32*, i32** %tmp445
  %tmp447 = getelementptr inbounds i32, i32* %tmp446, i32 %tmp444
  store i32 %tmp_bn430, i32* %tmp447
  %j448 = load i32, i32* %j5
  %tmp449 = add i32 %j448, 1
  store i32 %tmp449, i32* %j5
  br label %while402

merge453:                                         ; preds = %while402
  %i454 = load i32, i32* %i4
  %tmp455 = add i32 %i454, 1
  store i32 %tmp455, i32* %i4
  br label %while400

merge459:                                         ; preds = %while400
  %k460 = load i32, i32* %k343
  %tmp461 = add i32 %k460, 1
  store i32 %tmp461, i32* %k343
  br label %while344

merge464:                                         ; preds = %while344
  %img465 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img1
  %img2466 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img26
  %tmp_bn467 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img465, i32 0, i32 0
  %tmp_bn468 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img465, i32 0, i32 1
  %tmp_bn469 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img465, i32 0, i32 2
  %tmp_bn470 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img465, i32 0, i32 3
  %tmp_bn471 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2466, i32 0, i32 0
  %tmp_len = load i32, i32* %tmp_bn471
  %tmp_bn472 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2466, i32 0, i32 1
  %tmp_h = load i32, i32* %tmp_bn472
  %tmp_bn473 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2466, i32 0, i32 2
  %tmp_w = load i32, i32* %tmp_bn473
  %tmp_bn474 = getelementptr inbounds { i32, i32, i32, i32* }, { i32, i32, i32, i32* }* %img2466, i32 0, i32 3
  %tmp_img = load i32*, i32** %tmp_bn474
  store i32 %tmp_len, i32* %tmp_bn467
  store i32 %tmp_h, i32* %tmp_bn468
  store i32 %tmp_w, i32* %tmp_bn469
  store i32* %tmp_img, i32** %tmp_bn470
  ret void
}

declare noalias i8* @malloc(i32)
