module wgpu;

// Top-level functions
extern fn Instance createInstance(InstanceDescriptor* descriptor) @cname("wgpuCreateInstance");
extern fn void getInstanceFeatures(SupportedInstanceFeatures* features) @cname("wgpuGetInstanceFeatures");
extern fn Status getInstanceLimits(InstanceLimits* limits) @cname("wgpuGetInstanceLimits");
extern fn bool hasInstanceFeature(InstanceFeatureName feature) @cname("wgpuHasInstanceFeature");

// Adapter methods
extern fn Status adapterGetLimits(Adapter self, Limits* limits) @cname("wgpuAdapterGetLimits");
extern fn bool adapterHasFeature(Adapter self, FeatureName feature) @cname("wgpuAdapterHasFeature");
extern fn void adapterGetFeatures(Adapter self, SupportedFeatures* features) @cname("wgpuAdapterGetFeatures");
extern fn Status adapterGetInfo(Adapter self, AdapterInfo* info) @cname("wgpuAdapterGetInfo");
extern fn Future adapterRequestDevice(Adapter self, DeviceDescriptor* descriptor, RequestDeviceCallbackInfo callback_info) @cname("wgpuAdapterRequestDevice");

// BindGroup methods
extern fn void bindGroupSetLabel(BindGroup self, StringView label) @cname("wgpuBindGroupSetLabel");

// BindGroupLayout methods
extern fn void bindGroupLayoutSetLabel(BindGroupLayout self, StringView label) @cname("wgpuBindGroupLayoutSetLabel");

// Buffer methods
extern fn Future bufferMapAsync(Buffer self, MapMode mode, usz offset, usz size, BufferMapCallbackInfo callback_info) @cname("wgpuBufferMapAsync");
extern fn void* bufferGetMappedRange(Buffer self, usz offset, usz size) @cname("wgpuBufferGetMappedRange");
extern fn void* bufferGetConstMappedRange(Buffer self, usz offset, usz size) @cname("wgpuBufferGetConstMappedRange");
extern fn Status bufferReadMappedRange(Buffer self, usz offset, void* data, usz size) @cname("wgpuBufferReadMappedRange");
extern fn Status bufferWriteMappedRange(Buffer self, usz offset, void* data, usz size) @cname("wgpuBufferWriteMappedRange");
extern fn void bufferSetLabel(Buffer self, StringView label) @cname("wgpuBufferSetLabel");
extern fn BufferUsage bufferGetUsage(Buffer self) @cname("wgpuBufferGetUsage");
extern fn ulong bufferGetSize(Buffer self) @cname("wgpuBufferGetSize");
extern fn BufferMapState bufferGetMapState(Buffer self) @cname("wgpuBufferGetMapState");
extern fn void bufferUnmap(Buffer self) @cname("wgpuBufferUnmap");
extern fn void bufferDestroy(Buffer self) @cname("wgpuBufferDestroy");

// CommandBuffer methods
extern fn void commandBufferSetLabel(CommandBuffer self, StringView label) @cname("wgpuCommandBufferSetLabel");

