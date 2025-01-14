const builtin = @import("builtin");
const is_test = builtin.is_test;

comptime {
    const linkage = if (is_test) builtin.GlobalLinkage.Internal else builtin.GlobalLinkage.Weak;
    const strong_linkage = if (is_test) builtin.GlobalLinkage.Internal else builtin.GlobalLinkage.Strong;

    @export("__letf2", @import("compiler_rt/comparetf2.zig").__letf2, linkage);
    @export("__getf2", @import("compiler_rt/comparetf2.zig").__getf2, linkage);

    if (!is_test) {
        // only create these aliases when not testing
        @export("__cmptf2", @import("compiler_rt/comparetf2.zig").__letf2, linkage);
        @export("__eqtf2", @import("compiler_rt/comparetf2.zig").__letf2, linkage);
        @export("__lttf2", @import("compiler_rt/comparetf2.zig").__letf2, linkage);
        @export("__netf2", @import("compiler_rt/comparetf2.zig").__letf2, linkage);
        @export("__gttf2", @import("compiler_rt/comparetf2.zig").__getf2, linkage);
        @export("__gnu_h2f_ieee", @import("compiler_rt/extendXfYf2.zig").__extendhfsf2, linkage);
        @export("__gnu_f2h_ieee", @import("compiler_rt/truncXfYf2.zig").__truncsfhf2, linkage);
    }

    @export("__unordtf2", @import("compiler_rt/comparetf2.zig").__unordtf2, linkage);

    @export("__addtf3", @import("compiler_rt/addXf3.zig").__addtf3, linkage);
    @export("__subtf3", @import("compiler_rt/addXf3.zig").__subtf3, linkage);

    @export("__floattitf", @import("compiler_rt/floattitf.zig").__floattitf, linkage);
    @export("__floattidf", @import("compiler_rt/floattidf.zig").__floattidf, linkage);
    @export("__floattisf", @import("compiler_rt/floattisf.zig").__floattisf, linkage);

    @export("__floatunditf", @import("compiler_rt/floatunditf.zig").__floatunditf, linkage);
    @export("__floatunsitf", @import("compiler_rt/floatunsitf.zig").__floatunsitf, linkage);

    @export("__floatuntitf", @import("compiler_rt/floatuntitf.zig").__floatuntitf, linkage);
    @export("__floatuntidf", @import("compiler_rt/floatuntidf.zig").__floatuntidf, linkage);
    @export("__floatuntisf", @import("compiler_rt/floatuntisf.zig").__floatuntisf, linkage);

    @export("__extenddftf2", @import("compiler_rt/extendXfYf2.zig").__extenddftf2, linkage);
    @export("__extendsftf2", @import("compiler_rt/extendXfYf2.zig").__extendsftf2, linkage);
    @export("__extendhfsf2", @import("compiler_rt/extendXfYf2.zig").__extendhfsf2, linkage);

    @export("__truncsfhf2", @import("compiler_rt/truncXfYf2.zig").__truncsfhf2, linkage);
    @export("__truncdfhf2", @import("compiler_rt/truncXfYf2.zig").__truncdfhf2, linkage);
    @export("__trunctfdf2", @import("compiler_rt/truncXfYf2.zig").__trunctfdf2, linkage);
    @export("__trunctfsf2", @import("compiler_rt/truncXfYf2.zig").__trunctfsf2, linkage);

    @export("__fixunssfsi", @import("compiler_rt/fixunssfsi.zig").__fixunssfsi, linkage);
    @export("__fixunssfdi", @import("compiler_rt/fixunssfdi.zig").__fixunssfdi, linkage);
    @export("__fixunssfti", @import("compiler_rt/fixunssfti.zig").__fixunssfti, linkage);

    @export("__fixunsdfsi", @import("compiler_rt/fixunsdfsi.zig").__fixunsdfsi, linkage);
    @export("__fixunsdfdi", @import("compiler_rt/fixunsdfdi.zig").__fixunsdfdi, linkage);
    @export("__fixunsdfti", @import("compiler_rt/fixunsdfti.zig").__fixunsdfti, linkage);

    @export("__fixunstfsi", @import("compiler_rt/fixunstfsi.zig").__fixunstfsi, linkage);
    @export("__fixunstfdi", @import("compiler_rt/fixunstfdi.zig").__fixunstfdi, linkage);
    @export("__fixunstfti", @import("compiler_rt/fixunstfti.zig").__fixunstfti, linkage);

    @export("__fixdfdi", @import("compiler_rt/fixdfdi.zig").__fixdfdi, linkage);
    @export("__fixdfsi", @import("compiler_rt/fixdfsi.zig").__fixdfsi, linkage);
    @export("__fixdfti", @import("compiler_rt/fixdfti.zig").__fixdfti, linkage);
    @export("__fixsfdi", @import("compiler_rt/fixsfdi.zig").__fixsfdi, linkage);
    @export("__fixsfsi", @import("compiler_rt/fixsfsi.zig").__fixsfsi, linkage);
    @export("__fixsfti", @import("compiler_rt/fixsfti.zig").__fixsfti, linkage);
    @export("__fixtfdi", @import("compiler_rt/fixtfdi.zig").__fixtfdi, linkage);
    @export("__fixtfsi", @import("compiler_rt/fixtfsi.zig").__fixtfsi, linkage);
    @export("__fixtfti", @import("compiler_rt/fixtfti.zig").__fixtfti, linkage);

    @export("__udivmoddi4", @import("compiler_rt/udivmoddi4.zig").__udivmoddi4, linkage);
    @export("__popcountdi2", @import("compiler_rt/popcountdi2.zig").__popcountdi2, linkage);

    @export("__udivsi3", __udivsi3, linkage);
    @export("__udivdi3", __udivdi3, linkage);
    @export("__umoddi3", __umoddi3, linkage);
    @export("__udivmodsi4", __udivmodsi4, linkage);

    if (is_arm_arch and !is_arm_64) {
        @export("__aeabi_uldivmod", __aeabi_uldivmod, linkage);
        @export("__aeabi_uidivmod", __aeabi_uidivmod, linkage);
        @export("__aeabi_uidiv", __udivsi3, linkage);
    }
    if (builtin.os == builtin.Os.windows) {
        switch (builtin.arch) {
            builtin.Arch.i386 => {
                if (!builtin.link_libc) {
                    @export("_chkstk", _chkstk, strong_linkage);
                    @export("__chkstk_ms", __chkstk_ms, linkage);
                }
                @export("_aulldiv", @import("compiler_rt/aulldiv.zig")._aulldiv, strong_linkage);
                @export("_aullrem", @import("compiler_rt/aullrem.zig")._aullrem, strong_linkage);
            },
            builtin.Arch.x86_64 => {
                if (!builtin.link_libc) {
                    @export("__chkstk", __chkstk, strong_linkage);
                    @export("___chkstk_ms", ___chkstk_ms, linkage);
                }
                @export("__divti3", @import("compiler_rt/divti3.zig").__divti3_windows_x86_64, linkage);
                @export("__multi3", @import("compiler_rt/multi3.zig").__multi3_windows_x86_64, linkage);
                @export("__muloti4", @import("compiler_rt/muloti4.zig").__muloti4_windows_x86_64, linkage);
                @export("__udivti3", @import("compiler_rt/udivti3.zig").__udivti3_windows_x86_64, linkage);
                @export("__udivmodti4", @import("compiler_rt/udivmodti4.zig").__udivmodti4_windows_x86_64, linkage);
                @export("__umodti3", @import("compiler_rt/umodti3.zig").__umodti3_windows_x86_64, linkage);
            },
            else => {},
        }
    } else {
        @export("__divti3", @import("compiler_rt/divti3.zig").__divti3, linkage);
        @export("__multi3", @import("compiler_rt/multi3.zig").__multi3, linkage);
        @export("__muloti4", @import("compiler_rt/muloti4.zig").__muloti4, linkage);
        @export("__udivti3", @import("compiler_rt/udivti3.zig").__udivti3, linkage);
        @export("__udivmodti4", @import("compiler_rt/udivmodti4.zig").__udivmodti4, linkage);
        @export("__umodti3", @import("compiler_rt/umodti3.zig").__umodti3, linkage);
    }
}

