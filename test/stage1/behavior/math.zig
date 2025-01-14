const std = @import("std");
const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;
const expectEqualSlices = std.testing.expectEqualSlices;
const maxInt = std.math.maxInt;
const minInt = std.math.minInt;

test "division" {
    testDivision();
    comptime testDivision();
}
fn testDivision() void {
    expect(div(u32, 13, 3) == 4);
    expect(div(f16, 1.0, 2.0) == 0.5);
    expect(div(f32, 1.0, 2.0) == 0.5);

    expect(divExact(u32, 55, 11) == 5);
    expect(divExact(i32, -55, 11) == -5);
    expect(divExact(f16, 55.0, 11.0) == 5.0);
    expect(divExact(f16, -55.0, 11.0) == -5.0);
    expect(divExact(f32, 55.0, 11.0) == 5.0);
    expect(divExact(f32, -55.0, 11.0) == -5.0);

    expect(divFloor(i32, 5, 3) == 1);
    expect(divFloor(i32, -5, 3) == -2);
    expect(divFloor(f16, 5.0, 3.0) == 1.0);
    expect(divFloor(f16, -5.0, 3.0) == -2.0);
    expect(divFloor(f32, 5.0, 3.0) == 1.0);
    expect(divFloor(f32, -5.0, 3.0) == -2.0);
    expect(divFloor(i32, -0x80000000, -2) == 0x40000000);
    expect(divFloor(i32, 0, -0x80000000) == 0);
    expect(divFloor(i32, -0x40000001, 0x40000000) == -2);
    expect(divFloor(i32, -0x80000000, 1) == -0x80000000);

    expect(divTrunc(i32, 5, 3) == 1);
    expect(divTrunc(i32, -5, 3) == -1);
    expect(divTrunc(f16, 5.0, 3.0) == 1.0);
    expect(divTrunc(f16, -5.0, 3.0) == -1.0);
    expect(divTrunc(f32, 5.0, 3.0) == 1.0);
    expect(divTrunc(f32, -5.0, 3.0) == -1.0);
    expect(divTrunc(f64, 5.0, 3.0) == 1.0);
    expect(divTrunc(f64, -5.0, 3.0) == -1.0);

    comptime {
        expect(
            1194735857077236777412821811143690633098347576 % 508740759824825164163191790951174292733114988 == 177254337427586449086438229241342047632117600,
        );
        expect(
            @rem(-1194735857077236777412821811143690633098347576, 508740759824825164163191790951174292733114988) == -177254337427586449086438229241342047632117600,
        );
        expect(
            1194735857077236777412821811143690633098347576 / 508740759824825164163191790951174292733114988 == 2,
        );
        expect(
            @divTrunc(-1194735857077236777412821811143690633098347576, 508740759824825164163191790951174292733114988) == -2,
        );
        expect(
            @divTrunc(1194735857077236777412821811143690633098347576, -508740759824825164163191790951174292733114988) == -2,
        );
        expect(
            @divTrunc(-1194735857077236777412821811143690633098347576, -508740759824825164163191790951174292733114988) == 2,
        );
        expect(
            4126227191251978491697987544882340798050766755606969681711 % 10 == 1,
        );
    }
}
fn div(comptime T: type, a: T, b: T) T {
    return a / b;
}
fn divExact(comptime T: type, a: T, b: T) T {
    return @divExact(a, b);
}
fn divFloor(comptime T: type, a: T, b: T) T {
    return @divFloor(a, b);
}
fn divTrunc(comptime T: type, a: T, b: T) T {
    return @divTrunc(a, b);
}

test "@addWithOverflow" {
    var result: u8 = undefined;
    expect(@addWithOverflow(u8, 250, 100, &result));
    expect(!@addWithOverflow(u8, 100, 150, &result));
    expect(result == 250);
}

// TODO test mulWithOverflow
// TODO test subWithOverflow

test "@shlWithOverflow" {
    var result: u16 = undefined;
    expect(@shlWithOverflow(u16, 0b0010111111111111, 3, &result));
    expect(!@shlWithOverflow(u16, 0b0010111111111111, 2, &result));
    expect(result == 0b1011111111111100);
}

