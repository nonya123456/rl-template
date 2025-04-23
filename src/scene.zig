const std = @import("std");
const Allocator = std.mem.Allocator;

const Context = @import("Context.zig");
const common = @import("scene/common.zig");
pub const SceneKind = common.SceneKind;
const game = @import("scene/game.zig");

pub const Scene = union(SceneKind) {
    game: game.Scene,

    pub fn init(alloc: Allocator, kind: SceneKind, ctx: *Context) Scene {
        return switch (kind) {
            .game => .{ .game = .init(alloc, ctx) },
        };
    }
    pub fn deinit(self: *Scene) void {
        switch (self.*) {
            .game => self.game.deinit(),
        }
    }

    pub fn update(self: *Scene) void {
        switch (self.*) {
            .game => self.game.update(),
        }
    }

    pub fn draw(self: *Scene) void {
        switch (self.*) {
            .game => self.game.draw(),
        }
    }

    pub fn nextScene(self: Scene) ?SceneKind {
        return switch (self) {
            .game => |s| s.next_scene,
        };
    }
};
