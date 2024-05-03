const std = @import("std");

pub const SomeStruct = extern struct {
    x: u8,
};

extern fn viaStructExtern(value: SomeStruct) callconv(.C) void;
extern fn viaStructPtrExtern(value: *const SomeStruct) callconv(.C) void;
extern fn viaValueExtern(value: u8) callconv(.C) void;

pub fn main() !void {
    const value = SomeStruct{ .x = 11 };
    std.debug.print("main {}\n", .{value});

    var lib = try std.DynLib.open("./repo.dll");
    defer lib.close();

    const viaStructDynLib = lib.lookup(*const fn (value: SomeStruct) void, "viaStructDynLib").?;
    viaStructDynLib(value);
    viaStructExtern(value);

    // const viaStructPtrDynLib = lib.lookup(*const fn (value: *const SomeStruct) void, "viaStructPtrDynLib").?;
    // viaStructPtrDynLib(&value);
    // viaStructPtrExtern(&value);

    // const viaValueDynLib = lib.lookup(*const fn (value: u8) void, "viaValueDynLib").?;
    // viaValueDynLib(value.x);
    // viaValueExtern(value.x);
}