// CommandEncoder methods
extern fn CommandBuffer commandEncoderFinish(CommandEncoder self, CommandBufferDescriptor* descriptor) @cname("wgpuCommandEncoderFinish");
extern fn ComputePassEncoder commandEncoderBeginComputePass(CommandEncoder self, ComputePassDescriptor* descriptor) @cname("wgpuCommandEncoderBeginComputePass");
extern fn RenderPassEncoder commandEncoderBeginRenderPass(CommandEncoder self, RenderPassDescriptor* descriptor) @cname("wgpuCommandEncoderBeginRenderPass");
extern fn void commandEncoderCopyBufferToBuffer(CommandEncoder self, Buffer source, ulong source_offset, Buffer destination, ulong destination_offset, ulong size) @cname("wgpuCommandEncoderCopyBufferToBuffer");
extern fn void commandEncoderCopyBufferToTexture(CommandEncoder self, TexelCopyBufferInfo* source, TexelCopyTextureInfo* destination, Extent3D* copy_size) @cname("wgpuCommandEncoderCopyBufferToTexture");
extern fn void commandEncoderCopyTextureToBuffer(CommandEncoder self, TexelCopyTextureInfo* source, TexelCopyBufferInfo* destination, Extent3D* copy_size) @cname("wgpuCommandEncoderCopyTextureToBuffer");
extern fn void commandEncoderCopyTextureToTexture(CommandEncoder self, TexelCopyTextureInfo* source, TexelCopyTextureInfo* destination, Extent3D* copy_size) @cname("wgpuCommandEncoderCopyTextureToTexture");
extern fn void commandEncoderClearBuffer(CommandEncoder self, Buffer buffer, ulong offset, ulong size) @cname("wgpuCommandEncoderClearBuffer");
extern fn void commandEncoderInsertDebugMarker(CommandEncoder self, StringView marker_label) @cname("wgpuCommandEncoderInsertDebugMarker");
extern fn void commandEncoderPopDebugGroup(CommandEncoder self) @cname("wgpuCommandEncoderPopDebugGroup");
extern fn void commandEncoderPushDebugGroup(CommandEncoder self, StringView group_label) @cname("wgpuCommandEncoderPushDebugGroup");
extern fn void commandEncoderResolveQuerySet(CommandEncoder self, QuerySet query_set, uint first_query, uint query_count, Buffer destination, ulong destination_offset) @cname("wgpuCommandEncoderResolveQuerySet");
extern fn void commandEncoderWriteTimestamp(CommandEncoder self, QuerySet query_set, uint query_index) @cname("wgpuCommandEncoderWriteTimestamp");
extern fn void commandEncoderSetLabel(CommandEncoder self, StringView label) @cname("wgpuCommandEncoderSetLabel");

// ComputePassEncoder methods
extern fn void computePassEncoderInsertDebugMarker(ComputePassEncoder self, StringView marker_label) @cname("wgpuComputePassEncoderInsertDebugMarker");
extern fn void computePassEncoderPopDebugGroup(ComputePassEncoder self) @cname("wgpuComputePassEncoderPopDebugGroup");
extern fn void computePassEncoderPushDebugGroup(ComputePassEncoder self, StringView group_label) @cname("wgpuComputePassEncoderPushDebugGroup");
extern fn void computePassEncoderSetPipeline(ComputePassEncoder self, ComputePipeline pipeline) @cname("wgpuComputePassEncoderSetPipeline");
extern fn void computePassEncoderSetBindGroup(ComputePassEncoder self, uint group_index, BindGroup group, usz dynamic_offsets_count, uint* dynamic_offsets) @cname("wgpuComputePassEncoderSetBindGroup");
extern fn void computePassEncoderDispatchWorkgroups(ComputePassEncoder self, uint workgroupCountX, uint workgroupCountY, uint workgroupCountZ) @cname("wgpuComputePassEncoderDispatchWorkgroups");
extern fn void computePassEncoderDispatchWorkgroupsIndirect(ComputePassEncoder self, Buffer indirect_buffer, ulong indirect_offset) @cname("wgpuComputePassEncoderDispatchWorkgroupsIndirect");
extern fn void computePassEncoderEnd(ComputePassEncoder self) @cname("wgpuComputePassEncoderEnd");
extern fn void computePassEncoderSetLabel(ComputePassEncoder self, StringView label) @cname("wgpuComputePassEncoderSetLabel");

// ComputePipeline methods
extern fn BindGroupLayout computePipelineGetBindGroupLayout(ComputePipeline self, uint group_index) @cname("wgpuComputePipelineGetBindGroupLayout");
extern fn void computePipelineSetLabel(ComputePipeline self, StringView label) @cname("wgpuComputePipelineSetLabel");