test "@clz" {
    testClz();
    comptime testClz();
}

fn testClz() void {
    expect(clz(u8(0b00001010)) == 4);
    expect(clz(u8(0b10001010)) == 0);
    expect(clz(u8(0b00000000)) == 8);
    expect(clz(u128(0xffffffffffffffff)) == 64);
    expect(clz(u128(0x10000000000000000)) == 63);
}

fn clz(x: var) usize {
    return @clz(x);
}

test "@ctz" {
    testCtz();
    comptime testCtz();
}

fn testCtz() void {
    expect(ctz(u8(0b10100000)) == 5);
    expect(ctz(u8(0b10001010)) == 1);
    expect(ctz(u8(0b00000000)) == 8);
}

fn ctz(x: var) usize {
    return @ctz(x);
}

test "assignment operators" {
    var i: u32 = 0;
    i += 5;
    expect(i == 5);
    i -= 2;
    expect(i == 3);
    i *= 20;
    expect(i == 60);
    i /= 3;
    expect(i == 20);
    i %= 11;
    expect(i == 9);
    i <<= 1;
    expect(i == 18);
    i >>= 2;
    expect(i == 4);
    i = 6;
    i &= 5;
    expect(i == 4);
    i ^= 6;
    expect(i == 2);
    i = 6;
    i |= 3;
    expect(i == 7);
}

test "three expr in a row" {
    testThreeExprInARow(false, true);
    comptime testThreeExprInARow(false, true);
}
fn testThreeExprInARow(f: bool, t: bool) void {
    assertFalse(f or f or f);
    assertFalse(t and t and f);
    assertFalse(1 | 2 | 4 != 7);
    assertFalse(3 ^ 6 ^ 8 != 13);
    assertFalse(7 & 14 & 28 != 4);
    assertFalse(9 << 1 << 2 != 9 << 3);
    assertFalse(90 >> 1 >> 2 != 90 >> 3);
    assertFalse(100 - 1 + 1000 != 1099);
    assertFalse(5 * 4 / 2 % 3 != 1);
    assertFalse(i32(i32(5)) != 5);
    assertFalse(!!false);
    assertFalse(i32(7) != --(i32(7)));
}
fn assertFalse(b: bool) void {
    expect(!b);
}

test "const number literal" {
    const one = 1;
    const eleven = ten + one;

    expect(eleven == 11);
}
const ten = 10;

test "unsigned wrapping" {
    testUnsignedWrappingEval(maxInt(u32));
    comptime testUnsignedWrappingEval(maxInt(u32));
}
fn testUnsignedWrappingEval(x: u32) void {
    const zero = x +% 1;
    expect(zero == 0);
    const orig = zero -% 1;
    expect(orig == maxInt(u32));
}

test "signed wrapping" {
    testSignedWrappingEval(maxInt(i32));
    comptime testSignedWrappingEval(maxInt(i32));
}
fn testSignedWrappingEval(x: i32) void {
    const min_val = x +% 1;
    expect(min_val == minInt(i32));
    const max_val = min_val -% 1;
    expect(max_val == maxInt(i32));
}

test "negation wrapping" {
    testNegationWrappingEval(minInt(i16));
    comptime testNegationWrappingEval(minInt(i16));
}
fn testNegationWrappingEval(x: i16) void {
    expect(x == -32768);
    const neg = -%x;
    expect(neg == -32768);
}

test "unsigned 64-bit division" {
    test_u64_div();
    comptime test_u64_div();
}
fn test_u64_div() void {
    const result = divWithResult(1152921504606846976, 34359738365);
    expect(result.quotient == 33554432);
    expect(result.remainder == 100663296);
}
fn divWithResult(a: u64, b: u64) DivResult {
    return DivResult{
        .quotient = a / b,
        .remainder = a % b,
    };
}
const DivResult = struct {
    quotient: u64,
    remainder: u64,
};