const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;

const __udivmoddi4 = @import("compiler_rt/udivmoddi4.zig").__udivmoddi4;

// Avoid dragging in the runtime safety mechanisms into this .o file,
// unless we're trying to test this file.
pub fn panic(msg: []const u8, error_return_trace: ?*builtin.StackTrace) noreturn {
    @setCold(true);
    if (is_test) {
        std.debug.panic("{}", msg);
    } else {
        unreachable;
    }
}

pub fn setXmm0(comptime T: type, value: T) void {
    comptime assert(builtin.arch == builtin.Arch.x86_64);
    const aligned_value: T align(16) = value;
    asm volatile (
        \\movaps (%[ptr]), %%xmm0
            :
        : [ptr] "r" (&aligned_value)
        : "xmm0"
    );
}

extern fn __udivdi3(a: u64, b: u64) u64 {
    @setRuntimeSafety(is_test);
    return __udivmoddi4(a, b, null);
}

extern fn __umoddi3(a: u64, b: u64) u64 {
    @setRuntimeSafety(is_test);

    var r: u64 = undefined;
    _ = __udivmoddi4(a, b, &r);
    return r;
}

const AeabiUlDivModResult = extern struct {
    quot: u64,
    rem: u64,
};
extern fn __aeabi_uldivmod(numerator: u64, denominator: u64) AeabiUlDivModResult {
    @setRuntimeSafety(is_test);
    var result: AeabiUlDivModResult = undefined;
    result.quot = __udivmoddi4(numerator, denominator, &result.rem);
    return result;
}