// Device methods
extern fn BindGroup deviceCreateBindGroup(Device self, BindGroupDescriptor* descriptor) @cname("wgpuDeviceCreateBindGroup");
extern fn BindGroupLayout deviceCreateBindGroupLayout(Device self, BindGroupLayoutDescriptor* descriptor) @cname("wgpuDeviceCreateBindGroupLayout");
extern fn Buffer deviceCreateBuffer(Device self, BufferDescriptor* descriptor) @cname("wgpuDeviceCreateBuffer");
extern fn CommandEncoder deviceCreateCommandEncoder(Device self, CommandEncoderDescriptor* descriptor) @cname("wgpuDeviceCreateCommandEncoder");
extern fn ComputePipeline deviceCreateComputePipeline(Device self, ComputePipelineDescriptor* descriptor) @cname("wgpuDeviceCreateComputePipeline");
extern fn Future deviceCreateComputePipelineAsync(Device self, ComputePipelineDescriptor* descriptor, CreateComputePipelineAsyncCallbackInfo callback_info) @cname("wgpuDeviceCreateComputePipelineAsync");
extern fn PipelineLayout deviceCreatePipelineLayout(Device self, PipelineLayoutDescriptor* descriptor) @cname("wgpuDeviceCreatePipelineLayout");
extern fn QuerySet deviceCreateQuerySet(Device self, QuerySetDescriptor* descriptor) @cname("wgpuDeviceCreateQuerySet");
extern fn Future deviceCreateRenderPipelineAsync(Device self, RenderPipelineDescriptor* descriptor, CreateRenderPipelineAsyncCallbackInfo callback_info) @cname("wgpuDeviceCreateRenderPipelineAsync");
extern fn RenderBundleEncoder deviceCreateRenderBundleEncoder(Device self, RenderBundleEncoderDescriptor* descriptor) @cname("wgpuDeviceCreateRenderBundleEncoder");
extern fn RenderPipeline deviceCreateRenderPipeline(Device self, RenderPipelineDescriptor* descriptor) @cname("wgpuDeviceCreateRenderPipeline");
extern fn Sampler deviceCreateSampler(Device self, SamplerDescriptor* descriptor) @cname("wgpuDeviceCreateSampler");
extern fn ShaderModule deviceCreateShaderModule(Device self, ShaderModuleDescriptor* descriptor) @cname("wgpuDeviceCreateShaderModule");
extern fn Texture deviceCreateTexture(Device self, TextureDescriptor* descriptor) @cname("wgpuDeviceCreateTexture");
extern fn void deviceDestroy(Device self) @cname("wgpuDeviceDestroy");
extern fn Future deviceGetLostFuture(Device self) @cname("wgpuDeviceGetLostFuture");
extern fn Status deviceGetLimits(Device self, Limits* limits) @cname("wgpuDeviceGetLimits");
extern fn bool deviceHasFeature(Device self, FeatureName feature) @cname("wgpuDeviceHasFeature");
extern fn void deviceGetFeatures(Device self, SupportedFeatures* features) @cname("wgpuDeviceGetFeatures");
extern fn Status deviceGetAdapterInfo(Device self, AdapterInfo* adapter_info) @cname("wgpuDeviceGetAdapterInfo");
extern fn Queue deviceGetQueue(Device self) @cname("wgpuDeviceGetQueue");
extern fn void devicePushErrorScope(Device self, ErrorFilter filter) @cname("wgpuDevicePushErrorScope");
extern fn Future devicePopErrorScope(Device self, PopErrorScopeCallbackInfo callback_info) @cname("wgpuDevicePopErrorScope");
extern fn void deviceSetLabel(Device self, StringView label) @cname("wgpuDeviceSetLabel");

// ExternalTexture methods
extern fn void externalTextureSetLabel(ExternalTexture self, StringView label) @cname("wgpuExternalTextureSetLabel");

// Instance methods
extern fn Surface instanceCreateSurface(Instance self, SurfaceDescriptor* descriptor) @cname("wgpuInstanceCreateSurface");
extern fn void instanceGetWGSLLanguageFeatures(Instance self, SupportedWGSLLanguageFeatures* features) @cname("wgpuInstanceGetWGSLLanguageFeatures");
extern fn bool instanceHasWGSLLanguageFeature(Instance self, WGSLLanguageFeatureName feature) @cname("wgpuInstanceHasWGSLLanguageFeature");
extern fn void instanceProcessEvents(Instance self) @cname("wgpuInstanceProcessEvents");
extern fn Future instanceRequestAdapter(Instance self, RequestAdapterOptions* options, RequestAdapterCallbackInfo callback_info) @cname("wgpuInstanceRequestAdapter");
extern fn WaitStatus instanceWaitAny(Instance self, usz future_count, FutureWaitInfo* futures, ulong timeout_NS) @cname("wgpuInstanceWaitAny");

