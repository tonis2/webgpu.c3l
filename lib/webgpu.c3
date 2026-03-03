module webgpu;

// Object handles
typedef Adapter = inline void*;
typedef BindGroup = inline void*;
typedef BindGroupLayout = inline void*;
typedef Buffer = inline void*;
typedef CommandBuffer = inline void*;
typedef CommandEncoder = inline void*;
typedef ComputePassEncoder = inline void*;
typedef ComputePipeline = inline void*;
typedef Device = inline void*;
typedef ExternalTexture = inline void*;
typedef Instance = inline void*;
typedef PipelineLayout = inline void*;
typedef QuerySet = inline void*;
typedef Queue = inline void*;
typedef RenderBundle = inline void*;
typedef RenderBundleEncoder = inline void*;
typedef RenderPassEncoder = inline void*;
typedef RenderPipeline = inline void*;
typedef Sampler = inline void*;
typedef ShaderModule = inline void*;
typedef Surface = inline void*;
typedef Texture = inline void*;
typedef TextureView = inline void*;

// Constants
const WGPU_ARRAY_LAYER_COUNT_UNDEFINED = (~0u);
const WGPU_COPY_STRIDE_UNDEFINED = (~0u);
const WGPU_DEPTH_CLEAR_VALUE_UNDEFINED = float.nan;
const WGPU_DEPTH_SLICE_UNDEFINED = (~0u);
const WGPU_LIMIT_U32_UNDEFINED = (~0u);
const WGPU_LIMIT_U64_UNDEFINED = (~0ul);
const WGPU_MIP_LEVEL_COUNT_UNDEFINED = (~0u);
const WGPU_QUERY_SET_INDEX_UNDEFINED = (~0u);
const WGPU_STRLEN = (~0uz);
const WGPU_WHOLE_MAP_SIZE = (~0uz);
const WGPU_WHOLE_SIZE = (~0ul);

// Callbacks
def WGPUBufferMapCallback = fn void(MapAsyncStatus status, char* message);
struct BufferMapCallbackInfo {
    ChainMeta* next_in_chain;
    CallbackMode mode;
    WGPUBufferMapCallback callback;
    void* userdata1;
    void* userdata2;
}
def WGPUCompilationInfoCallback = fn void(CompilationInfoRequestStatus status, CompilationInfo* compilation_info);
struct CompilationInfoCallbackInfo {
    ChainMeta* next_in_chain;
    CallbackMode mode;
    WGPUCompilationInfoCallback callback;
    void* userdata1;
    void* userdata2;
}
def WGPUCreateComputePipelineAsyncCallback = fn void(CreatePipelineAsyncStatus status, ComputePipeline pipeline, char* message);
struct CreateComputePipelineAsyncCallbackInfo {
    ChainMeta* next_in_chain;
    CallbackMode mode;
    WGPUCreateComputePipelineAsyncCallback callback;
    void* userdata1;
    void* userdata2;
}
def WGPUCreateRenderPipelineAsyncCallback = fn void(CreatePipelineAsyncStatus status, RenderPipeline pipeline, char* message);
struct CreateRenderPipelineAsyncCallbackInfo {
    ChainMeta* next_in_chain;
    CallbackMode mode;
    WGPUCreateRenderPipelineAsyncCallback callback;
    void* userdata1;
    void* userdata2;
}
def WGPUDeviceLostCallback = fn void(Device* device, DeviceLostReason reason, char* message);
struct DeviceLostCallbackInfo {
    ChainMeta* next_in_chain;
    CallbackMode mode;
    WGPUDeviceLostCallback callback;
    void* userdata1;
    void* userdata2;
}
def WGPUPopErrorScopeCallback = fn void(PopErrorScopeStatus status, ErrorType type, char* message);
struct PopErrorScopeCallbackInfo {
    ChainMeta* next_in_chain;
    CallbackMode mode;
    WGPUPopErrorScopeCallback callback;
    void* userdata1;
    void* userdata2;
}
def WGPUQueueWorkDoneCallback = fn void(QueueWorkDoneStatus status, char* message);
struct QueueWorkDoneCallbackInfo {
    ChainMeta* next_in_chain;
    CallbackMode mode;
    WGPUQueueWorkDoneCallback callback;
    void* userdata1;
    void* userdata2;
}
def WGPURequestAdapterCallback = fn void(RequestAdapterStatus status, Adapter adapter, char* message);
struct RequestAdapterCallbackInfo {
    ChainMeta* next_in_chain;
    CallbackMode mode;
    WGPURequestAdapterCallback callback;
    void* userdata1;
    void* userdata2;
}
def WGPURequestDeviceCallback = fn void(RequestDeviceStatus status, Device device, char* message);
struct RequestDeviceCallbackInfo {
    ChainMeta* next_in_chain;
    CallbackMode mode;
    WGPURequestDeviceCallback callback;
    void* userdata1;
    void* userdata2;
}
def WGPUUncapturedErrorCallback = fn void(Device* device, ErrorType type, char* message);

// Enums
typedef AdapterType = inline uint;
const AdapterType ADAPTER_TYPE_DISCRETE_GPU = 1;
const AdapterType ADAPTER_TYPE_INTEGRATED_GPU = 2;
const AdapterType ADAPTER_TYPE_CPU = 3;
const AdapterType ADAPTER_TYPE_UNKNOWN = 4;

typedef AddressMode = inline uint;
const AddressMode ADDRESS_MODE_UNDEFINED = 0;
const AddressMode ADDRESS_MODE_CLAMP_TO_EDGE = 1;
const AddressMode ADDRESS_MODE_REPEAT = 2;
const AddressMode ADDRESS_MODE_MIRROR_REPEAT = 3;

typedef BackendType = inline uint;
const BackendType BACKEND_TYPE_UNDEFINED = 0;
const BackendType BACKEND_TYPE_NULL = 1;
const BackendType BACKEND_TYPE_WEB_GPU = 2;
const BackendType BACKEND_TYPE_D3D11 = 3;
const BackendType BACKEND_TYPE_D3D12 = 4;
const BackendType BACKEND_TYPE_METAL = 5;
const BackendType BACKEND_TYPE_VULKAN = 6;
const BackendType BACKEND_TYPE_OPEN_GL = 7;
const BackendType BACKEND_TYPE_OPEN_GLES = 8;

typedef BlendFactor = inline uint;
const BlendFactor BLEND_FACTOR_UNDEFINED = 0;
const BlendFactor BLEND_FACTOR_ZERO = 1;
const BlendFactor BLEND_FACTOR_ONE = 2;
const BlendFactor BLEND_FACTOR_SRC = 3;
const BlendFactor BLEND_FACTOR_ONE_MINUS_SRC = 4;
const BlendFactor BLEND_FACTOR_SRC_ALPHA = 5;
const BlendFactor BLEND_FACTOR_ONE_MINUS_SRC_ALPHA = 6;
const BlendFactor BLEND_FACTOR_DST = 7;
const BlendFactor BLEND_FACTOR_ONE_MINUS_DST = 8;
const BlendFactor BLEND_FACTOR_DST_ALPHA = 9;
const BlendFactor BLEND_FACTOR_ONE_MINUS_DST_ALPHA = 10;
const BlendFactor BLEND_FACTOR_SRC_ALPHA_SATURATED = 11;
const BlendFactor BLEND_FACTOR_CONSTANT = 12;
const BlendFactor BLEND_FACTOR_ONE_MINUS_CONSTANT = 13;
const BlendFactor BLEND_FACTOR_SRC1 = 14;
const BlendFactor BLEND_FACTOR_ONE_MINUS_SRC1 = 15;
const BlendFactor BLEND_FACTOR_SRC1_ALPHA = 16;
const BlendFactor BLEND_FACTOR_ONE_MINUS_SRC1_ALPHA = 17;