const is_arm_64 = switch (builtin.arch) {
    builtin.Arch.aarch64,
    builtin.Arch.aarch64_be,
    => true,
    else => false,
};

const is_arm_arch = switch (builtin.arch) {
    builtin.Arch.arm,
    builtin.Arch.armeb,
    builtin.Arch.aarch64,
    builtin.Arch.aarch64_be,
    builtin.Arch.thumb,
    builtin.Arch.thumbeb,
    => true,
    else => false,
};

nakedcc fn __aeabi_uidivmod() void {
    @setRuntimeSafety(false);
    asm volatile (
        \\ push    { lr }
        \\ sub     sp, sp, #4
        \\ mov     r2, sp
        \\ bl      __udivmodsi4
        \\ ldr     r1, [sp]
        \\ add     sp, sp, #4
        \\ pop     { pc }
            :
        :
        : "r2", "r1"
    );
}

// _chkstk (_alloca) routine - probe stack between %esp and (%esp-%eax) in 4k increments,
// then decrement %esp by %eax.  Preserves all registers except %esp and flags.
// This routine is windows specific
// http://msdn.microsoft.com/en-us/library/ms648426.aspx
nakedcc fn _chkstk() align(4) void {
    @setRuntimeSafety(false);

    asm volatile (
        \\         push   %%ecx
        \\         push   %%eax
        \\         cmp    $0x1000,%%eax
        \\         lea    12(%%esp),%%ecx
        \\         jb     1f
        \\ 2:
        \\         sub    $0x1000,%%ecx
        \\         test   %%ecx,(%%ecx)
        \\         sub    $0x1000,%%eax
        \\         cmp    $0x1000,%%eax
        \\         ja     2b
        \\ 1:
        \\         sub    %%eax,%%ecx
        \\         test   %%ecx,(%%ecx)
        \\         pop    %%eax
        \\         pop    %%ecx
        \\         ret
    );
}

nakedcc fn __chkstk() align(4) void {
    @setRuntimeSafety(false);

    asm volatile (
        \\        push   %%rcx
        \\        push   %%rax
        \\        cmp    $0x1000,%%rax
        \\        lea    24(%%rsp),%%rcx
        \\        jb     1f
        \\2:
        \\        sub    $0x1000,%%rcx
        \\        test   %%rcx,(%%rcx)
        \\        sub    $0x1000,%%rax
        \\        cmp    $0x1000,%%rax
        \\        ja     2b
        \\1:
        \\        sub    %%rax,%%rcx
        \\        test   %%rcx,(%%rcx)
        \\        pop    %%rax
        \\        pop    %%rcx
        \\        ret
    );
}