// PipelineLayout methods
extern fn void pipelineLayoutSetLabel(PipelineLayout self, StringView label) @cname("wgpuPipelineLayoutSetLabel");

// QuerySet methods
extern fn void querySetSetLabel(QuerySet self, StringView label) @cname("wgpuQuerySetSetLabel");
extern fn QueryType querySetGetType(QuerySet self) @cname("wgpuQuerySetGetType");
extern fn uint querySetGetCount(QuerySet self) @cname("wgpuQuerySetGetCount");
extern fn void querySetDestroy(QuerySet self) @cname("wgpuQuerySetDestroy");

// Queue methods
extern fn void queueSubmit(Queue self, usz commands_count, CommandBuffer* commands) @cname("wgpuQueueSubmit");
extern fn Future queueOnSubmittedWorkDone(Queue self, QueueWorkDoneCallbackInfo callback_info) @cname("wgpuQueueOnSubmittedWorkDone");
extern fn void queueWriteBuffer(Queue self, Buffer buffer, ulong buffer_offset, void* data, usz size) @cname("wgpuQueueWriteBuffer");
extern fn void queueWriteTexture(Queue self, TexelCopyTextureInfo* destination, void* data, usz data_size, TexelCopyBufferLayout* data_layout, Extent3D* write_size) @cname("wgpuQueueWriteTexture");
extern fn void queueSetLabel(Queue self, StringView label) @cname("wgpuQueueSetLabel");

// RenderBundle methods
extern fn void renderBundleSetLabel(RenderBundle self, StringView label) @cname("wgpuRenderBundleSetLabel");

// RenderBundleEncoder methods
extern fn void renderBundleEncoderSetPipeline(RenderBundleEncoder self, RenderPipeline pipeline) @cname("wgpuRenderBundleEncoderSetPipeline");
extern fn void renderBundleEncoderSetBindGroup(RenderBundleEncoder self, uint group_index, BindGroup group, usz dynamic_offsets_count, uint* dynamic_offsets) @cname("wgpuRenderBundleEncoderSetBindGroup");
extern fn void renderBundleEncoderDraw(RenderBundleEncoder self, uint vertex_count, uint instance_count, uint first_vertex, uint first_instance) @cname("wgpuRenderBundleEncoderDraw");
extern fn void renderBundleEncoderDrawIndexed(RenderBundleEncoder self, uint index_count, uint instance_count, uint first_index, int base_vertex, uint first_instance) @cname("wgpuRenderBundleEncoderDrawIndexed");
extern fn void renderBundleEncoderDrawIndirect(RenderBundleEncoder self, Buffer indirect_buffer, ulong indirect_offset) @cname("wgpuRenderBundleEncoderDrawIndirect");
extern fn void renderBundleEncoderDrawIndexedIndirect(RenderBundleEncoder self, Buffer indirect_buffer, ulong indirect_offset) @cname("wgpuRenderBundleEncoderDrawIndexedIndirect");
extern fn void renderBundleEncoderInsertDebugMarker(RenderBundleEncoder self, StringView marker_label) @cname("wgpuRenderBundleEncoderInsertDebugMarker");
extern fn void renderBundleEncoderPopDebugGroup(RenderBundleEncoder self) @cname("wgpuRenderBundleEncoderPopDebugGroup");
extern fn void renderBundleEncoderPushDebugGroup(RenderBundleEncoder self, StringView group_label) @cname("wgpuRenderBundleEncoderPushDebugGroup");
extern fn void renderBundleEncoderSetVertexBuffer(RenderBundleEncoder self, uint slot, Buffer buffer, ulong offset, ulong size) @cname("wgpuRenderBundleEncoderSetVertexBuffer");
extern fn void renderBundleEncoderSetIndexBuffer(RenderBundleEncoder self, Buffer buffer, IndexFormat format, ulong offset, ulong size) @cname("wgpuRenderBundleEncoderSetIndexBuffer");
extern fn RenderBundle renderBundleEncoderFinish(RenderBundleEncoder self, RenderBundleDescriptor* descriptor) @cname("wgpuRenderBundleEncoderFinish");
extern fn void renderBundleEncoderSetLabel(RenderBundleEncoder self, StringView label) @cname("wgpuRenderBundleEncoderSetLabel");