test "binary not" {
    expect(comptime x: {
        break :x ~u16(0b1010101010101010) == 0b0101010101010101;
    });
    expect(comptime x: {
        break :x ~u64(2147483647) == 18446744071562067968;
    });
    testBinaryNot(0b1010101010101010);
}

fn testBinaryNot(x: u16) void {
    expect(~x == 0b0101010101010101);
}

test "small int addition" {
    var x: @IntType(false, 2) = 0;
    expect(x == 0);

    x += 1;
    expect(x == 1);

    x += 1;
    expect(x == 2);

    x += 1;
    expect(x == 3);

    var result: @typeOf(x) = 3;
    expect(@addWithOverflow(@typeOf(x), x, 1, &result));

    expect(result == 0);
}

test "float equality" {
    const x: f64 = 0.012;
    const y: f64 = x + 1.0;

    testFloatEqualityImpl(x, y);
    comptime testFloatEqualityImpl(x, y);
}

fn testFloatEqualityImpl(x: f64, y: f64) void {
    const y2 = x + 1.0;
    expect(y == y2);
}

test "allow signed integer division/remainder when values are comptime known and positive or exact" {
    expect(5 / 3 == 1);
    expect(-5 / -3 == 1);
    expect(-6 / 3 == -2);

    expect(5 % 3 == 2);
    expect(-6 % 3 == 0);
}

test "hex float literal parsing" {
    comptime expect(0x1.0 == 1.0);
}

test "quad hex float literal parsing in range" {
    const a = 0x1.af23456789bbaaab347645365cdep+5;
    const b = 0x1.dedafcff354b6ae9758763545432p-9;
    const c = 0x1.2f34dd5f437e849b4baab754cdefp+4534;
    const d = 0x1.edcbff8ad76ab5bf46463233214fp-435;
}

test "quad hex float literal parsing accurate" {
    const a: f128 = 0x1.1111222233334444555566667777p+0;

    // implied 1 is dropped, with an exponent of 0 (0x3fff) after biasing.
    const expected: u128 = 0x3fff1111222233334444555566667777;
    expect(@bitCast(u128, a) == expected);

    // non-normalized
    const b: f128 = 0x11.111222233334444555566667777p-4;
    expect(@bitCast(u128, b) == expected);

    const S = struct {
        fn doTheTest() void {
            {
                var f: f128 = 0x1.2eab345678439abcdefea56782346p+5;
                expect(@bitCast(u128, f) == 0x40042eab345678439abcdefea5678234);
            }
            {
                var f: f128 = 0x1.edcb34a235253948765432134674fp-1;
                expect(@bitCast(u128, f) == 0x3ffeedcb34a235253948765432134674);
            }
            {
                var f: f128 = 0x1.353e45674d89abacc3a2ebf3ff4ffp-50;
                expect(@bitCast(u128, f) == 0x3fcd353e45674d89abacc3a2ebf3ff4f);
            }
            {
                var f: f128 = 0x1.ed8764648369535adf4be3214567fp-9;
                expect(@bitCast(u128, f) == 0x3ff6ed8764648369535adf4be3214567);
            }
            const exp2ft = []f64{
                0x1.6a09e667f3bcdp-1,
                0x1.7a11473eb0187p-1,
                0x1.8ace5422aa0dbp-1,
                0x1.9c49182a3f090p-1,
                0x1.ae89f995ad3adp-1,
                0x1.c199bdd85529cp-1,
                0x1.d5818dcfba487p-1,
                0x1.ea4afa2a490dap-1,
                0x1.0000000000000p+0,
                0x1.0b5586cf9890fp+0,
                0x1.172b83c7d517bp+0,
                0x1.2387a6e756238p+0,
                0x1.306fe0a31b715p+0,
                0x1.3dea64c123422p+0,
                0x1.4bfdad5362a27p+0,
                0x1.5ab07dd485429p+0,
                0x1.8p23,
                0x1.62e430p-1,
                0x1.ebfbe0p-3,
                0x1.c6b348p-5,
                0x1.3b2c9cp-7,
                0x1.0p127,
                -0x1.0p-149,
            };

            const answers = []u64{
                0x3fe6a09e667f3bcd,
                0x3fe7a11473eb0187,
                0x3fe8ace5422aa0db,
                0x3fe9c49182a3f090,
                0x3feae89f995ad3ad,
                0x3fec199bdd85529c,
                0x3fed5818dcfba487,
                0x3feea4afa2a490da,
                0x3ff0000000000000,
                0x3ff0b5586cf9890f,
                0x3ff172b83c7d517b,
                0x3ff2387a6e756238,
                0x3ff306fe0a31b715,
                0x3ff3dea64c123422,
                0x3ff4bfdad5362a27,
                0x3ff5ab07dd485429,
                0x4168000000000000,
                0x3fe62e4300000000,
                0x3fcebfbe00000000,
                0x3fac6b3480000000,
                0x3f83b2c9c0000000,
                0x47e0000000000000,
                0xb6a0000000000000,
            };

            for (exp2ft) |x, i| {
                expect(@bitCast(u64, x) == answers[i]);
            }
        }
    };
    S.doTheTest();
    comptime S.doTheTest();
}

