const print = @import("std").debug.print;
const fmt = @import("std").fmt;

pub fn main() !void {
    const string = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d";

    const b64_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    var chars_num: u32 = 0;
    if (string.len / 6 == 0) {
        chars_num = string.len / 2;
    } else {
        chars_num = string.len + 1;
    }

    var bytes: [chars_num]u8 = undefined;
    fmt.hexToBytes(&bytes, string);

    print("'{s}'", .{bytes});

    const len = (string.len / 2 / 3) + 1;
    if (bytes.len % 3 != 0) {
        bytes ++ 0;
    }

    var b64_string: [len:0]u8 = undefined;
    var i: u32 = 0;
    var k: u32 = 0;
    while (i < (bytes.len * 6)) {
        var b64_i: u6 = 0;
        for (0..6) |j| {
            const index = i / 6;
            if (bytes[index] & @as(u8, 1) << @intCast(6 - j - 1) == 1) {
                b64_i = b64_i * 2 + 1;
            } else {
                b64_i *= 2;
            }
            i += 1;
        }
        b64_string[k] = b64_chars[b64_i];
        k += 1;
    }
    print("'{s}'", .{b64_string});
}
