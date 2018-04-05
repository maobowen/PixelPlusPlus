; ModuleID = 'MicroC'

@fmt = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmt.1 = private unnamed_addr constant [4 x i8] c"%g\0A\00"
@fmt.2 = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@.str = private unnamed_addr constant [16 x i8] c"Hello, Pixel++!\00"

declare i32 @printf(i8*, ...)

declare { i32, i32, i32, i8* }* @load(i8*)

declare i32 @close({ i32, i32, i32, i8* }*)

declare i32 @save({ i32, i32, i32, i8* }*, i8*)

declare { i32, i32, i32, i8* }* @trans({ i32, i32, i32, i8* }*)

declare double @expf(double, i32)

declare i32 @exp(i32, i32)

declare { i32, i32, i32, i8* }* @mtimes({ i32, i32, i32, i8* }*, { i32, i32, i32, i8* }*)

declare i32 @scifi({ i32, i32, i32, i8* }*)

define i32 @main() {
entry:
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @fmt.2, i32 0, i32 0), i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str, i32 0, i32 0))
  ret i32 0
}
