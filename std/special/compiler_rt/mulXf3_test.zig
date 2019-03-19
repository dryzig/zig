// Ported from:
//
// https://github.com/llvm/llvm-project/blob/2ffb1b0413efa9a24eb3c49e710e36f92e2cb50b/compiler-rt/test/builtins/Unit/multf3_test.c

const qnan128 = @bitCast(f128, u128(0x7fff800000000000) << 64);
const inf128 = @bitCast(f128, u128(0x7fff000000000000) << 64);

const __multf3 = @import("mulXf3.zig").__multf3;

fn test__multf3(a: f128, b: f128, expected_hi: u64, expected_lo: u64) void {
    const x = __multf3(a, b);

    const rep = @bitCast(u128, x);
    const hi = @intCast(u64, rep >> 64);
    const lo = @truncate(u64, rep);

    if (hi == expected_hi and lo == expected_lo) {
        return;
    }

    @panic("__multf3 test failure");
}

fn makeNaN128(rand: u64) f128 {
    return @bitCast(f128, u128(0x7fff000000000000 | (rand & 0xffffffffffff)) << 64);
}
test "multf3" {
    // qNaN * any = qNaN
    test__multf3(qnan128, 0x1.23456789abcdefp+5, 0x7fff800000000000, 0x0);

    // NaN * any = NaN
    test__multf3(makeNaN128(0x800030000000), 0x1.23456789abcdefp+5, 0x7fff800000000000, 0x0);
    // inf * any = inf
    test__multf3(inf128, 0x1.23456789abcdefp+5, 0x7fff000000000000, 0x0);

    // any * any
    test__multf3(0x1.2eab345678439abcdefea56782346p+5, 0x1.edcb34a235253948765432134674fp-1, 0x400423e7f9e3c9fc, 0xd906c2c2a85777c4);

    test__multf3(0x1.353e45674d89abacc3a2ebf3ff4ffp-50, 0x1.ed8764648369535adf4be3214567fp-9, 0x3fc52a163c6223fc, 0xc94c4bf0430768b4);

    test__multf3(0x1.234425696abcad34a35eeffefdcbap+456, 0x451.ed98d76e5d46e5f24323dff21ffp+600, 0x44293a91de5e0e94, 0xe8ed17cc2cdf64ac);

    test__multf3(0x1.4356473c82a9fabf2d22ace345defp-234, 0x1.eda98765476743ab21da23d45678fp-455, 0x3d4f37c1a3137cae, 0xfc6807048bc2836a);

    test__multf3(0x1.23456734245345p-10000, 0x1.edcba524498724p-6497, 0x0, 0x0);
}
