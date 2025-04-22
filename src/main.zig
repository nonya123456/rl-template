const std = @import("std");
const builtin = @import("builtin");

const rl = @import("raylib");

const State = @import("State.zig");

pub fn main() !void {
    rl.initWindow(1280, 720, "rl-template");
    defer rl.closeWindow();

    var da = std.heap.DebugAllocator(.{}){};
    defer if (comptime builtin.mode == .Debug) {
        _ = da.detectLeaks();
    };
    const alloc = da.allocator();

    var state = State.init(alloc);
    defer state.deinit();

    state.changeScene(.sample);

    while (!rl.windowShouldClose()) {
        state.scene.?.update();
        state.scene.?.draw();

        if (state.scene.?.nextScene()) |kind| {
            state.changeScene(kind);
        }
    }
}