// _chkstk routine
// This routine is windows specific
// http://msdn.microsoft.com/en-us/library/ms648426.aspx
nakedcc fn __chkstk_ms() align(4) void {
    @setRuntimeSafety(false);

    asm volatile (
        \\         push   %%ecx
        \\         push   %%eax
        \\         cmp    $0x1000,%%eax
        \\         lea    12(%%esp),%%ecx
        \\         jb     1f
        \\ 2:
        \\         sub    $0x1000,%%ecx
        \\         test   %%ecx,(%%ecx)
        \\         sub    $0x1000,%%eax
        \\         cmp    $0x1000,%%eax
        \\         ja     2b
        \\ 1:
        \\         sub    %%eax,%%ecx
        \\         test   %%ecx,(%%ecx)
        \\         pop    %%eax
        \\         pop    %%ecx
        \\         ret
    );
}

nakedcc fn ___chkstk_ms() align(4) void {
    @setRuntimeSafety(false);

    asm volatile (
        \\        push   %%rcx
        \\        push   %%rax
        \\        cmp    $0x1000,%%rax
        \\        lea    24(%%rsp),%%rcx
        \\        jb     1f
        \\2:
        \\        sub    $0x1000,%%rcx
        \\        test   %%rcx,(%%rcx)
        \\        sub    $0x1000,%%rax
        \\        cmp    $0x1000,%%rax
        \\        ja     2b
        \\1:
        \\        sub    %%rax,%%rcx
        \\        test   %%rcx,(%%rcx)
        \\        pop    %%rax
        \\        pop    %%rcx
        \\        ret
    );
}

extern fn __udivmodsi4(a: u32, b: u32, rem: *u32) u32 {
    @setRuntimeSafety(is_test);

    const d = __udivsi3(a, b);
    rem.* = @bitCast(u32, @bitCast(i32, a) -% (@bitCast(i32, d) * @bitCast(i32, b)));
    return d;
}

extern fn __udivsi3(n: u32, d: u32) u32 {
    @setRuntimeSafety(is_test);

    const n_uword_bits: c_uint = u32.bit_count;
    // special cases
    if (d == 0) return 0; // ?!
    if (n == 0) return 0;
    var sr = @bitCast(c_uint, c_int(@clz(d)) - c_int(@clz(n)));
    // 0 <= sr <= n_uword_bits - 1 or sr large
    if (sr > n_uword_bits - 1) {
        // d > r
        return 0;
    }
    if (sr == n_uword_bits - 1) {
        // d == 1
        return n;
    }
    sr += 1;
    // 1 <= sr <= n_uword_bits - 1
    // Not a special case
    var q: u32 = n << @intCast(u5, n_uword_bits - sr);
    var r: u32 = n >> @intCast(u5, sr);
    var carry: u32 = 0;
    while (sr > 0) : (sr -= 1) {
        // r:q = ((r:q)  << 1) | carry
        r = (r << 1) | (q >> @intCast(u5, n_uword_bits - 1));
        q = (q << 1) | carry;
        // carry = 0;
        // if (r.all >= d.all)
        // {
        //      r.all -= d.all;
        //      carry = 1;
        // }
        const s = @intCast(i32, d -% r -% 1) >> @intCast(u5, n_uword_bits - 1);
        carry = @intCast(u32, s & 1);
        r -= d & @bitCast(u32, s);
    }
    q = (q << 1) | carry;
    return q;
}

test "test_umoddi3" {
    test_one_umoddi3(0, 1, 0);
    test_one_umoddi3(2, 1, 0);
    test_one_umoddi3(0x8000000000000000, 1, 0x0);
    test_one_umoddi3(0x8000000000000000, 2, 0x0);
    test_one_umoddi3(0xFFFFFFFFFFFFFFFF, 2, 0x1);
}

fn test_one_umoddi3(a: u64, b: u64, expected_r: u64) void {
    const r = __umoddi3(a, b);
    testing.expect(r == expected_r);
}