test "hex float literal within range" {
    const a = 0x1.0p16383;
    const b = 0x0.1p16387;
    const c = 0x1.0p-16382;
}

test "truncating shift left" {
    testShlTrunc(maxInt(u16));
    comptime testShlTrunc(maxInt(u16));
}
fn testShlTrunc(x: u16) void {
    const shifted = x << 1;
    expect(shifted == 65534);
}

test "truncating shift right" {
    testShrTrunc(maxInt(u16));
    comptime testShrTrunc(maxInt(u16));
}
fn testShrTrunc(x: u16) void {
    const shifted = x >> 1;
    expect(shifted == 32767);
}

test "exact shift left" {
    testShlExact(0b00110101);
    comptime testShlExact(0b00110101);
}
fn testShlExact(x: u8) void {
    const shifted = @shlExact(x, 2);
    expect(shifted == 0b11010100);
}

test "exact shift right" {
    testShrExact(0b10110100);
    comptime testShrExact(0b10110100);
}
fn testShrExact(x: u8) void {
    const shifted = @shrExact(x, 2);
    expect(shifted == 0b00101101);
}

test "comptime_int addition" {
    comptime {
        expect(35361831660712422535336160538497375248 + 101752735581729509668353361206450473702 == 137114567242441932203689521744947848950);
        expect(594491908217841670578297176641415611445982232488944558774612 + 390603545391089362063884922208143568023166603618446395589768 == 985095453608931032642182098849559179469148836107390954364380);
    }
}

test "comptime_int multiplication" {
    comptime {
        expect(
            45960427431263824329884196484953148229 * 128339149605334697009938835852565949723 == 5898522172026096622534201617172456926982464453350084962781392314016180490567,
        );
        expect(
            594491908217841670578297176641415611445982232488944558774612 * 390603545391089362063884922208143568023166603618446395589768 == 232210647056203049913662402532976186578842425262306016094292237500303028346593132411865381225871291702600263463125370016,
        );
    }
}

test "comptime_int shifting" {
    comptime {
        expect((u128(1) << 127) == 0x80000000000000000000000000000000);
    }
}

test "comptime_int multi-limb shift and mask" {
    comptime {
        var a = 0xefffffffa0000001eeeeeeefaaaaaaab;

        expect(u32(a & 0xffffffff) == 0xaaaaaaab);
        a >>= 32;
        expect(u32(a & 0xffffffff) == 0xeeeeeeef);
        a >>= 32;
        expect(u32(a & 0xffffffff) == 0xa0000001);
        a >>= 32;
        expect(u32(a & 0xffffffff) == 0xefffffff);
        a >>= 32;

        expect(a == 0);
    }
}

test "comptime_int multi-limb partial shift right" {
    comptime {
        var a = 0x1ffffffffeeeeeeee;
        a >>= 16;
        expect(a == 0x1ffffffffeeee);
    }
}

test "xor" {
    test_xor();
    comptime test_xor();
}