typedef BlendOperation = inline uint;
const BlendOperation BLEND_OPERATION_UNDEFINED = 0;
const BlendOperation BLEND_OPERATION_ADD = 1;
const BlendOperation BLEND_OPERATION_SUBTRACT = 2;
const BlendOperation BLEND_OPERATION_REVERSE_SUBTRACT = 3;
const BlendOperation BLEND_OPERATION_MIN = 4;
const BlendOperation BLEND_OPERATION_MAX = 5;

typedef BufferBindingType = inline uint;
const BufferBindingType BUFFER_BINDING_TYPE_BINDING_NOT_USED = 0;
const BufferBindingType BUFFER_BINDING_TYPE_UNDEFINED = 1;
const BufferBindingType BUFFER_BINDING_TYPE_UNIFORM = 2;
const BufferBindingType BUFFER_BINDING_TYPE_STORAGE = 3;
const BufferBindingType BUFFER_BINDING_TYPE_READ_ONLY_STORAGE = 4;

typedef BufferMapState = inline uint;
const BufferMapState BUFFER_MAP_STATE_UNMAPPED = 1;
const BufferMapState BUFFER_MAP_STATE_PENDING = 2;
const BufferMapState BUFFER_MAP_STATE_MAPPED = 3;

typedef CallbackMode = inline uint;
const CallbackMode CALLBACK_MODE_WAIT_ANY_ONLY = 1;
const CallbackMode CALLBACK_MODE_ALLOW_PROCESS_EVENTS = 2;
const CallbackMode CALLBACK_MODE_ALLOW_SPONTANEOUS = 3;

typedef CompareFunction = inline uint;
const CompareFunction COMPARE_FUNCTION_UNDEFINED = 0;
const CompareFunction COMPARE_FUNCTION_NEVER = 1;
const CompareFunction COMPARE_FUNCTION_LESS = 2;
const CompareFunction COMPARE_FUNCTION_EQUAL = 3;
const CompareFunction COMPARE_FUNCTION_LESS_EQUAL = 4;
const CompareFunction COMPARE_FUNCTION_GREATER = 5;
const CompareFunction COMPARE_FUNCTION_NOT_EQUAL = 6;
const CompareFunction COMPARE_FUNCTION_GREATER_EQUAL = 7;
const CompareFunction COMPARE_FUNCTION_ALWAYS = 8;

typedef CompilationInfoRequestStatus = inline uint;
const CompilationInfoRequestStatus COMPILATION_INFO_REQUEST_STATUS_SUCCESS = 1;
const CompilationInfoRequestStatus COMPILATION_INFO_REQUEST_STATUS_CALLBACK_CANCELLED = 2;

typedef CompilationMessageType = inline uint;
const CompilationMessageType COMPILATION_MESSAGE_TYPE_ERROR = 1;
const CompilationMessageType COMPILATION_MESSAGE_TYPE_WARNING = 2;
const CompilationMessageType COMPILATION_MESSAGE_TYPE_INFO = 3;

typedef ComponentSwizzle = inline uint;
const ComponentSwizzle COMPONENT_SWIZZLE_UNDEFINED = 0;
const ComponentSwizzle COMPONENT_SWIZZLE_ZERO = 1;
const ComponentSwizzle COMPONENT_SWIZZLE_ONE = 2;
const ComponentSwizzle COMPONENT_SWIZZLE_R = 3;
const ComponentSwizzle COMPONENT_SWIZZLE_G = 4;
const ComponentSwizzle COMPONENT_SWIZZLE_B = 5;
const ComponentSwizzle COMPONENT_SWIZZLE_A = 6;

typedef CompositeAlphaMode = inline uint;
const CompositeAlphaMode COMPOSITE_ALPHA_MODE_AUTO = 0;
const CompositeAlphaMode COMPOSITE_ALPHA_MODE_OPAQUE = 1;
const CompositeAlphaMode COMPOSITE_ALPHA_MODE_PREMULTIPLIED = 2;
const CompositeAlphaMode COMPOSITE_ALPHA_MODE_UNPREMULTIPLIED = 3;
const CompositeAlphaMode COMPOSITE_ALPHA_MODE_INHERIT = 4;

typedef CreatePipelineAsyncStatus = inline uint;
const CreatePipelineAsyncStatus CREATE_PIPELINE_ASYNC_STATUS_SUCCESS = 1;
const CreatePipelineAsyncStatus CREATE_PIPELINE_ASYNC_STATUS_CALLBACK_CANCELLED = 2;
const CreatePipelineAsyncStatus CREATE_PIPELINE_ASYNC_STATUS_VALIDATION_ERROR = 3;
const CreatePipelineAsyncStatus CREATE_PIPELINE_ASYNC_STATUS_INTERNAL_ERROR = 4;

typedef CullMode = inline uint;
const CullMode CULL_MODE_UNDEFINED = 0;
const CullMode CULL_MODE_NONE = 1;
const CullMode CULL_MODE_FRONT = 2;
const CullMode CULL_MODE_BACK = 3;

typedef DeviceLostReason = inline uint;
const DeviceLostReason DEVICE_LOST_REASON_UNKNOWN = 1;
const DeviceLostReason DEVICE_LOST_REASON_DESTROYED = 2;
const DeviceLostReason DEVICE_LOST_REASON_CALLBACK_CANCELLED = 3;
const DeviceLostReason DEVICE_LOST_REASON_FAILED_CREATION = 4;

typedef ErrorFilter = inline uint;
const ErrorFilter ERROR_FILTER_VALIDATION = 1;
const ErrorFilter ERROR_FILTER_OUT_OF_MEMORY = 2;
const ErrorFilter ERROR_FILTER_INTERNAL = 3;

typedef ErrorType = inline uint;
const ErrorType ERROR_TYPE_NO_ERROR = 1;
const ErrorType ERROR_TYPE_VALIDATION = 2;
const ErrorType ERROR_TYPE_OUT_OF_MEMORY = 3;
const ErrorType ERROR_TYPE_INTERNAL = 4;
const ErrorType ERROR_TYPE_UNKNOWN = 5;

typedef FeatureLevel = inline uint;
const FeatureLevel FEATURE_LEVEL_UNDEFINED = 0;
const FeatureLevel FEATURE_LEVEL_COMPATIBILITY = 1;
const FeatureLevel FEATURE_LEVEL_CORE = 2;

