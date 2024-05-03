const std = @import("std");

pub const SomeStruct = extern struct {
    x: u8,
};

fn viaStructDynLib(value: SomeStruct) callconv(.C) void {
    std.debug.print("viaStructDynLib {}\n", .{value});
}

export fn viaStructExtern(value: SomeStruct) callconv(.C) void {
    std.debug.print("viaStructExtern {}\n", .{value});
}

fn viaStructPtrDynLib(value: *const SomeStruct) callconv(.C) void {
    std.debug.print("viaStructPtrDynLib {}\n", .{value});
}

export fn viaStructPtrExtern(value: *const SomeStruct) callconv(.C) void {
    std.debug.print("viaStructPtrExtern {}\n", .{value});
}

fn viaValueDynLib(value: u8) callconv(.C) void {
    std.debug.print("viaValueDynLib {}\n", .{value});
}

export fn viaValueExtern(value: u8) callconv(.C) void {
    std.debug.print("viaValueExtern {}\n", .{value});
}

comptime {
    @export(viaStructDynLib, .{ .name = "viaStructDynLib" });
    @export(viaStructPtrDynLib, .{ .name = "viaStructPtrDynLib" });
    @export(viaValueDynLib, .{ .name = "viaValueDynLib" });
}
