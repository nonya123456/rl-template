const std = @import("std");
const Allocator = std.mem.Allocator;

const rl = @import("raylib");

const Context = @import("../Context.zig");
const common = @import("common.zig");
const SceneKind = common.SceneKind;

pub const Scene = struct {
    alloc: Allocator,
    ctx: *Context,
    next_scene: ?SceneKind = null,

    pub fn init(alloc: Allocator, ctx: *Context) Scene {
        return .{
            .alloc = alloc,
            .ctx = ctx,
        };
    }

    pub fn deinit(_: *Scene) void {}

    pub fn update(_: *Scene) void {}

    pub fn draw(_: *Scene) void {
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(.ray_white);
    }
};