typedef FeatureName = inline uint;
const FeatureName FEATURE_NAME_CORE_FEATURES_AND_LIMITS = 1;
const FeatureName FEATURE_NAME_DEPTH_CLIP_CONTROL = 2;
const FeatureName FEATURE_NAME_DEPTH32_FLOAT_STENCIL8 = 3;
const FeatureName FEATURE_NAME_TEXTURE_COMPRESSION_BC = 4;
const FeatureName FEATURE_NAME_TEXTURE_COMPRESSION_BC_SLICED_3D = 5;
const FeatureName FEATURE_NAME_TEXTURE_COMPRESSION_ETC2 = 6;
const FeatureName FEATURE_NAME_TEXTURE_COMPRESSION_ASTC = 7;
const FeatureName FEATURE_NAME_TEXTURE_COMPRESSION_ASTC_SLICED_3D = 8;
const FeatureName FEATURE_NAME_TIMESTAMP_QUERY = 9;
const FeatureName FEATURE_NAME_INDIRECT_FIRST_INSTANCE = 10;
const FeatureName FEATURE_NAME_SHADER_F16 = 11;
const FeatureName FEATURE_NAME_RG11B10_UFLOAT_RENDERABLE = 12;
const FeatureName FEATURE_NAME_BGRA8_UNORM_STORAGE = 13;
const FeatureName FEATURE_NAME_FLOAT32_FILTERABLE = 14;
const FeatureName FEATURE_NAME_FLOAT32_BLENDABLE = 15;
const FeatureName FEATURE_NAME_CLIP_DISTANCES = 16;
const FeatureName FEATURE_NAME_DUAL_SOURCE_BLENDING = 17;
const FeatureName FEATURE_NAME_SUBGROUPS = 18;
const FeatureName FEATURE_NAME_TEXTURE_FORMATS_TIER_1 = 19;
const FeatureName FEATURE_NAME_TEXTURE_FORMATS_TIER_2 = 20;
const FeatureName FEATURE_NAME_PRIMITIVE_INDEX = 21;
const FeatureName FEATURE_NAME_TEXTURE_COMPONENT_SWIZZLE = 22;

typedef FilterMode = inline uint;
const FilterMode FILTER_MODE_UNDEFINED = 0;
const FilterMode FILTER_MODE_NEAREST = 1;
const FilterMode FILTER_MODE_LINEAR = 2;

typedef FrontFace = inline uint;
const FrontFace FRONT_FACE_UNDEFINED = 0;
const FrontFace FRONT_FACE_CCW = 1;
const FrontFace FRONT_FACE_CW = 2;

typedef IndexFormat = inline uint;
const IndexFormat INDEX_FORMAT_UNDEFINED = 0;
const IndexFormat INDEX_FORMAT_UINT16 = 1;
const IndexFormat INDEX_FORMAT_UINT32 = 2;

typedef InstanceFeatureName = inline uint;
const InstanceFeatureName INSTANCE_FEATURE_NAME_TIMED_WAIT_ANY = 1;
const InstanceFeatureName INSTANCE_FEATURE_NAME_SHADER_SOURCE_SPIRV = 2;
const InstanceFeatureName INSTANCE_FEATURE_NAME_MULTIPLE_DEVICES_PER_ADAPTER = 3;

typedef LoadOp = inline uint;
const LoadOp LOAD_OP_UNDEFINED = 0;
const LoadOp LOAD_OP_LOAD = 1;
const LoadOp LOAD_OP_CLEAR = 2;

typedef MapAsyncStatus = inline uint;
const MapAsyncStatus MAP_ASYNC_STATUS_SUCCESS = 1;
const MapAsyncStatus MAP_ASYNC_STATUS_CALLBACK_CANCELLED = 2;
const MapAsyncStatus MAP_ASYNC_STATUS_ERROR = 3;
const MapAsyncStatus MAP_ASYNC_STATUS_ABORTED = 4;

typedef MipmapFilterMode = inline uint;
const MipmapFilterMode MIPMAP_FILTER_MODE_UNDEFINED = 0;
const MipmapFilterMode MIPMAP_FILTER_MODE_NEAREST = 1;
const MipmapFilterMode MIPMAP_FILTER_MODE_LINEAR = 2;

typedef OptionalBool = inline uint;
const OptionalBool OPTIONAL_BOOL_FALSE = 0;
const OptionalBool OPTIONAL_BOOL_TRUE = 1;
const OptionalBool OPTIONAL_BOOL_UNDEFINED = 2;

typedef PopErrorScopeStatus = inline uint;
const PopErrorScopeStatus POP_ERROR_SCOPE_STATUS_SUCCESS = 1;
const PopErrorScopeStatus POP_ERROR_SCOPE_STATUS_CALLBACK_CANCELLED = 2;
const PopErrorScopeStatus POP_ERROR_SCOPE_STATUS_ERROR = 3;

typedef PowerPreference = inline uint;
const PowerPreference POWER_PREFERENCE_UNDEFINED = 0;
const PowerPreference POWER_PREFERENCE_LOW_POWER = 1;
const PowerPreference POWER_PREFERENCE_HIGH_PERFORMANCE = 2;

typedef PredefinedColorSpace = inline uint;
const PredefinedColorSpace PREDEFINED_COLOR_SPACE_SRGB = 1;
const PredefinedColorSpace PREDEFINED_COLOR_SPACE_DISPLAY_P3 = 2;

typedef PresentMode = inline uint;
const PresentMode PRESENT_MODE_UNDEFINED = 0;
const PresentMode PRESENT_MODE_FIFO = 1;
const PresentMode PRESENT_MODE_FIFO_RELAXED = 2;
const PresentMode PRESENT_MODE_IMMEDIATE = 3;
const PresentMode PRESENT_MODE_MAILBOX = 4;

typedef PrimitiveTopology = inline uint;
const PrimitiveTopology PRIMITIVE_TOPOLOGY_UNDEFINED = 0;
const PrimitiveTopology PRIMITIVE_TOPOLOGY_POINT_LIST = 1;
const PrimitiveTopology PRIMITIVE_TOPOLOGY_LINE_LIST = 2;
const PrimitiveTopology PRIMITIVE_TOPOLOGY_LINE_STRIP = 3;
const PrimitiveTopology PRIMITIVE_TOPOLOGY_TRIANGLE_LIST = 4;
const PrimitiveTopology PRIMITIVE_TOPOLOGY_TRIANGLE_STRIP = 5;

typedef QueryType = inline uint;
const QueryType QUERY_TYPE_OCCLUSION = 1;
const QueryType QUERY_TYPE_TIMESTAMP = 2;

typedef QueueWorkDoneStatus = inline uint;
const QueueWorkDoneStatus QUEUE_WORK_DONE_STATUS_SUCCESS = 1;
const QueueWorkDoneStatus QUEUE_WORK_DONE_STATUS_CALLBACK_CANCELLED = 2;
const QueueWorkDoneStatus QUEUE_WORK_DONE_STATUS_ERROR = 3;

typedef RequestAdapterStatus = inline uint;
const RequestAdapterStatus REQUEST_ADAPTER_STATUS_SUCCESS = 1;
const RequestAdapterStatus REQUEST_ADAPTER_STATUS_CALLBACK_CANCELLED = 2;
const RequestAdapterStatus REQUEST_ADAPTER_STATUS_UNAVAILABLE = 3;
const RequestAdapterStatus REQUEST_ADAPTER_STATUS_ERROR = 4;

typedef RequestDeviceStatus = inline uint;
const RequestDeviceStatus REQUEST_DEVICE_STATUS_SUCCESS = 1;
const RequestDeviceStatus REQUEST_DEVICE_STATUS_CALLBACK_CANCELLED = 2;
const RequestDeviceStatus REQUEST_DEVICE_STATUS_ERROR = 3;

