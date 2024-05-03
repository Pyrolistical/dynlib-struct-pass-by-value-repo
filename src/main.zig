const std = @import("std");

pub const SomeStruct = extern struct {
    x: u8,
};

extern fn viaStruct(value: SomeStruct) callconv(.C) void;

pub fn main() !void {
    const value = SomeStruct{ .x = 11 };
    std.debug.print("main {}\n", .{value});

    var lib = try std.DynLib.open("./repo.dll");
    defer lib.close();

    const viaStructDynLib = lib.lookup(*const fn (value: SomeStruct) void, "viaStruct").?;

    std.debug.print("viaStructDynLib ", .{});
    viaStructDynLib(value);

    std.debug.print("viaStruct ", .{});
    viaStruct(value);
}
