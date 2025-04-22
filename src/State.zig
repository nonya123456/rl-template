const std = @import("std");
const Allocator = std.mem.Allocator;

const Context = @import("Context.zig");
const scenepkg = @import("scene.zig");
const Scene = scenepkg.Scene;
const SceneKind = scenepkg.SceneKind;

const Self = @This();

alloc: Allocator,

ctx: Context,
scene: ?Scene = null,

pub fn init(alloc: Allocator) Self {
    return .{
        .alloc = alloc,
        .ctx = .init(),
    };
}

pub fn deinit(self: *Self) void {
    if (self.scene) |*scene| {
        scene.deinit();
    }
}

pub fn changeScene(self: *Self, kind: SceneKind) void {
    if (self.scene) |*scene| {
        scene.deinit();
    }

    self.scene = .init(self.alloc, kind, &self.ctx);
}