typedef SType = inline uint;
const SType S_TYPE_SHADER_SOURCE_SPIRV = 1;
const SType S_TYPE_SHADER_SOURCE_WGSL = 2;
const SType S_TYPE_RENDER_PASS_MAX_DRAW_COUNT = 3;
const SType S_TYPE_SURFACE_SOURCE_METAL_LAYER = 4;
const SType S_TYPE_SURFACE_SOURCE_WINDOWS_HWND = 5;
const SType S_TYPE_SURFACE_SOURCE_XLIB_WINDOW = 6;
const SType S_TYPE_SURFACE_SOURCE_WAYLAND_SURFACE = 7;
const SType S_TYPE_SURFACE_SOURCE_ANDROID_NATIVE_WINDOW = 8;
const SType S_TYPE_SURFACE_SOURCE_XCB_WINDOW = 9;
const SType S_TYPE_SURFACE_COLOR_MANAGEMENT = 10;
const SType S_TYPE_REQUEST_ADAPTER_WEB_XR_OPTIONS = 11;
const SType S_TYPE_TEXTURE_COMPONENT_SWIZZLE_DESCRIPTOR = 12;
const SType S_TYPE_EXTERNAL_TEXTURE_BINDING_LAYOUT = 13;
const SType S_TYPE_EXTERNAL_TEXTURE_BINDING_ENTRY = 14;

typedef SamplerBindingType = inline uint;
const SamplerBindingType SAMPLER_BINDING_TYPE_BINDING_NOT_USED = 0;
const SamplerBindingType SAMPLER_BINDING_TYPE_UNDEFINED = 1;
const SamplerBindingType SAMPLER_BINDING_TYPE_FILTERING = 2;
const SamplerBindingType SAMPLER_BINDING_TYPE_NON_FILTERING = 3;
const SamplerBindingType SAMPLER_BINDING_TYPE_COMPARISON = 4;

typedef Status = inline uint;
const Status STATUS_SUCCESS = 1;
const Status STATUS_ERROR = 2;

typedef StencilOperation = inline uint;
const StencilOperation STENCIL_OPERATION_UNDEFINED = 0;
const StencilOperation STENCIL_OPERATION_KEEP = 1;
const StencilOperation STENCIL_OPERATION_ZERO = 2;
const StencilOperation STENCIL_OPERATION_REPLACE = 3;
const StencilOperation STENCIL_OPERATION_INVERT = 4;
const StencilOperation STENCIL_OPERATION_INCREMENT_CLAMP = 5;
const StencilOperation STENCIL_OPERATION_DECREMENT_CLAMP = 6;
const StencilOperation STENCIL_OPERATION_INCREMENT_WRAP = 7;
const StencilOperation STENCIL_OPERATION_DECREMENT_WRAP = 8;

typedef StorageTextureAccess = inline uint;
const StorageTextureAccess STORAGE_TEXTURE_ACCESS_BINDING_NOT_USED = 0;
const StorageTextureAccess STORAGE_TEXTURE_ACCESS_UNDEFINED = 1;
const StorageTextureAccess STORAGE_TEXTURE_ACCESS_WRITE_ONLY = 2;
const StorageTextureAccess STORAGE_TEXTURE_ACCESS_READ_ONLY = 3;
const StorageTextureAccess STORAGE_TEXTURE_ACCESS_READ_WRITE = 4;

typedef StoreOp = inline uint;
const StoreOp STORE_OP_UNDEFINED = 0;
const StoreOp STORE_OP_STORE = 1;
const StoreOp STORE_OP_DISCARD = 2;

typedef SurfaceGetCurrentTextureStatus = inline uint;
const SurfaceGetCurrentTextureStatus SURFACE_GET_CURRENT_TEXTURE_STATUS_SUCCESS_OPTIMAL = 1;
const SurfaceGetCurrentTextureStatus SURFACE_GET_CURRENT_TEXTURE_STATUS_SUCCESS_SUBOPTIMAL = 2;
const SurfaceGetCurrentTextureStatus SURFACE_GET_CURRENT_TEXTURE_STATUS_TIMEOUT = 3;
const SurfaceGetCurrentTextureStatus SURFACE_GET_CURRENT_TEXTURE_STATUS_OUTDATED = 4;
const SurfaceGetCurrentTextureStatus SURFACE_GET_CURRENT_TEXTURE_STATUS_LOST = 5;
const SurfaceGetCurrentTextureStatus SURFACE_GET_CURRENT_TEXTURE_STATUS_ERROR = 6;

typedef TextureAspect = inline uint;
const TextureAspect TEXTURE_ASPECT_UNDEFINED = 0;
const TextureAspect TEXTURE_ASPECT_ALL = 1;
const TextureAspect TEXTURE_ASPECT_STENCIL_ONLY = 2;
const TextureAspect TEXTURE_ASPECT_DEPTH_ONLY = 3;

typedef TextureDimension = inline uint;
const TextureDimension TEXTURE_DIMENSION_UNDEFINED = 0;
const TextureDimension TEXTURE_DIMENSION_1D = 1;
const TextureDimension TEXTURE_DIMENSION_2D = 2;
const TextureDimension TEXTURE_DIMENSION_3D = 3;