// RenderPassEncoder methods
extern fn void renderPassEncoderSetPipeline(RenderPassEncoder self, RenderPipeline pipeline) @cname("wgpuRenderPassEncoderSetPipeline");
extern fn void renderPassEncoderSetBindGroup(RenderPassEncoder self, uint group_index, BindGroup group, usz dynamic_offsets_count, uint* dynamic_offsets) @cname("wgpuRenderPassEncoderSetBindGroup");
extern fn void renderPassEncoderDraw(RenderPassEncoder self, uint vertex_count, uint instance_count, uint first_vertex, uint first_instance) @cname("wgpuRenderPassEncoderDraw");
extern fn void renderPassEncoderDrawIndexed(RenderPassEncoder self, uint index_count, uint instance_count, uint first_index, int base_vertex, uint first_instance) @cname("wgpuRenderPassEncoderDrawIndexed");
extern fn void renderPassEncoderDrawIndirect(RenderPassEncoder self, Buffer indirect_buffer, ulong indirect_offset) @cname("wgpuRenderPassEncoderDrawIndirect");
extern fn void renderPassEncoderDrawIndexedIndirect(RenderPassEncoder self, Buffer indirect_buffer, ulong indirect_offset) @cname("wgpuRenderPassEncoderDrawIndexedIndirect");
extern fn void renderPassEncoderExecuteBundles(RenderPassEncoder self, usz bundles_count, RenderBundle* bundles) @cname("wgpuRenderPassEncoderExecuteBundles");
extern fn void renderPassEncoderInsertDebugMarker(RenderPassEncoder self, StringView marker_label) @cname("wgpuRenderPassEncoderInsertDebugMarker");
extern fn void renderPassEncoderPopDebugGroup(RenderPassEncoder self) @cname("wgpuRenderPassEncoderPopDebugGroup");
extern fn void renderPassEncoderPushDebugGroup(RenderPassEncoder self, StringView group_label) @cname("wgpuRenderPassEncoderPushDebugGroup");
extern fn void renderPassEncoderSetStencilReference(RenderPassEncoder self, uint reference) @cname("wgpuRenderPassEncoderSetStencilReference");
extern fn void renderPassEncoderSetBlendConstant(RenderPassEncoder self, Color* color) @cname("wgpuRenderPassEncoderSetBlendConstant");
extern fn void renderPassEncoderSetViewport(RenderPassEncoder self, float x, float y, float width, float height, float min_depth, float max_depth) @cname("wgpuRenderPassEncoderSetViewport");
extern fn void renderPassEncoderSetScissorRect(RenderPassEncoder self, uint x, uint y, uint width, uint height) @cname("wgpuRenderPassEncoderSetScissorRect");
extern fn void renderPassEncoderSetVertexBuffer(RenderPassEncoder self, uint slot, Buffer buffer, ulong offset, ulong size) @cname("wgpuRenderPassEncoderSetVertexBuffer");
extern fn void renderPassEncoderSetIndexBuffer(RenderPassEncoder self, Buffer buffer, IndexFormat format, ulong offset, ulong size) @cname("wgpuRenderPassEncoderSetIndexBuffer");
extern fn void renderPassEncoderBeginOcclusionQuery(RenderPassEncoder self, uint query_index) @cname("wgpuRenderPassEncoderBeginOcclusionQuery");
extern fn void renderPassEncoderEndOcclusionQuery(RenderPassEncoder self) @cname("wgpuRenderPassEncoderEndOcclusionQuery");
extern fn void renderPassEncoderEnd(RenderPassEncoder self) @cname("wgpuRenderPassEncoderEnd");
extern fn void renderPassEncoderSetLabel(RenderPassEncoder self, StringView label) @cname("wgpuRenderPassEncoderSetLabel");

