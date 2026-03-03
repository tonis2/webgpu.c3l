module wgpu;

// GpuBuffer bundles a WebGPU buffer handle with its size.
// Size is stored alongside the handle because it is needed for uploads,
// region sizing, and pass encoder bindings.
struct GpuBuffer {
    Buffer handle;
    ulong  size;
}

// Create a buffer with the given usage flags and size.
// Usage example:
//   GpuBuffer vb = gpu_buffer(device, BUFFER_USAGE_VERTEX | BUFFER_USAGE_COPY_DST, byte_size);
//   vb.upload(queue, vertices.ptr, byte_size);
fn GpuBuffer gpu_buffer(Device device, BufferUsage usage, ulong size) {
    BufferDescriptor desc = {
        .usage = usage,
        .size  = size,
    };
    return { .handle = deviceCreateBuffer(device, &desc), .size = size };
}

// Upload CPU data to the buffer via queueWriteBuffer.
// offset: byte offset within the buffer to start writing (default 0).
fn void GpuBuffer.upload(GpuBuffer* self, Queue queue, void* data, usz size, ulong offset = 0) {
    queueWriteBuffer(queue, self.handle, offset, data, size);
}

// Destroy the buffer and release its GPU memory.
fn void GpuBuffer.destroy(GpuBuffer* self) {
    bufferDestroy(self.handle);
}

// BufferRegion is a sub-range within a GpuBuffer.
// Useful for batching many small writes (per-object uniforms, dynamic vertex data)
// into a single large buffer and then binding sub-ranges of it.
//
// Usage example:
//   GpuBuffer pool = GpuBuffer.create(device, BUFFER_USAGE_UNIFORM | BUFFER_USAGE_COPY_DST, 64 * 1024);
//   BufferRegion camera  = { .buffer = &pool, .offset = 0,   .size = 256 };
//   BufferRegion objects = { .buffer = &pool, .offset = 256, .size = 64 * 1024 - 256 };
//
//   // Each frame:
//   camera.reset();
//   camera.push(queue, &cam_data, CameraUniforms.sizeof);
//   objects.reset();
//   foreach (obj : scene) objects.push(queue, &obj.uniforms, ObjectUniforms.sizeof);
struct BufferRegion {
    GpuBuffer* buffer;   // backing buffer
    ulong      offset;   // base byte offset within the buffer
    ulong      size;     // total byte capacity of this region
    ulong      used;     // bytes written since last reset()
}

// Push data into the region, advancing the write cursor.
fn void BufferRegion.push(BufferRegion* self, Queue queue, void* data, usz data_size) {
    queueWriteBuffer(queue, self.buffer.handle, self.offset + self.used, data, data_size);
    self.used += data_size;
}

// Reset the write cursor to the start of the region.
// Call at the beginning of each frame for per-frame data pools.
fn void BufferRegion.reset(BufferRegion* self) {
    self.used = 0;
}

// Return the number of bytes remaining in this region.
fn ulong BufferRegion.remaining(BufferRegion* self) {
    return self.size - self.used;
}