typedef TextureFormat = inline uint;
const TextureFormat TEXTURE_FORMAT_UNDEFINED = 0;
const TextureFormat TEXTURE_FORMAT_R8_UNORM = 1;
const TextureFormat TEXTURE_FORMAT_R8_SNORM = 2;
const TextureFormat TEXTURE_FORMAT_R8_UINT = 3;
const TextureFormat TEXTURE_FORMAT_R8_SINT = 4;
const TextureFormat TEXTURE_FORMAT_R16_UNORM = 5;
const TextureFormat TEXTURE_FORMAT_R16_SNORM = 6;
const TextureFormat TEXTURE_FORMAT_R16_UINT = 7;
const TextureFormat TEXTURE_FORMAT_R16_SINT = 8;
const TextureFormat TEXTURE_FORMAT_R16_FLOAT = 9;
const TextureFormat TEXTURE_FORMAT_RG8_UNORM = 10;
const TextureFormat TEXTURE_FORMAT_RG8_SNORM = 11;
const TextureFormat TEXTURE_FORMAT_RG8_UINT = 12;
const TextureFormat TEXTURE_FORMAT_RG8_SINT = 13;
const TextureFormat TEXTURE_FORMAT_R32_FLOAT = 14;
const TextureFormat TEXTURE_FORMAT_R32_UINT = 15;
const TextureFormat TEXTURE_FORMAT_R32_SINT = 16;
const TextureFormat TEXTURE_FORMAT_RG16_UNORM = 17;
const TextureFormat TEXTURE_FORMAT_RG16_SNORM = 18;
const TextureFormat TEXTURE_FORMAT_RG16_UINT = 19;
const TextureFormat TEXTURE_FORMAT_RG16_SINT = 20;
const TextureFormat TEXTURE_FORMAT_RG16_FLOAT = 21;
const TextureFormat TEXTURE_FORMAT_RGBA8_UNORM = 22;
const TextureFormat TEXTURE_FORMAT_RGBA8_UNORM_SRGB = 23;
const TextureFormat TEXTURE_FORMAT_RGBA8_SNORM = 24;
const TextureFormat TEXTURE_FORMAT_RGBA8_UINT = 25;
const TextureFormat TEXTURE_FORMAT_RGBA8_SINT = 26;
const TextureFormat TEXTURE_FORMAT_BGRA8_UNORM = 27;
const TextureFormat TEXTURE_FORMAT_BGRA8_UNORM_SRGB = 28;
const TextureFormat TEXTURE_FORMAT_RGB10_A2_UINT = 29;
const TextureFormat TEXTURE_FORMAT_RGB10_A2_UNORM = 30;
const TextureFormat TEXTURE_FORMAT_RG11_B10_UFLOAT = 31;
const TextureFormat TEXTURE_FORMAT_RGB9_E5_UFLOAT = 32;
const TextureFormat TEXTURE_FORMAT_RG32_FLOAT = 33;
const TextureFormat TEXTURE_FORMAT_RG32_UINT = 34;
const TextureFormat TEXTURE_FORMAT_RG32_SINT = 35;
const TextureFormat TEXTURE_FORMAT_RGBA16_UNORM = 36;
const TextureFormat TEXTURE_FORMAT_RGBA16_SNORM = 37;
const TextureFormat TEXTURE_FORMAT_RGBA16_UINT = 38;
const TextureFormat TEXTURE_FORMAT_RGBA16_SINT = 39;
const TextureFormat TEXTURE_FORMAT_RGBA16_FLOAT = 40;
const TextureFormat TEXTURE_FORMAT_RGBA32_FLOAT = 41;
const TextureFormat TEXTURE_FORMAT_RGBA32_UINT = 42;
const TextureFormat TEXTURE_FORMAT_RGBA32_SINT = 43;
const TextureFormat TEXTURE_FORMAT_STENCIL8 = 44;
const TextureFormat TEXTURE_FORMAT_DEPTH16_UNORM = 45;
const TextureFormat TEXTURE_FORMAT_DEPTH24_PLUS = 46;
const TextureFormat TEXTURE_FORMAT_DEPTH24_PLUS_STENCIL8 = 47;
const TextureFormat TEXTURE_FORMAT_DEPTH32_FLOAT = 48;
const TextureFormat TEXTURE_FORMAT_DEPTH32_FLOAT_STENCIL8 = 49;
const TextureFormat TEXTURE_FORMAT_BC1_RGBA_UNORM = 50;
const TextureFormat TEXTURE_FORMAT_BC1_RGBA_UNORM_SRGB = 51;
const TextureFormat TEXTURE_FORMAT_BC2_RGBA_UNORM = 52;
const TextureFormat TEXTURE_FORMAT_BC2_RGBA_UNORM_SRGB = 53;
const TextureFormat TEXTURE_FORMAT_BC3_RGBA_UNORM = 54;
const TextureFormat TEXTURE_FORMAT_BC3_RGBA_UNORM_SRGB = 55;
const TextureFormat TEXTURE_FORMAT_BC4_R_UNORM = 56;
const TextureFormat TEXTURE_FORMAT_BC4_R_SNORM = 57;
const TextureFormat TEXTURE_FORMAT_BC5_RG_UNORM = 58;
const TextureFormat TEXTURE_FORMAT_BC5_RG_SNORM = 59;
const TextureFormat TEXTURE_FORMAT_BC6H_RGB_UFLOAT = 60;
const TextureFormat TEXTURE_FORMAT_BC6H_RGB_FLOAT = 61;
const TextureFormat TEXTURE_FORMAT_BC7_RGBA_UNORM = 62;
const TextureFormat TEXTURE_FORMAT_BC7_RGBA_UNORM_SRGB = 63;
const TextureFormat TEXTURE_FORMAT_ETC2_RGB8_UNORM = 64;
const TextureFormat TEXTURE_FORMAT_ETC2_RGB8_UNORM_SRGB = 65;
const TextureFormat TEXTURE_FORMAT_ETC2_RGB8A1_UNORM = 66;
const TextureFormat TEXTURE_FORMAT_ETC2_RGB8A1_UNORM_SRGB = 67;
const TextureFormat TEXTURE_FORMAT_ETC2_RGBA8_UNORM = 68;
const TextureFormat TEXTURE_FORMAT_ETC2_RGBA8_UNORM_SRGB = 69;
const TextureFormat TEXTURE_FORMAT_EAC_R11_UNORM = 70;
const TextureFormat TEXTURE_FORMAT_EAC_R11_SNORM = 71;
const TextureFormat TEXTURE_FORMAT_EAC_RG11_UNORM = 72;
const TextureFormat TEXTURE_FORMAT_EAC_RG11_SNORM = 73;
const TextureFormat TEXTURE_FORMAT_ASTC_4X4_UNORM = 74;
const TextureFormat TEXTURE_FORMAT_ASTC_4X4_UNORM_SRGB = 75;
const TextureFormat TEXTURE_FORMAT_ASTC_5X4_UNORM = 76;
const TextureFormat TEXTURE_FORMAT_ASTC_5X4_UNORM_SRGB = 77;
const TextureFormat TEXTURE_FORMAT_ASTC_5X5_UNORM = 78;
const TextureFormat TEXTURE_FORMAT_ASTC_5X5_UNORM_SRGB = 79;
const TextureFormat TEXTURE_FORMAT_ASTC_6X5_UNORM = 80;
const TextureFormat TEXTURE_FORMAT_ASTC_6X5_UNORM_SRGB = 81;
const TextureFormat TEXTURE_FORMAT_ASTC_6X6_UNORM = 82;
const TextureFormat TEXTURE_FORMAT_ASTC_6X6_UNORM_SRGB = 83;
const TextureFormat TEXTURE_FORMAT_ASTC_8X5_UNORM = 84;
const TextureFormat TEXTURE_FORMAT_ASTC_8X5_UNORM_SRGB = 85;
const TextureFormat TEXTURE_FORMAT_ASTC_8X6_UNORM = 86;
const TextureFormat TEXTURE_FORMAT_ASTC_8X6_UNORM_SRGB = 87;
const TextureFormat TEXTURE_FORMAT_ASTC_8X8_UNORM = 88;
const TextureFormat TEXTURE_FORMAT_ASTC_8X8_UNORM_SRGB = 89;
const TextureFormat TEXTURE_FORMAT_ASTC_10X5_UNORM = 90;
const TextureFormat TEXTURE_FORMAT_ASTC_10X5_UNORM_SRGB = 91;
const TextureFormat TEXTURE_FORMAT_ASTC_10X6_UNORM = 92;
const TextureFormat TEXTURE_FORMAT_ASTC_10X6_UNORM_SRGB = 93;
const TextureFormat TEXTURE_FORMAT_ASTC_10X8_UNORM = 94;
const TextureFormat TEXTURE_FORMAT_ASTC_10X8_UNORM_SRGB = 95;
const TextureFormat TEXTURE_FORMAT_ASTC_10X10_UNORM = 96;
const TextureFormat TEXTURE_FORMAT_ASTC_10X10_UNORM_SRGB = 97;
const TextureFormat TEXTURE_FORMAT_ASTC_12X10_UNORM = 98;
const TextureFormat TEXTURE_FORMAT_ASTC_12X10_UNORM_SRGB = 99;
const TextureFormat TEXTURE_FORMAT_ASTC_12X12_UNORM = 100;
const TextureFormat TEXTURE_FORMAT_ASTC_12X12_UNORM_SRGB = 101;

