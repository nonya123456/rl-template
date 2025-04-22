const std = @import("std");
const Allocator = std.mem.Allocator;

const Context = @import("Context.zig");
const common = @import("scene/common.zig");
pub const SceneKind = common.SceneKind;
const sample = @import("scene/sample.zig");

pub const Scene = union(SceneKind) {
    sample: sample.Scene,

    pub fn init(alloc: Allocator, kind: SceneKind, ctx: *Context) Scene {
        return switch (kind) {
            .sample => .{ .sample = .init(alloc, ctx) },
        };
    }
    pub fn deinit(self: *Scene) void {
        switch (self.*) {
            .sample => self.sample.deinit(),
        }
    }

    pub fn update(self: *Scene) void {
        switch (self.*) {
            .sample => self.sample.update(),
        }
    }

    pub fn draw(self: *Scene) void {
        switch (self.*) {
            .sample => self.sample.draw(),
        }
    }

    pub fn nextScene(self: Scene) ?SceneKind {
        return switch (self) {
            .sample => |s| s.next_scene,
        };
    }
};
