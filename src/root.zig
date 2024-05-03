const std = @import("std");

pub const SomeStruct = extern struct {
    x: u8,
};

export fn viaStruct(value: SomeStruct) callconv(.C) void {
    std.debug.print("{}\n", .{value});
}