typedef TextureSampleType = inline uint;
const TextureSampleType TEXTURE_SAMPLE_TYPE_BINDING_NOT_USED = 0;
const TextureSampleType TEXTURE_SAMPLE_TYPE_UNDEFINED = 1;
const TextureSampleType TEXTURE_SAMPLE_TYPE_FLOAT = 2;
const TextureSampleType TEXTURE_SAMPLE_TYPE_UNFILTERABLE_FLOAT = 3;
const TextureSampleType TEXTURE_SAMPLE_TYPE_DEPTH = 4;
const TextureSampleType TEXTURE_SAMPLE_TYPE_SINT = 5;
const TextureSampleType TEXTURE_SAMPLE_TYPE_UINT = 6;

typedef TextureViewDimension = inline uint;
const TextureViewDimension TEXTURE_VIEW_DIMENSION_UNDEFINED = 0;
const TextureViewDimension TEXTURE_VIEW_DIMENSION_1D = 1;
const TextureViewDimension TEXTURE_VIEW_DIMENSION_2D = 2;
const TextureViewDimension TEXTURE_VIEW_DIMENSION_2D_ARRAY = 3;
const TextureViewDimension TEXTURE_VIEW_DIMENSION_CUBE = 4;
const TextureViewDimension TEXTURE_VIEW_DIMENSION_CUBE_ARRAY = 5;
const TextureViewDimension TEXTURE_VIEW_DIMENSION_3D = 6;

typedef ToneMappingMode = inline uint;
const ToneMappingMode TONE_MAPPING_MODE_STANDARD = 1;
const ToneMappingMode TONE_MAPPING_MODE_EXTENDED = 2;

typedef VertexFormat = inline uint;
const VertexFormat VERTEX_FORMAT_UINT8 = 1;
const VertexFormat VERTEX_FORMAT_UINT8X2 = 2;
const VertexFormat VERTEX_FORMAT_UINT8X4 = 3;
const VertexFormat VERTEX_FORMAT_SINT8 = 4;
const VertexFormat VERTEX_FORMAT_SINT8X2 = 5;
const VertexFormat VERTEX_FORMAT_SINT8X4 = 6;
const VertexFormat VERTEX_FORMAT_UNORM8 = 7;
const VertexFormat VERTEX_FORMAT_UNORM8X2 = 8;
const VertexFormat VERTEX_FORMAT_UNORM8X4 = 9;
const VertexFormat VERTEX_FORMAT_SNORM8 = 10;
const VertexFormat VERTEX_FORMAT_SNORM8X2 = 11;
const VertexFormat VERTEX_FORMAT_SNORM8X4 = 12;
const VertexFormat VERTEX_FORMAT_UINT16 = 13;
const VertexFormat VERTEX_FORMAT_UINT16X2 = 14;
const VertexFormat VERTEX_FORMAT_UINT16X4 = 15;
const VertexFormat VERTEX_FORMAT_SINT16 = 16;
const VertexFormat VERTEX_FORMAT_SINT16X2 = 17;
const VertexFormat VERTEX_FORMAT_SINT16X4 = 18;
const VertexFormat VERTEX_FORMAT_UNORM16 = 19;
const VertexFormat VERTEX_FORMAT_UNORM16X2 = 20;
const VertexFormat VERTEX_FORMAT_UNORM16X4 = 21;
const VertexFormat VERTEX_FORMAT_SNORM16 = 22;
const VertexFormat VERTEX_FORMAT_SNORM16X2 = 23;
const VertexFormat VERTEX_FORMAT_SNORM16X4 = 24;
const VertexFormat VERTEX_FORMAT_FLOAT16 = 25;
const VertexFormat VERTEX_FORMAT_FLOAT16X2 = 26;
const VertexFormat VERTEX_FORMAT_FLOAT16X4 = 27;
const VertexFormat VERTEX_FORMAT_FLOAT32 = 28;
const VertexFormat VERTEX_FORMAT_FLOAT32X2 = 29;
const VertexFormat VERTEX_FORMAT_FLOAT32X3 = 30;
const VertexFormat VERTEX_FORMAT_FLOAT32X4 = 31;
const VertexFormat VERTEX_FORMAT_UINT32 = 32;
const VertexFormat VERTEX_FORMAT_UINT32X2 = 33;
const VertexFormat VERTEX_FORMAT_UINT32X3 = 34;
const VertexFormat VERTEX_FORMAT_UINT32X4 = 35;
const VertexFormat VERTEX_FORMAT_SINT32 = 36;
const VertexFormat VERTEX_FORMAT_SINT32X2 = 37;
const VertexFormat VERTEX_FORMAT_SINT32X3 = 38;
const VertexFormat VERTEX_FORMAT_SINT32X4 = 39;
const VertexFormat VERTEX_FORMAT_UNORM10__10__10__2 = 40;
const VertexFormat VERTEX_FORMAT_UNORM8X4_B_G_R_A = 41;

typedef VertexStepMode = inline uint;
const VertexStepMode VERTEX_STEP_MODE_UNDEFINED = 0;
const VertexStepMode VERTEX_STEP_MODE_VERTEX = 1;
const VertexStepMode VERTEX_STEP_MODE_INSTANCE = 2;

typedef WaitStatus = inline uint;
const WaitStatus WAIT_STATUS_SUCCESS = 1;
const WaitStatus WAIT_STATUS_TIMED_OUT = 2;
const WaitStatus WAIT_STATUS_ERROR = 3;

typedef WGSLLanguageFeatureName = inline uint;
const WGSLLanguageFeatureName WGSL_LANGUAGE_FEATURE_NAME_READONLY_AND_READWRITE_STORAGE_TEXTURES = 1;
const WGSLLanguageFeatureName WGSL_LANGUAGE_FEATURE_NAME_PACKED4X8_INTEGER_DOT_PRODUCT = 2;
const WGSLLanguageFeatureName WGSL_LANGUAGE_FEATURE_NAME_UNRESTRICTED_POINTER_PARAMETERS = 3;
const WGSLLanguageFeatureName WGSL_LANGUAGE_FEATURE_NAME_POINTER_COMPOSITE_ACCESS = 4;
const WGSLLanguageFeatureName WGSL_LANGUAGE_FEATURE_NAME_UNIFORM_BUFFER_STANDARD_LAYOUT = 5;
const WGSLLanguageFeatureName WGSL_LANGUAGE_FEATURE_NAME_SUBGROUP_ID = 6;
const WGSLLanguageFeatureName WGSL_LANGUAGE_FEATURE_NAME_TEXTURE_AND_SAMPLER_LET = 7;
const WGSLLanguageFeatureName WGSL_LANGUAGE_FEATURE_NAME_SUBGROUP_UNIFORMITY = 8;
const WGSLLanguageFeatureName WGSL_LANGUAGE_FEATURE_NAME_TEXTURE_FORMATS_TIER1 = 9;

// Bitflags
typedef BufferUsage = inline ulong;
const BufferUsage BUFFER_USAGE_NONE = 0;
const BufferUsage BUFFER_USAGE_MAP_READ = 0x00000001;
const BufferUsage BUFFER_USAGE_MAP_WRITE = 0x00000002;
const BufferUsage BUFFER_USAGE_COPY_SRC = 0x00000004;
const BufferUsage BUFFER_USAGE_COPY_DST = 0x00000008;
const BufferUsage BUFFER_USAGE_INDEX = 0x00000010;
const BufferUsage BUFFER_USAGE_VERTEX = 0x00000020;
const BufferUsage BUFFER_USAGE_UNIFORM = 0x00000040;
const BufferUsage BUFFER_USAGE_STORAGE = 0x00000080;
const BufferUsage BUFFER_USAGE_INDIRECT = 0x00000100;
const BufferUsage BUFFER_USAGE_QUERY_RESOLVE = 0x00000200;