fn test_xor() void {
    expect(0xFF ^ 0x00 == 0xFF);
    expect(0xF0 ^ 0x0F == 0xFF);
    expect(0xFF ^ 0xF0 == 0x0F);
    expect(0xFF ^ 0x0F == 0xF0);
    expect(0xFF ^ 0xFF == 0x00);
}

test "comptime_int xor" {
    comptime {
        expect(0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF ^ 0x00000000000000000000000000000000 == 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF);
        expect(0xFFFFFFFFFFFFFFFF0000000000000000 ^ 0x0000000000000000FFFFFFFFFFFFFFFF == 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF);
        expect(0xFFFFFFFFFFFFFFFF0000000000000000 ^ 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF == 0x0000000000000000FFFFFFFFFFFFFFFF);
        expect(0x0000000000000000FFFFFFFFFFFFFFFF ^ 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF == 0xFFFFFFFFFFFFFFFF0000000000000000);
        expect(0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF ^ 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF == 0x00000000000000000000000000000000);
        expect(0xFFFFFFFF00000000FFFFFFFF00000000 ^ 0x00000000FFFFFFFF00000000FFFFFFFF == 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF);
        expect(0xFFFFFFFF00000000FFFFFFFF00000000 ^ 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF == 0x00000000FFFFFFFF00000000FFFFFFFF);
        expect(0x00000000FFFFFFFF00000000FFFFFFFF ^ 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF == 0xFFFFFFFF00000000FFFFFFFF00000000);
    }
}

test "f128" {
    test_f128();
    comptime test_f128();
}

fn make_f128(x: f128) f128 {
    return x;
}

fn test_f128() void {
    expect(@sizeOf(f128) == 16);
    expect(make_f128(1.0) == 1.0);
    expect(make_f128(1.0) != 1.1);
    expect(make_f128(1.0) > 0.9);
    expect(make_f128(1.0) >= 0.9);
    expect(make_f128(1.0) >= 1.0);
    should_not_be_zero(1.0);
}

fn should_not_be_zero(x: f128) void {
    expect(x != 0.0);
}

test "comptime float rem int" {
    comptime {
        var x = f32(1) % 2;
        expect(x == 1.0);
    }
}

test "remainder division" {
    comptime remdiv(f16);
    comptime remdiv(f32);
    comptime remdiv(f64);
    comptime remdiv(f128);
    remdiv(f16);
    remdiv(f64);
    remdiv(f128);
}

fn remdiv(comptime T: type) void {
    expect(T(1) == T(1) % T(2));
    expect(T(1) == T(7) % T(3));
}

test "@sqrt" {
    testSqrt(f64, 12.0);
    comptime testSqrt(f64, 12.0);
    testSqrt(f32, 13.0);
    comptime testSqrt(f32, 13.0);
    testSqrt(f16, 13.0);
    comptime testSqrt(f16, 13.0);

    const x = 14.0;
    const y = x * x;
    const z = @sqrt(@typeOf(y), y);
    comptime expect(z == x);
}

fn testSqrt(comptime T: type, x: T) void {
    expect(@sqrt(T, x * x) == x);
}

test "comptime_int param and return" {
    const a = comptimeAdd(35361831660712422535336160538497375248, 101752735581729509668353361206450473702);
    expect(a == 137114567242441932203689521744947848950);

    const b = comptimeAdd(594491908217841670578297176641415611445982232488944558774612, 390603545391089362063884922208143568023166603618446395589768);
    expect(b == 985095453608931032642182098849559179469148836107390954364380);
}

fn comptimeAdd(comptime a: comptime_int, comptime b: comptime_int) comptime_int {
    return a + b;
}

test "vector integer addition" {
    const S = struct {
        fn doTheTest() void {
            var a: @Vector(4, i32) = []i32{ 1, 2, 3, 4 };
            var b: @Vector(4, i32) = []i32{ 5, 6, 7, 8 };
            var result = a + b;
            var result_array: [4]i32 = result;
            const expected = []i32{ 6, 8, 10, 12 };
            expectEqualSlices(i32, &expected, &result_array);
        }
    };
    S.doTheTest();
    comptime S.doTheTest();
}