test "test_udivsi3" {
    const cases = [][3]u32{
        []u32{
            0x00000000,
            0x00000001,
            0x00000000,
        },
        []u32{
            0x00000000,
            0x00000002,
            0x00000000,
        },
        []u32{
            0x00000000,
            0x00000003,
            0x00000000,
        },
        []u32{
            0x00000000,
            0x00000010,
            0x00000000,
        },
        []u32{
            0x00000000,
            0x078644FA,
            0x00000000,
        },
        []u32{
            0x00000000,
            0x0747AE14,
            0x00000000,
        },
        []u32{
            0x00000000,
            0x7FFFFFFF,
            0x00000000,
        },
        []u32{
            0x00000000,
            0x80000000,
            0x00000000,
        },
        []u32{
            0x00000000,
            0xFFFFFFFD,
            0x00000000,
        },
        []u32{
            0x00000000,
            0xFFFFFFFE,
            0x00000000,
        },
        []u32{
            0x00000000,
            0xFFFFFFFF,
            0x00000000,
        },
        []u32{
            0x00000001,
            0x00000001,
            0x00000001,
        },
        []u32{
            0x00000001,
            0x00000002,
            0x00000000,
        },
        []u32{
            0x00000001,
            0x00000003,
            0x00000000,
        },
        []u32{
            0x00000001,
            0x00000010,
            0x00000000,
        },
        []u32{
            0x00000001,
            0x078644FA,
            0x00000000,
        },
        []u32{
            0x00000001,
            0x0747AE14,
            0x00000000,
        },
        []u32{
            0x00000001,
            0x7FFFFFFF,
            0x00000000,
        },
        []u32{
            0x00000001,
            0x80000000,
            0x00000000,
        },
        []u32{
            0x00000001,
            0xFFFFFFFD,
            0x00000000,
        },
        []u32{
            0x00000001,
            0xFFFFFFFE,
            0x00000000,
        },
        []u32{
            0x00000001,
            0xFFFFFFFF,
            0x00000000,
        },
        []u32{
            0x00000002,
            0x00000001,
            0x00000002,
        },
        []u32{
            0x00000002,
            0x00000002,
            0x00000001,
        },
        []u32{
            0x00000002,
            0x00000003,
            0x00000000,
        },
        []u32{
            0x00000002,
            0x00000010,
            0x00000000,
        },
        []u32{
            0x00000002,
            0x078644FA,
            0x00000000,
        },
        []u32{
            0x00000002,
            0x0747AE14,
            0x00000000,
        },
        []u32{
            0x00000002,
            0x7FFFFFFF,
            0x00000000,
        },
        []u32{
            0x00000002,
            0x80000000,
            0x00000000,
        },
        []u32{
            0x00000002,
            0xFFFFFFFD,
            0x00000000,
        },
        []u32{
            0x00000002,
            0xFFFFFFFE,
            0x00000000,
        },
        []u32{
            0x00000002,
            0xFFFFFFFF,
            0x00000000,
        },
        []u32{
            0x00000003,
            0x00000001,
            0x00000003,
        },
        []u32{
            0x00000003,
            0x00000002,
            0x00000001,
        },
        []u32{
            0x00000003,
            0x00000003,
            0x00000001,
        },
        []u32{
            0x00000003,
            0x00000010,
            0x00000000,
        },
        []u32{
            0x00000003,
            0x078644FA,
            0x00000000,
        },
        []u32{
            0x00000003,
            0x0747AE14,
            0x00000000,
        },
        []u32{
            0x00000003,
            0x7FFFFFFF,
            0x00000000,
        },
        []u32{
            0x00000003,
            0x80000000,
            0x00000000,
        },
        []u32{
            0x00000003,
            0xFFFFFFFD,
            0x00000000,
        },
        []u32{
            0x00000003,
            0xFFFFFFFE,
            0x00000000,
        },
        []u32{
            0x00000003,
            0xFFFFFFFF,
            0x00000000,
        },
        []u32{
            0x00000010,
            0x00000001,
            0x00000010,
        },
        []u32{
            0x00000010,
            0x00000002,
            0x00000008,
        },
        []u32{
            0x00000010,
            0x00000003,
            0x00000005,
        },
        []u32{
            0x00000010,
            0x00000010,
            0x00000001,
        },
        []u32{
            0x00000010,
            0x078644FA,
            0x00000000,
        },
        []u32{
            0x00000010,
            0x0747AE14,
            0x00000000,
        },
        []u32{
            0x00000010,
            0x7FFFFFFF,
            0x00000000,
        },
        []u32{
            0x00000010,
            0x80000000,
            0x00000000,
        },
        []u32{
            0x00000010,
            0xFFFFFFFD,
            0x00000000,
        },
        []u32{
            0x00000010,
            0xFFFFFFFE,
            0x00000000,
        },
        []u32{
            0x00000010,
            0xFFFFFFFF,
            0x00000000,
        },
        []u32{
            0x078644FA,
            0x00000001,
            0x078644FA,
        },
        []u32{
            0x078644FA,
            0x00000002,
            0x03C3227D,
        },
        []u32{
            0x078644FA,
            0x00000003,
            0x028216FE,
        },
        []u32{
            0x078644FA,
            0x00000010,
            0x0078644F,
        },
        []u32{
            0x078644FA,
            0x078644FA,
            0x00000001,
        },
        []u32{
            0x078644FA,
            0x0747AE14,
            0x00000001,
        },
        []u32{
            0x078644FA,
            0x7FFFFFFF,
            0x00000000,
        },
        []u32{
            0x078644FA,
            0x80000000,
            0x00000000,
        },
        []u32{
            0x078644FA,
            0xFFFFFFFD,
            0x00000000,
        },
        []u32{
            0x078644FA,
            0xFFFFFFFE,
            0x00000000,
        },
        []u32{
            0x078644FA,
            0xFFFFFFFF,
            0x00000000,
        },
        []u32{
            0x0747AE14,
            0x00000001,
            0x0747AE14,
        },
        []u32{
            0x0747AE14,
            0x00000002,
            0x03A3D70A,
        },
        []u32{
            0x0747AE14,
            0x00000003,
            0x026D3A06,
        },
        []u32{
            0x0747AE14,
            0x00000010,
            0x00747AE1,
        },
        []u32{
            0x0747AE14,
            0x078644FA,
            0x00000000,
        },
        []u32{
            0x0747AE14,
            0x0747AE14,
            0x00000001,
        },
        []u32{
            0x0747AE14,
            0x7FFFFFFF,
            0x00000000,
        },
        []u32{
            0x0747AE14,
            0x80000000,
            0x00000000,
        },
        []u32{
            0x0747AE14,
            0xFFFFFFFD,
            0x00000000,
        },
        []u32{
            0x0747AE14,
            0xFFFFFFFE,
            0x00000000,
        },
        []u32{
            0x0747AE14,
            0xFFFFFFFF,
            0x00000000,
        },
        []u32{
            0x7FFFFFFF,
            0x00000001,
            0x7FFFFFFF,
        },
        []u32{
            0x7FFFFFFF,
            0x00000002,
            0x3FFFFFFF,
        },
        []u32{
            0x7FFFFFFF,
            0x00000003,
            0x2AAAAAAA,
        },
        []u32{
            0x7FFFFFFF,
            0x00000010,
            0x07FFFFFF,
        },
        []u32{
            0x7FFFFFFF,
            0x078644FA,
            0x00000011,
        },
        []u32{
            0x7FFFFFFF,
            0x0747AE14,
            0x00000011,
        },
        []u32{
            0x7FFFFFFF,
            0x7FFFFFFF,
            0x00000001,
        },
        []u32{
            0x7FFFFFFF,
            0x80000000,
            0x00000000,
        },
        []u32{
            0x7FFFFFFF,
            0xFFFFFFFD,
            0x00000000,
        },
        []u32{
            0x7FFFFFFF,
            0xFFFFFFFE,
            0x00000000,
        },
        []u32{
            0x7FFFFFFF,
            0xFFFFFFFF,
            0x00000000,
        },
        []u32{
            0x80000000,
            0x00000001,
            0x80000000,
        },
        []u32{
            0x80000000,
            0x00000002,
            0x40000000,
        },
        []u32{
            0x80000000,
            0x00000003,
            0x2AAAAAAA,
        },
        []u32{
            0x80000000,
            0x00000010,
            0x08000000,
        },
        []u32{
            0x80000000,
            0x078644FA,
            0x00000011,
        },
        []u32{
            0x80000000,
            0x0747AE14,
            0x00000011,
        },
        []u32{
            0x80000000,
            0x7FFFFFFF,
            0x00000001,
        },
        []u32{
            0x80000000,
            0x80000000,
            0x00000001,
        },
        []u32{
            0x80000000,
            0xFFFFFFFD,
            0x00000000,
        },
        []u32{
            0x80000000,
            0xFFFFFFFE,
            0x00000000,
        },
        []u32{
            0x80000000,
            0xFFFFFFFF,
            0x00000000,
        },
        []u32{
            0xFFFFFFFD,
            0x00000001,
            0xFFFFFFFD,
        },
        []u32{
            0xFFFFFFFD,
            0x00000002,
            0x7FFFFFFE,
        },
        []u32{
            0xFFFFFFFD,
            0x00000003,
            0x55555554,
        },
        []u32{
            0xFFFFFFFD,
            0x00000010,
            0x0FFFFFFF,
        },
        []u32{
            0xFFFFFFFD,
            0x078644FA,
            0x00000022,
        },
        []u32{
            0xFFFFFFFD,
            0x0747AE14,
            0x00000023,
        },
        []u32{
            0xFFFFFFFD,
            0x7FFFFFFF,
            0x00000001,
        },
        []u32{
            0xFFFFFFFD,
            0x80000000,
            0x00000001,
        },
        []u32{
            0xFFFFFFFD,
            0xFFFFFFFD,
            0x00000001,
        },
        []u32{
            0xFFFFFFFD,
            0xFFFFFFFE,
            0x00000000,
        },
        []u32{
            0xFFFFFFFD,
            0xFFFFFFFF,
            0x00000000,
        },
        []u32{
            0xFFFFFFFE,
            0x00000001,
            0xFFFFFFFE,
        },
        []u32{
            0xFFFFFFFE,
            0x00000002,
            0x7FFFFFFF,
        },
        []u32{
            0xFFFFFFFE,
            0x00000003,
            0x55555554,
        },
        []u32{
            0xFFFFFFFE,
            0x00000010,
            0x0FFFFFFF,
        },
        []u32{
            0xFFFFFFFE,
            0x078644FA,
            0x00000022,
        },
        []u32{
            0xFFFFFFFE,
            0x0747AE14,
            0x00000023,
        },
        []u32{
            0xFFFFFFFE,
            0x7FFFFFFF,
            0x00000002,
        },
        []u32{
            0xFFFFFFFE,
            0x80000000,
            0x00000001,
        },
        []u32{
            0xFFFFFFFE,
            0xFFFFFFFD,
            0x00000001,
        },
        []u32{
            0xFFFFFFFE,
            0xFFFFFFFE,
            0x00000001,
        },
        []u32{
            0xFFFFFFFE,
            0xFFFFFFFF,
            0x00000000,
        },
        []u32{
            0xFFFFFFFF,
            0x00000001,
            0xFFFFFFFF,
        },
        []u32{
            0xFFFFFFFF,
            0x00000002,
            0x7FFFFFFF,
        },
        []u32{
            0xFFFFFFFF,
            0x00000003,
            0x55555555,
        },
        []u32{
            0xFFFFFFFF,
            0x00000010,
            0x0FFFFFFF,
        },
        []u32{
            0xFFFFFFFF,
            0x078644FA,
            0x00000022,
        },
        []u32{
            0xFFFFFFFF,
            0x0747AE14,
            0x00000023,
        },
        []u32{
            0xFFFFFFFF,
            0x7FFFFFFF,
            0x00000002,
        },
        []u32{
            0xFFFFFFFF,
            0x80000000,
            0x00000001,
        },
        []u32{
            0xFFFFFFFF,
            0xFFFFFFFD,
            0x00000001,
        },
        []u32{
            0xFFFFFFFF,
            0xFFFFFFFE,
            0x00000001,
        },
        []u32{
            0xFFFFFFFF,
            0xFFFFFFFF,
            0x00000001,
        },
    };

    for (cases) |case| {
        test_one_udivsi3(case[0], case[1], case[2]);
    }
}

fn test_one_udivsi3(a: u32, b: u32, expected_q: u32) void {
    const q: u32 = __udivsi3(a, b);
    testing.expect(q == expected_q);
}