typedef ColorWriteMask = inline ulong;
const ColorWriteMask COLOR_WRITE_MASK_NONE = 0;
const ColorWriteMask COLOR_WRITE_MASK_RED = 0x00000001;
const ColorWriteMask COLOR_WRITE_MASK_GREEN = 0x00000002;
const ColorWriteMask COLOR_WRITE_MASK_BLUE = 0x00000004;
const ColorWriteMask COLOR_WRITE_MASK_ALPHA = 0x00000008;
const ColorWriteMask COLOR_WRITE_MASK_ALL = COLOR_WRITE_MASK_RED | COLOR_WRITE_MASK_GREEN | COLOR_WRITE_MASK_BLUE | COLOR_WRITE_MASK_ALPHA;

typedef MapMode = inline ulong;
const MapMode MAP_MODE_NONE = 0;
const MapMode MAP_MODE_READ = 0x00000001;
const MapMode MAP_MODE_WRITE = 0x00000002;

typedef ShaderStage = inline ulong;
const ShaderStage SHADER_STAGE_NONE = 0;
const ShaderStage SHADER_STAGE_VERTEX = 0x00000001;
const ShaderStage SHADER_STAGE_FRAGMENT = 0x00000002;
const ShaderStage SHADER_STAGE_COMPUTE = 0x00000004;

typedef TextureUsage = inline ulong;
const TextureUsage TEXTURE_USAGE_NONE = 0;
const TextureUsage TEXTURE_USAGE_COPY_SRC = 0x00000001;
const TextureUsage TEXTURE_USAGE_COPY_DST = 0x00000002;
const TextureUsage TEXTURE_USAGE_TEXTURE_BINDING = 0x00000004;
const TextureUsage TEXTURE_USAGE_STORAGE_BINDING = 0x00000008;
const TextureUsage TEXTURE_USAGE_RENDER_ATTACHMENT = 0x00000010;
const TextureUsage TEXTURE_USAGE_TRANSIENT_ATTACHMENT = 0x00000020;

// Structs
struct AdapterInfo {
    char* vendor;
    char* architecture;
    char* device;
    char* description;
    BackendType backend_type;
    AdapterType adapter_type;
    uint vendor_ID;
    uint device_ID;
    uint subgroup_min_size;
    uint subgroup_max_size;
}

struct BindGroupDescriptor {
    char* label;
    BindGroupLayout layout;
    usz entries_count;
    BindGroupEntry* entries;
}

struct BindGroupEntry {
    uint binding;
    Buffer buffer;
    ulong offset;
    ulong size;
    Sampler sampler;
    TextureView texture_view;
}

struct BindGroupLayoutDescriptor {
    char* label;
    usz entries_count;
    BindGroupLayoutEntry* entries;
}

struct BindGroupLayoutEntry {
    uint binding;
    ShaderStage visibility;
    uint binding_array_size;
    BufferBindingLayout buffer;
    SamplerBindingLayout sampler;
    TextureBindingLayout texture;
    StorageTextureBindingLayout storage_texture;
}

struct BlendComponent {
    BlendOperation operation;
    BlendFactor src_factor;
    BlendFactor dst_factor;
}

struct BlendState {
    BlendComponent color;
    BlendComponent alpha;
}

struct BufferBindingLayout {
    BufferBindingType type;
    bool has_dynamic_offset;
    ulong min_binding_size;
}

struct BufferDescriptor {
    char* label;
    BufferUsage usage;
    ulong size;
    bool mapped_at_creation;
}

struct Color {
    double r;
    double g;
    double b;
    double a;
}

struct ColorTargetState {
    TextureFormat format;
    BlendState* blend;
    ColorWriteMask write_mask;
}

struct CommandBufferDescriptor {
    char* label;
}

struct CommandEncoderDescriptor {
    char* label;
}

struct CompilationInfo {
    usz messages_count;
    CompilationMessage* messages;
}

struct CompilationMessage {
    char* message;
    CompilationMessageType type;
    ulong line_num;
    ulong line_pos;
    ulong offset;
    ulong length;
}

struct ComputePassDescriptor {
    char* label;
    PassTimestampWrites* timestamp_writes;
}

struct ComputePipelineDescriptor {
    char* label;
    PipelineLayout layout;
    ComputeState compute;
}

struct ComputeState {
    ShaderModule module;
    char* entry_point;
    usz constants_count;
    ConstantEntry* constants;
}

struct ConstantEntry {
    char* key;
    double value;
}

struct DepthStencilState {
    TextureFormat format;
    OptionalBool depth_write_enabled;
    CompareFunction depth_compare;
    StencilFaceState stencil_front;
    StencilFaceState stencil_back;
    uint stencil_read_mask;
    uint stencil_write_mask;
    int depth_bias;
    float depth_bias_slope_scale;
    float depth_bias_clamp;
}

struct DeviceDescriptor {
    char* label;
    usz required_features_count;
    FeatureName* required_features;
    Limits* required_limits;
    QueueDescriptor default_queue;
    WGPUDeviceLostCallback device_lost_callback_info;
    WGPUUncapturedErrorCallback uncaptured_error_callback_info;
}

struct Extent3D {
    uint width;
    uint height;
    uint depth_or_array_layers;
}

struct ExternalTextureBindingEntry {
    ExternalTexture external_texture;
}

struct ExternalTextureBindingLayout {
}

struct FragmentState {
    ShaderModule module;
    char* entry_point;
    usz constants_count;
    ConstantEntry* constants;
    usz targets_count;
    ColorTargetState* targets;
}

struct Future {
    ulong id;
}

struct FutureWaitInfo {
    Future future;
    bool completed;
}

struct InstanceDescriptor {
    usz required_features_count;
    InstanceFeatureName* required_features;
    InstanceLimits* required_limits;
}

struct InstanceLimits {
    usz timed_wait_any_max_count;
}

struct Limits {
    uint max_texture_dimension_1D;
    uint max_texture_dimension_2D;
    uint max_texture_dimension_3D;
    uint max_texture_array_layers;
    uint max_bind_groups;
    uint max_bind_groups_plus_vertex_buffers;
    uint max_bindings_per_bind_group;
    uint max_dynamic_uniform_buffers_per_pipeline_layout;
    uint max_dynamic_storage_buffers_per_pipeline_layout;
    uint max_sampled_textures_per_shader_stage;
    uint max_samplers_per_shader_stage;
    uint max_storage_buffers_per_shader_stage;
    uint max_storage_textures_per_shader_stage;
    uint max_uniform_buffers_per_shader_stage;
    ulong max_uniform_buffer_binding_size;
    ulong max_storage_buffer_binding_size;
    uint min_uniform_buffer_offset_alignment;
    uint min_storage_buffer_offset_alignment;
    uint max_vertex_buffers;
    ulong max_buffer_size;
    uint max_vertex_attributes;
    uint max_vertex_buffer_array_stride;
    uint max_inter_stage_shader_variables;
    uint max_color_attachments;
    uint max_color_attachment_bytes_per_sample;
    uint max_compute_workgroup_storage_size;
    uint max_compute_invocations_per_workgroup;
    uint max_compute_workgroup_size_x;
    uint max_compute_workgroup_size_y;
    uint max_compute_workgroup_size_z;
    uint max_compute_workgroups_per_dimension;
    uint max_immediate_size;
}

