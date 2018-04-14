; ModuleID = 'MicroC'
source_filename = "MicroC"

@fmt = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmt.1 = private unnamed_addr constant [4 x i8] c"%g\0A\00"
@fmt.2 = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@.str = private unnamed_addr constant [11 x i8] c"./img2.png\00"
@.str.3 = private unnamed_addr constant [11 x i8] c"./img2.png\00"
@.str.4 = private unnamed_addr constant [20 x i8] c"./img3_collaged.png\00"

declare i32 @printf(i8*, ...)

declare { i32, i32, i32, i32* }* @load(i8*)

declare i32 @close({ i32, i32, i32, i32* }*, i32)

declare i32 @save({ i32, i32, i32, i32* }*, i8*)

declare { i32, i32, i32, i32* }* @collage({ i32, i32, i32, i32* }*, { i32, i32, i32, i32* }*)

declare i32 @scifi_filter({ i32, i32, i32, i32* }*)

declare i32 @apply_conv_filters({ i32, i32, i32, i32* }*, { i32, { i32, i32, i32, i32* }** }*)

declare i32 @apply_conv_filter({ i32, i32, i32, i32* }*, { i32, i32, i32, i32* }*)

declare { i32, i32, i32, i32* }* @mtimes({ i32, i32, i32, i32* }*, { i32, i32, i32, i32* }*)

declare i32 @exp(i32, i32)

declare double @expf(double, i32)

declare { i32, i32, i32, i32* }* @trans({ i32, i32, i32, i32* }*)

define i32 @main() {
entry:
  %img3 = alloca { i32, i32, i32, i32* }*
  %img2 = alloca { i32, i32, i32, i32* }*
  %img1 = alloca { i32, i32, i32, i32* }*
  %img11 = alloca { i32, i32, i32, i32* }*
  %load = call { i32, i32, i32, i32* }* @load(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0))
  store { i32, i32, i32, i32* }* %load, { i32, i32, i32, i32* }** %img11
  %img22 = alloca { i32, i32, i32, i32* }*
  %load3 = call { i32, i32, i32, i32* }* @load(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.3, i32 0, i32 0))
  store { i32, i32, i32, i32* }* %load3, { i32, i32, i32, i32* }** %img22
  %img34 = alloca { i32, i32, i32, i32* }*
  %img25 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img22
  %img16 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img11
  %collage = call { i32, i32, i32, i32* }* @collage({ i32, i32, i32, i32* }* %img16, { i32, i32, i32, i32* }* %img25)
  store { i32, i32, i32, i32* }* %collage, { i32, i32, i32, i32* }** %img34
  %img37 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img34
  %save = call i32 @save({ i32, i32, i32, i32* }* %img37, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.4, i32 0, i32 0))
  %img18 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img11
  %close = call i32 @close({ i32, i32, i32, i32* }* %img18, i32 0)
  %img29 = load { i32, i32, i32, i32* }*, { i32, i32, i32, i32* }** %img22
  %close10 = call i32 @close({ i32, i32, i32, i32* }* %img29, i32 0)
  ret i32 0
}