// RenderPipeline methods
extern fn BindGroupLayout renderPipelineGetBindGroupLayout(RenderPipeline self, uint group_index) @cname("wgpuRenderPipelineGetBindGroupLayout");
extern fn void renderPipelineSetLabel(RenderPipeline self, StringView label) @cname("wgpuRenderPipelineSetLabel");

// Sampler methods
extern fn void samplerSetLabel(Sampler self, StringView label) @cname("wgpuSamplerSetLabel");

// ShaderModule methods
extern fn Future shaderModuleGetCompilationInfo(ShaderModule self, CompilationInfoCallbackInfo callback_info) @cname("wgpuShaderModuleGetCompilationInfo");
extern fn void shaderModuleSetLabel(ShaderModule self, StringView label) @cname("wgpuShaderModuleSetLabel");

// Surface methods
extern fn void surfaceConfigure(Surface self, SurfaceConfiguration* config) @cname("wgpuSurfaceConfigure");
extern fn Status surfaceGetCapabilities(Surface self, Adapter adapter, SurfaceCapabilities* capabilities) @cname("wgpuSurfaceGetCapabilities");
extern fn void surfaceGetCurrentTexture(Surface self, SurfaceTexture* surface_texture) @cname("wgpuSurfaceGetCurrentTexture");
extern fn Status surfacePresent(Surface self) @cname("wgpuSurfacePresent");
extern fn void surfaceUnconfigure(Surface self) @cname("wgpuSurfaceUnconfigure");
extern fn void surfaceSetLabel(Surface self, StringView label) @cname("wgpuSurfaceSetLabel");

// Texture methods
extern fn TextureView textureCreateView(Texture self, TextureViewDescriptor* descriptor) @cname("wgpuTextureCreateView");
extern fn void textureSetLabel(Texture self, StringView label) @cname("wgpuTextureSetLabel");
extern fn uint textureGetWidth(Texture self) @cname("wgpuTextureGetWidth");
extern fn uint textureGetHeight(Texture self) @cname("wgpuTextureGetHeight");
extern fn uint textureGetDepthOrArrayLayers(Texture self) @cname("wgpuTextureGetDepthOrArrayLayers");
extern fn uint textureGetMipLevelCount(Texture self) @cname("wgpuTextureGetMipLevelCount");
extern fn uint textureGetSampleCount(Texture self) @cname("wgpuTextureGetSampleCount");
extern fn TextureDimension textureGetDimension(Texture self) @cname("wgpuTextureGetDimension");
extern fn TextureViewDimension textureGetTextureBindingViewDimension(Texture self) @cname("wgpuTextureGetTextureBindingViewDimension");
extern fn TextureFormat textureGetFormat(Texture self) @cname("wgpuTextureGetFormat");
extern fn TextureUsage textureGetUsage(Texture self) @cname("wgpuTextureGetUsage");
extern fn void textureDestroy(Texture self) @cname("wgpuTextureDestroy");

// TextureView methods
extern fn void textureViewSetLabel(TextureView self, StringView label) @cname("wgpuTextureViewSetLabel");

// Release methods — drop handle references, allowing GPU resource cleanup
extern fn void bindGroupRelease(BindGroup self) @cname("wgpuBindGroupRelease");
extern fn void bindGroupLayoutRelease(BindGroupLayout self) @cname("wgpuBindGroupLayoutRelease");
extern fn void pipelineLayoutRelease(PipelineLayout self) @cname("wgpuPipelineLayoutRelease");
extern fn void renderPipelineRelease(RenderPipeline self) @cname("wgpuRenderPipelineRelease");
extern fn void shaderModuleRelease(ShaderModule self) @cname("wgpuShaderModuleRelease");
extern fn void samplerRelease(Sampler self) @cname("wgpuSamplerRelease");
extern fn void textureViewRelease(TextureView self) @cname("wgpuTextureViewRelease");
extern fn void commandEncoderRelease(CommandEncoder self) @cname("wgpuCommandEncoderRelease");
extern fn void commandBufferRelease(CommandBuffer self) @cname("wgpuCommandBufferRelease");
extern fn void renderPassEncoderRelease(RenderPassEncoder self) @cname("wgpuRenderPassEncoderRelease");