struct MultisampleState {
    uint count;
    uint mask;
    bool alpha_to_coverage_enabled;
}

struct Origin3D {
    uint x;
    uint y;
    uint z;
}

struct PassTimestampWrites {
    QuerySet query_set;
    uint beginning_of_pass_write_index;
    uint end_of_pass_write_index;
}

struct PipelineLayoutDescriptor {
    char* label;
    usz bind_group_layouts_count;
    BindGroupLayout* bind_group_layouts;
    uint immediate_size;
}

struct PrimitiveState {
    PrimitiveTopology topology;
    IndexFormat strip_index_format;
    FrontFace front_face;
    CullMode cull_mode;
    bool unclipped_depth;
}

struct QuerySetDescriptor {
    char* label;
    QueryType type;
    uint count;
}

struct QueueDescriptor {
    char* label;
}

struct RenderBundleDescriptor {
    char* label;
}

struct RenderBundleEncoderDescriptor {
    char* label;
    usz color_formats_count;
    TextureFormat* color_formats;
    TextureFormat depth_stencil_format;
    uint sample_count;
    bool depth_read_only;
    bool stencil_read_only;
}

struct RenderPassColorAttachment {
    TextureView view;
    uint depth_slice;
    TextureView resolve_target;
    LoadOp load_op;
    StoreOp store_op;
    Color clear_value;
}

struct RenderPassDepthStencilAttachment {
    TextureView view;
    LoadOp depth_load_op;
    StoreOp depth_store_op;
    float depth_clear_value;
    bool depth_read_only;
    LoadOp stencil_load_op;
    StoreOp stencil_store_op;
    uint stencil_clear_value;
    bool stencil_read_only;
}

struct RenderPassDescriptor {
    char* label;
    usz color_attachments_count;
    RenderPassColorAttachment* color_attachments;
    RenderPassDepthStencilAttachment* depth_stencil_attachment;
    QuerySet occlusion_query_set;
    PassTimestampWrites* timestamp_writes;
}

struct RenderPassMaxDrawCount {
    ulong max_draw_count;
}

struct RenderPipelineDescriptor {
    char* label;
    PipelineLayout layout;
    VertexState vertex;
    PrimitiveState primitive;
    DepthStencilState* depth_stencil;
    MultisampleState multisample;
    FragmentState* fragment;
}

struct RequestAdapterOptions {
    FeatureLevel feature_level;
    PowerPreference power_preference;
    bool force_fallback_adapter;
    BackendType backend_type;
    Surface compatible_surface;
}

struct RequestAdapterWebXROptions {
    bool xr_compatible;
}

struct SamplerBindingLayout {
    SamplerBindingType type;
}

struct SamplerDescriptor {
    char* label;
    AddressMode address_mode_u;
    AddressMode address_mode_v;
    AddressMode address_mode_w;
    FilterMode mag_filter;
    FilterMode min_filter;
    MipmapFilterMode mipmap_filter;
    float lod_min_clamp;
    float lod_max_clamp;
    CompareFunction compare;
    ushort max_anisotropy;
}

struct ShaderModuleDescriptor {
    char* label;
}

struct ShaderSourceSPIRV {
    uint code_size;
    uint* code;
}

struct ShaderSourceWGSL {
    char* code;
}

struct StencilFaceState {
    CompareFunction compare;
    StencilOperation fail_op;
    StencilOperation depth_fail_op;
    StencilOperation pass_op;
}

struct StorageTextureBindingLayout {
    StorageTextureAccess access;
    TextureFormat format;
    TextureViewDimension view_dimension;
}

struct SupportedFeatures {
    usz features_count;
    FeatureName* features;
}

struct SupportedInstanceFeatures {
    usz features_count;
    InstanceFeatureName* features;
}

struct SupportedWGSLLanguageFeatures {
    usz features_count;
    WGSLLanguageFeatureName* features;
}

struct SurfaceCapabilities {
    TextureUsage usages;
    usz formats_count;
    TextureFormat* formats;
    usz present_modes_count;
    PresentMode* present_modes;
    usz alpha_modes_count;
    CompositeAlphaMode* alpha_modes;
}

struct SurfaceColorManagement {
    PredefinedColorSpace color_space;
    ToneMappingMode tone_mapping_mode;
}

struct SurfaceConfiguration {
    Device device;
    TextureFormat format;
    TextureUsage usage;
    uint width;
    uint height;
    usz view_formats_count;
    TextureFormat* view_formats;
    CompositeAlphaMode alpha_mode;
    PresentMode present_mode;
}

struct SurfaceDescriptor {
    char* label;
}

struct SurfaceSourceAndroidNativeWindow {
    void* window;
}

struct SurfaceSourceMetalLayer {
    void* layer;
}

struct SurfaceSourceWaylandSurface {
    void* display;
    void* surface;
}

struct SurfaceSourceWindowsHWND {
    void* hinstance;
    void* hwnd;
}

struct SurfaceSourceXCBWindow {
    void* connection;
    uint window;
}

struct SurfaceSourceXlibWindow {
    void* display;
    ulong window;
}

struct SurfaceTexture {
    Texture texture;
    SurfaceGetCurrentTextureStatus status;
}

struct TexelCopyBufferInfo {
    TexelCopyBufferLayout layout;
    Buffer buffer;
}

struct TexelCopyBufferLayout {
    ulong offset;
    uint bytes_per_row;
    uint rows_per_image;
}

struct TexelCopyTextureInfo {
    Texture texture;
    uint mip_level;
    Origin3D origin;
    TextureAspect aspect;
}

struct TextureBindingLayout {
    TextureSampleType sample_type;
    TextureViewDimension view_dimension;
    bool multisampled;
}

struct TextureComponentSwizzle {
    ComponentSwizzle r;
    ComponentSwizzle g;
    ComponentSwizzle b;
    ComponentSwizzle a;
}

struct TextureComponentSwizzleDescriptor {
    TextureComponentSwizzle swizzle;
}

struct TextureDescriptor {
    char* label;
    TextureUsage usage;
    TextureDimension dimension;
    Extent3D size;
    TextureFormat format;
    uint mip_level_count;
    uint sample_count;
    usz view_formats_count;
    TextureFormat* view_formats;
}

struct TextureViewDescriptor {
    char* label;
    TextureFormat format;
    TextureViewDimension dimension;
    uint base_mip_level;
    uint mip_level_count;
    uint base_array_layer;
    uint array_layer_count;
    TextureAspect aspect;
    TextureUsage usage;
}

struct VertexAttribute {
    VertexFormat format;
    ulong offset;
    uint shader_location;
}

struct VertexBufferLayout {
    VertexStepMode step_mode;
    ulong array_stride;
    usz attributes_count;
    VertexAttribute* attributes;
}

struct VertexState {
    ShaderModule module;
    char* entry_point;
    usz constants_count;
    ConstantEntry* constants;
    usz buffers_count;
    VertexBufferLayout* buffers;
}

