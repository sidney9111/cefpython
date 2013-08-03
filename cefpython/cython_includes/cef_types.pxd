# Copyright (c) 2012-2013 The CEF Python authors. All rights reserved.
# License: New BSD License.
# Website: http://code.google.com/p/cefpython/

include "compile_time_constants.pxi"
from libcpp cimport bool as cpp_bool

IF UNAME_SYSNAME == "Windows":
    from stddef cimport wchar_t

cdef extern from "include/internal/cef_types.h":

    IF CEF_VERSION == 1:
        cdef enum cef_log_severity_t:
            LOGSEVERITY_VERBOSE = -1,
            LOGSEVERITY_INFO,
            LOGSEVERITY_WARNING,
            LOGSEVERITY_ERROR,
            LOGSEVERITY_ERROR_REPORT,
            LOGSEVERITY_DISABLE = 99,
    ELIF CEF_VERSION == 3:
        cdef enum cef_log_severity_t:
            LOGSEVERITY_DEFAULT,
            LOGSEVERITY_VERBOSE,
            LOGSEVERITY_INFO,
            LOGSEVERITY_WARNING,
            LOGSEVERITY_ERROR,
            LOGSEVERITY_ERROR_REPORT,
            LOGSEVERITY_DISABLE = 99,

    IF CEF_VERSION == 1:
        cdef enum cef_thread_id_t:
            TID_UI = 0,
            TID_IO = 1,
            TID_FILE = 2,
    ELIF CEF_VERSION == 3:
        cdef enum cef_thread_id_t:
            TID_UI,
            TID_DB,
            TID_FILE,
            TID_FILE_USER_BLOCKING,
            TID_PROCESS_LAUNCHER,
            TID_CACHE,
            TID_IO,
            TID_RENDERER

    ctypedef long long int64
    ctypedef unsigned int uint32
    ctypedef int int32

    IF UNAME_SYSNAME == "Windows":
        ctypedef wchar_t char16
    ELSE:
        ctypedef unsigned short char16

    IF CEF_VERSION == 1:
        # LoadHandler > OnLoadError - ErrorCode.
        # Some of the constants are missing, for an up to date list see:
        # http://src.chromium.org/viewvc/chrome/trunk/src/net/base/net_error_list.h?view=markup
        cdef enum cef_handler_errorcode_t:
            ERR_NONE = 0,
            ERR_FAILED = -2,
            ERR_ABORTED = -3,
            ERR_INVALID_ARGUMENT = -4,
            ERR_INVALID_HANDLE = -5,
            ERR_FILE_NOT_FOUND = -6,
            ERR_TIMED_OUT = -7,
            ERR_FILE_TOO_BIG = -8,
            ERR_UNEXPECTED = -9,
            ERR_ACCESS_DENIED = -10,
            ERR_NOT_IMPLEMENTED = -11,
            ERR_CONNECTION_CLOSED = -100,
            ERR_CONNECTION_RESET = -101,
            ERR_CONNECTION_REFUSED = -102,
            ERR_CONNECTION_ABORTED = -103,
            ERR_CONNECTION_FAILED = -104,
            ERR_NAME_NOT_RESOLVED = -105,
            ERR_INTERNET_DISCONNECTED = -106,
            ERR_SSL_PROTOCOL_ERROR = -107,
            ERR_ADDRESS_INVALID = -108,
            ERR_ADDRESS_UNREACHABLE = -109,
            ERR_SSL_CLIENT_AUTH_CERT_NEEDED = -110,
            ERR_TUNNEL_CONNECTION_FAILED = -111,
            ERR_NO_SSL_VERSIONS_ENABLED = -112,
            ERR_SSL_VERSION_OR_CIPHER_MISMATCH = -113,
            ERR_SSL_RENEGOTIATION_REQUESTED = -114,
            ERR_CERT_COMMON_NAME_INVALID = -200,
            ERR_CERT_DATE_INVALID = -201,
            ERR_CERT_AUTHORITY_INVALID = -202,
            ERR_CERT_CONTAINS_ERRORS = -203,
            ERR_CERT_NO_REVOCATION_MECHANISM = -204,
            ERR_CERT_UNABLE_TO_CHECK_REVOCATION = -205,
            ERR_CERT_REVOKED = -206,
            ERR_CERT_INVALID = -207,
            ERR_CERT_END = -208,
            ERR_INVALID_URL = -300,
            ERR_DISALLOWED_URL_SCHEME = -301,
            ERR_UNKNOWN_URL_SCHEME = -302,
            ERR_TOO_MANY_REDIRECTS = -310,
            ERR_UNSAFE_REDIRECT = -311,
            ERR_UNSAFE_PORT = -312,
            ERR_INVALID_RESPONSE = -320,
            ERR_INVALID_CHUNKED_ENCODING = -321,
            ERR_METHOD_NOT_SUPPORTED = -322,
            ERR_UNEXPECTED_PROXY_AUTH = -323,
            ERR_EMPTY_RESPONSE = -324,
            ERR_RESPONSE_HEADERS_TOO_BIG = -325,
            ERR_CACHE_MISS = -400,
            ERR_INSECURE_RESPONSE = -501,

        # KeyboardHandler > OnKeyEvent - KeyEventType.
        cdef enum cef_handler_keyevent_type_t:
            KEYEVENT_RAWKEYDOWN = 0,
            KEYEVENT_KEYDOWN,
            KEYEVENT_KEYUP,
            KEYEVENT_CHAR
        cdef enum cef_handler_keyevent_modifiers_t:
            KEY_SHIFT = 1 << 0,
            KEY_CTRL = 1 << 1,
            KEY_ALT = 1 << 2,
            KEY_META  = 1 << 3,
            KEY_KEYPAD = 1 << 4,  # Only used on Mac OS-X

    cdef enum cef_v8_propertyattribute_t:
        V8_PROPERTY_ATTRIBUTE_NONE = 0,       # Writeable, Enumerable,
        #  Configurable
        V8_PROPERTY_ATTRIBUTE_READONLY = 1 << 0,  # Not writeable
        V8_PROPERTY_ATTRIBUTE_DONTENUM = 1 << 1,  # Not enumerable
        V8_PROPERTY_ATTRIBUTE_DONTDELETE = 1 << 2   # Not configurable

    IF CEF_VERSION == 1:
        # CefRequestHandler > OnBeforeBrowse > NavType
        cdef enum cef_handler_navtype_t:
            NAVTYPE_LINKCLICKED = 0,
            NAVTYPE_FORMSUBMITTED,
            NAVTYPE_BACKFORWARD,
            NAVTYPE_RELOAD,
            NAVTYPE_FORMRESUBMITTED,
            NAVTYPE_OTHER,
            NAVTYPE_LINKDROPPED
    ELIF CEF_VERSION == 3:
        cdef enum cef_navigation_type_t:
            NAVIGATION_LINK_CLICKED = 0,
            NAVIGATION_FORM_SUBMITTED,
            NAVIGATION_BACK_FORWARD,
            NAVIGATION_RELOAD,
            NAVIGATION_FORM_RESUBMITTED,
            NAVIGATION_OTHER,

    IF CEF_VERSION == 1:
        # CefDisplayHandler > StatusType
        cdef enum cef_handler_statustype_t:
            STATUSTYPE_TEXT = 0,
            STATUSTYPE_MOUSEOVER_URL,
            STATUSTYPE_KEYBOARD_FOCUS_URL,

    IF CEF_VERSION == 3:
        cdef enum cef_process_id_t:
            PID_BROWSER,
            PID_RENDERER,

    IF CEF_VERSION == 1:
        # Browser > GetImage(), RenderHandler > OnPaint().
        ctypedef enum cef_paint_element_type_t:
            PET_VIEW = 0,
            PET_POPUP,

        # Browser > SendKeyEvent().
        ctypedef enum cef_key_type_t:
            KT_KEYUP = 0,
            KT_KEYDOWN,
            KT_CHAR,

        # Browser > SendMouseClickEvent().
        ctypedef enum cef_mouse_button_type_t:
            MBT_LEFT = 0,
            MBT_MIDDLE,
            MBT_RIGHT,

    IF CEF_VERSION == 3:
        ctypedef enum cef_state_t:
            STATE_DEFAULT = 0,
            STATE_ENABLED,
            STATE_DISABLED,

    # CefRequest
    IF CEF_VERSION == 1:
        enum cef_postdataelement_type_t:
          PDE_TYPE_EMPTY  = 0,
          PDE_TYPE_BYTES,
          PDE_TYPE_FILE,

        enum cef_weburlrequest_flags_t:
          WUR_FLAG_NONE = 0,
          WUR_FLAG_SKIP_CACHE = 0x1,
          WUR_FLAG_ALLOW_CACHED_CREDENTIALS = 0x2,
          WUR_FLAG_ALLOW_COOKIES = 0x4,
          WUR_FLAG_REPORT_UPLOAD_PROGRESS = 0x8,
          WUR_FLAG_REPORT_LOAD_TIMING = 0x10,
          WUR_FLAG_REPORT_RAW_HEADERS = 0x20

        enum cef_weburlrequest_state_t:
          WUR_STATE_UNSENT = 0,
          WUR_STATE_STARTED = 1,
          WUR_STATE_HEADERS_RECEIVED = 2,
          WUR_STATE_LOADING = 3,
          WUR_STATE_DONE = 4,
          WUR_STATE_ERROR = 5,
          WUR_STATE_ABORT = 6,

    IF CEF_VERSION == 3:
        enum cef_postdataelement_type_t:
            PDE_TYPE_EMPTY  = 0,
            PDE_TYPE_BYTES,
            PDE_TYPE_FILE,
        
        # WebRequest
        enum cef_urlrequest_flags_t:
            UR_FLAG_NONE                      = 0,
            UR_FLAG_SKIP_CACHE                = 1 << 0,
            UR_FLAG_ALLOW_CACHED_CREDENTIALS  = 1 << 1,
            UR_FLAG_ALLOW_COOKIES             = 1 << 2,
            UR_FLAG_REPORT_UPLOAD_PROGRESS    = 1 << 3,
            UR_FLAG_REPORT_LOAD_TIMING        = 1 << 4,
            UR_FLAG_REPORT_RAW_HEADERS        = 1 << 5,
            UR_FLAG_NO_DOWNLOAD_DATA          = 1 << 6,
            UR_FLAG_NO_RETRY_ON_5XX           = 1 << 7,

        # CefListValue, CefDictionaryValue - types.
        enum cef_value_type_t:
            VTYPE_INVALID = 0,
            VTYPE_NULL,
            VTYPE_BOOL,
            VTYPE_INT,
            VTYPE_DOUBLE,
            VTYPE_STRING,
            VTYPE_BINARY,
            VTYPE_DICTIONARY,
            VTYPE_LIST,

        # KeyboardHandler
        ctypedef void* CefEventHandle
        ctypedef enum cef_key_event_type_t:
            KEYEVENT_RAWKEYDOWN = 0,
            KEYEVENT_KEYDOWN,
            KEYEVENT_KEYUP,
            KEYEVENT_CHAR
        ctypedef struct _cef_key_event_t:
            cef_key_event_type_t type
            uint32 modifiers
            int windows_key_code
            int native_key_code
            int is_system_key
            char16 character
            char16 unmodified_character
            cpp_bool focus_on_editable_field
        ctypedef _cef_key_event_t CefKeyEvent
        enum cef_event_flags_t:
            EVENTFLAG_NONE                = 0,
            EVENTFLAG_CAPS_LOCK_ON        = 1 << 0,
            EVENTFLAG_SHIFT_DOWN          = 1 << 1,
            EVENTFLAG_CONTROL_DOWN        = 1 << 2,
            EVENTFLAG_ALT_DOWN            = 1 << 3,
            EVENTFLAG_LEFT_MOUSE_BUTTON   = 1 << 4,
            EVENTFLAG_MIDDLE_MOUSE_BUTTON = 1 << 5,
            EVENTFLAG_RIGHT_MOUSE_BUTTON  = 1 << 6,
            # Mac OS-X command key.
            EVENTFLAG_COMMAND_DOWN        = 1 << 7,
            EVENTFLAG_NUM_LOCK_ON         = 1 << 8,
            EVENTFLAG_IS_KEY_PAD          = 1 << 9,
            EVENTFLAG_IS_LEFT             = 1 << 10,
            EVENTFLAG_IS_RIGHT            = 1 << 11,

        # LoadHandler
        enum cef_termination_status_t:
            TS_ABNORMAL_TERMINATION,
            TS_PROCESS_WAS_KILLED,
            TS_PROCESS_CRASHED,
        enum cef_errorcode_t:
            ERR_NONE = 0,
            ERR_FAILED = -2,
            ERR_ABORTED = -3,
            ERR_INVALID_ARGUMENT = -4,
            ERR_INVALID_HANDLE = -5,
            ERR_FILE_NOT_FOUND = -6,
            ERR_TIMED_OUT = -7,
            ERR_FILE_TOO_BIG = -8,
            ERR_UNEXPECTED = -9,
            ERR_ACCESS_DENIED = -10,
            ERR_NOT_IMPLEMENTED = -11,
            ERR_CONNECTION_CLOSED = -100,
            ERR_CONNECTION_RESET = -101,
            ERR_CONNECTION_REFUSED = -102,
            ERR_CONNECTION_ABORTED = -103,
            ERR_CONNECTION_FAILED = -104,
            ERR_NAME_NOT_RESOLVED = -105,
            ERR_INTERNET_DISCONNECTED = -106,
            ERR_SSL_PROTOCOL_ERROR = -107,
            ERR_ADDRESS_INVALID = -108,
            ERR_ADDRESS_UNREACHABLE = -109,
            ERR_SSL_CLIENT_AUTH_CERT_NEEDED = -110,
            ERR_TUNNEL_CONNECTION_FAILED = -111,
            ERR_NO_SSL_VERSIONS_ENABLED = -112,
            ERR_SSL_VERSION_OR_CIPHER_MISMATCH = -113,
            ERR_SSL_RENEGOTIATION_REQUESTED = -114,
            ERR_CERT_COMMON_NAME_INVALID = -200,
            ERR_CERT_DATE_INVALID = -201,
            ERR_CERT_AUTHORITY_INVALID = -202,
            ERR_CERT_CONTAINS_ERRORS = -203,
            ERR_CERT_NO_REVOCATION_MECHANISM = -204,
            ERR_CERT_UNABLE_TO_CHECK_REVOCATION = -205,
            ERR_CERT_REVOKED = -206,
            ERR_CERT_INVALID = -207,
            ERR_CERT_END = -208,
            ERR_INVALID_URL = -300,
            ERR_DISALLOWED_URL_SCHEME = -301,
            ERR_UNKNOWN_URL_SCHEME = -302,
            ERR_TOO_MANY_REDIRECTS = -310,
            ERR_UNSAFE_REDIRECT = -311,
            ERR_UNSAFE_PORT = -312,
            ERR_INVALID_RESPONSE = -320,
            ERR_INVALID_CHUNKED_ENCODING = -321,
            ERR_METHOD_NOT_SUPPORTED = -322,
            ERR_UNEXPECTED_PROXY_AUTH = -323,
            ERR_EMPTY_RESPONSE = -324,
            ERR_RESPONSE_HEADERS_TOO_BIG = -325,
            ERR_CACHE_MISS = -400,
            ERR_INSECURE_RESPONSE = -501,
