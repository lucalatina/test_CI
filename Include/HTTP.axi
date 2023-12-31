PROGRAM_NAME='HTTP'
/**
 * A minimal HTTP library for working with web services natively in NetLinx.
 *
 * ...still not sure why this isn't a builtin library...
 
 https://github.com/ciasia/http
 
 */
#define HTTP_RESPONSE_CALLBACK

define_constant

// Due the the way NetLinx works timeline event handlers cannot use an id array.
// If changing this value, update event handler and definitions below for the
// response timeout timelines to match.
integer HTTP_MAX_PARALLEL_REQUESTS = 15

integer HTTP_BASE_PORT = 10
integer HTTP_MAX_REQUEST_LENGTH = 4096
integer HTTP_MAX_RESPONSE_LENGTH = 16384
integer HTTP_MAX_LINE_LENGTH = 2048

long HTTP_TIMEOUT_TL_1 = 30
long HTTP_TIMEOUT_TL_2 = 31
long HTTP_TIMEOUT_TL_3 = 32
long HTTP_TIMEOUT_TL_4 = 33
long HTTP_TIMEOUT_TL_5 = 34
long HTTP_TIMEOUT_TL_6 = 35
long HTTP_TIMEOUT_TL_7 = 36
long HTTP_TIMEOUT_TL_8 = 37
long HTTP_TIMEOUT_TL_9 = 38
long HTTP_TIMEOUT_TL_10 = 39
long HTTP_TIMEOUT_TL_11 = 40
long HTTP_TIMEOUT_TL_12 = 41
long HTTP_TIMEOUT_TL_13 = 42
long HTTP_TIMEOUT_TL_14 = 43
long HTTP_TIMEOUT_TL_15 = 44
long HTTP_TIMEOUT_TL[] = {
    HTTP_TIMEOUT_TL_1,
    HTTP_TIMEOUT_TL_2,
    HTTP_TIMEOUT_TL_3,
    HTTP_TIMEOUT_TL_4,
    HTTP_TIMEOUT_TL_5,
    HTTP_TIMEOUT_TL_6,
    HTTP_TIMEOUT_TL_7,
    HTTP_TIMEOUT_TL_8,
    HTTP_TIMEOUT_TL_9,
    HTTP_TIMEOUT_TL_10,
    HTTP_TIMEOUT_TL_11,
    HTTP_TIMEOUT_TL_12,
    HTTP_TIMEOUT_TL_13,
    HTTP_TIMEOUT_TL_14,
    HTTP_TIMEOUT_TL_15
}
long HTTP_TIMEOUT_INTERVAL[] = {10000}

integer HTTP_ERR_RESPONSE_TIME_OUT = 1
integer HTTP_ERR_NO_MEM = 2
integer HTTP_ERR_UNKNOWN_HOST = 4
integer HTTP_ERR_CONNECTION_REFUSED = 6
integer HTTP_ERR_CONNECT_TIME_OUT = 7
integer HTTP_ERR_UNKNOWN = 8
integer HTTP_ERR_ALREADY_CLOSED = 9
integer HTTP_ERR_LOCAL_PORT_ALREADY_USED = 14
integer HTTP_ERR_TOO_MANY_OPEN_SOCKETS = 16
integer HTTP_ERR_LOCAL_PORT_NOT_OPEN = 17
integer HTTP_ERR_MALFORMED_RESPONSE = 18
char HTTP_ERR_TEXT[][32] = {
    'response time out',
    'out of memory',
    'error 3 - unknown',
    'unknown host',
    'error 5 - unknown',
    'connection refused',
    'connect time out',
    'error 8 - unknown',
    'already closed',
    'error 10 - unknown',
    'error 11 - unknown',
    'error 12 - unknown',
    'error 13 - unknown',
    'local port already used',
    'error 15 - unknown',
    'too many open sockets',
    'local port not open',
    'malformed response'
}

integer HTTP_SOCKET_STATE_CLOSED = 0
integer HTTP_SOCKET_STATE_OPENING = 1
integer HTTP_SOCKET_STATE_OPEN = 2
integer HTTP_SOCKET_STATE_CLOSING = 3


define_type

structure http_header {
    char key[64]
    char value[256]
}

structure http_request {
    char method[7]
    char uri[256]
    http_header headers[5]
    char body[2048]
}

structure http_response {
    char version[8]
    integer code
    char message[64]
    http_header headers[10]
    char body[16384]
}

structure http_req_obj {
    long seq
    char host[512]
    http_request request
}

structure http_url {
    char protocol[16]
    char host[256]
    char uri[256]
}


define_variable

volatile dev http_sockets[HTTP_MAX_PARALLEL_REQUESTS]
volatile integer http_socket_state[HTTP_MAX_PARALLEL_REQUESTS]
volatile char http_socket_buff[HTTP_MAX_PARALLEL_REQUESTS][HTTP_MAX_RESPONSE_LENGTH]
volatile http_req_obj http_req_objs[HTTP_MAX_PARALLEL_REQUESTS]


//////////////////////////
//////////////////////////
//////////////////////////
DEFINE_FUNCTION http_response_received(LONG seq_number, char host[512], http_request request, http_response response)
{
    STACK_VAR INTEGER REC_CHAR_INDEX
    STACK_VAR INTEGER STREAM_CHAR_INDEX
    STACK_VAR CHAR REC_TIMER[10]
    STACK_VAR CHAR STREAM_TIMER[10]
    STACK_VAR CHAR LAYOUT_ID[1]
    
    IF (FIND_STRING(host,'10.162.4.205',1))
    {
	//interfaccia rele
	SEND_STRING 0, "'interfaccia rele RESPONSE'"
	SEND_STRING 0, "'interfaccia rele response body: ',response.body"
	SEND_STRING 0, "'interfaccia rele response code: ',response.code"
    }
}
//////////////////////////
//////////////////////////
//////////////////////////


/**
 * Sends a HTTP GET request
 */
define_function long http_get(char resource[]) {
    stack_var http_url url
    stack_var http_request request

    http_parse_url("resource", url)

    request.method = 'GET'
    request.body = ''

    return http_execute_request(url, request)
}

define_function long http_get_CRED(char resource[], char authstring[]) {
    stack_var http_url url
    stack_var http_request request
    stack_var http_header header
    
    http_parse_url("resource", url)

    header.key = 'Authorization'
    header.value = authstring //'Basic YWRtaW46YnJpZ2h0'
    request.method = 'GET'
    request.body = ''
    request.headers[1] = header

    return http_execute_request(url, request)
}

define_function long http_post_cred(char resource[], char body[], char authstring[]) {
    stack_var http_url url
    stack_var http_request request
    stack_var http_header header
    
    http_parse_url("resource", url)

    header.key = 'Authorization'
    header.value = authstring //'Basic YWRtaW46YnJpZ2h0'
    request.method = 'POST'
    request.body = body
    request.headers[1] = header

    return http_execute_request(url, request)
}

define_function long http_put_cred(char resource[], char body[],  char authstring[]) {
    stack_var http_url url
    stack_var http_request request
    stack_var http_header header

    http_parse_url("resource", url)
    
    header.key = 'Authorization'
    header.value = authstring //'Basic YWRtaW46YnJpZ2h0'
    request.method = 'PUT'
    request.body = body
    request.headers[1] = header

    return http_execute_request(url, request)
}

/**
 * Sends a HTTP HEAD request
 */
define_function long http_head(char resource[]) {
    stack_var http_url url
    stack_var http_request request

    http_parse_url("resource", url)

    request.method = 'HEAD'
    request.body = ''

    return http_execute_request(url, request)
}

/**
 * Sends a HTTP PUT request
 */
define_function long http_put(char resource[], char body[]) {
    stack_var http_url url
    stack_var http_request request

    http_parse_url("resource", url)

    request.method = 'PUT'
    request.body = body

    return http_execute_request(url, request)
}

/**
 * Sends a HTTP POST request
 */
define_function long http_post(char resource[], char body[]) {
    stack_var http_url url
    stack_var http_request request

    http_parse_url("resource", url)

    request.method = 'POST'
    request.body = body

    return http_execute_request(url, request)
}

/**
 * Sends a HTTP PATCH request
 */
define_function long http_patch(char resource[], char body[]) {
    stack_var http_url url
    stack_var http_request request

    http_parse_url("resource", url)

    request.method = 'PATCH'
    request.body = body

    return http_execute_request(url, request)
}

/**
 * Sends a HTTP DELETE request
 */
define_function long http_delete(char resource[]) {
    stack_var http_url url
    stack_var http_request request

    http_parse_url("resource", url)

    request.method = 'DELETE'

    return http_execute_request(url, request)
}

/**
 * Retrieves the values of a header from a http_header array.
 */
define_function char[256] http_get_header(http_header headers[],
        char key[]) {
    stack_var integer x

    for (x = 1; x <= length_array(headers); x++) {
        if (headers[x].key == key) {
            return headers[x].value
        }
    }
    
    return ''
}

/**
 * Builds a HTTP request ready for transmission.
 */
define_function char[HTTP_MAX_REQUEST_LENGTH] http_build_request(char host[],http_request request) {
    stack_var char ret[HTTP_MAX_REQUEST_LENGTH]
    stack_var http_header header
    stack_var integer x

    request.method = upper_string(request.method)
    if (request.method != 'GET' &&
            request.method != 'HEAD' &&
            request.method != 'POST' &&
            request.method != 'PUT' && 
            request.method != 'DELETE' &&
            request.method != 'TRACE' &&
            request.method != 'OPTIONS' &&
            request.method != 'CONNECT' &&
            request.method != 'PATCH') {
        amx_log(AMX_ERROR, "'Invalid HTTP method in request (', request.method, ')'")
        return ''
    }

    ret = "request.method, ' ', request.uri, ' HTTP/1.1', $0d, $0a"
    
    ret = "ret, 'Host: ', host, $0d, $0a"
    
    
    if (request.body != '') {
	ret = "ret, 'Connection: close', $0d, $0a"
	
        ret = "ret, 'Content-Length: ', itoa(length_string(request.body)), $0d, $0a"
        if (request.body[1] == '{' &&
                request.body[length_array(request.body)] == '}') {
            ret = "ret, 'Content-Type: application/json', $0d, $0a" 
        }
	else {
	    //non � json, quindi facciamo un POST del FORM
	    ret = "ret, 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8', $0d, $0a" //MODIFICATO LUCAP 20160905 DA APPLICATION/JSON PER SEMPLIFICARE L'INVIO DEI PARAMETRI SENZA FARE L'ENCODING JSON
	}
    }
    
//POST http://192.168.230.115/bios/write.php HTTP/1.1
//Host: 192.168.230.115
//Connection: keep-alive
//Content-Length: 29
//Accept: text/html, */*; q=0.01
//Origin: http://192.168.230.115
//X-Requested-With: XMLHttpRequest
//User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36
//Content-Type: application/x-www-form-urlencoded; charset=UTF-8
//Referer: http://192.168.230.115/bios/change.php
//Accept-Encoding: gzip, deflate
//Accept-Language: it-IT,it;q=0.8,en-US;q=0.6,en;q=0.4

//lang1=ITA&lang2=ENG&lang3=FRE

    //SEND_STRING 0, "'HEADERS LENGTH: ', length_array(request.headers)"
    for (x = 1; x <= 5; x++) {
        header = request.headers[x]
        if (header.key != '') {
            ret = "ret, header.key, ': ', header.value, $0d, $0a"
        }
    }
    ret = "ret, $0d, $0a"
    
    if (request.body != '') {
        ret = "ret, request.body, $0d, $0a"
        ret = "ret, $0d, $0a"
    }

    return ret
}

/**
 * Creates a sequence id to assist in identifying http responses.
 */
define_function long http_next_seq() {
    local_var long next_seq
    stack_var long seq

    if (next_seq == 0) {
        next_seq = 1
    }

    seq = next_seq
    next_seq++  // not need to mod, we'll just wrap around > 0xffffffff

    return seq
}

/**
 * Checks if the specified HTTP request resource slot is currently in use.
 */
define_function char http_resource_in_use(integer resource_id) {
    return http_req_objs[resource_id].seq > 0 ||
            http_socket_state[resource_id] != HTTP_SOCKET_STATE_CLOSED
}

/**
 * Allocates a request to one of our HTTP request resource slots for execution.
 *
 * note: req_obj argument will be written to
 */
define_function integer http_build_req_obj(http_req_obj req_obj, char host[],
        http_request request) {
    stack_var integer resource_id

    for (resource_id = 1; resource_id <= HTTP_MAX_PARALLEL_REQUESTS; resource_id++) {
        if (http_resource_in_use(resource_id) == false) {
            req_obj.seq = http_next_seq()
            req_obj.host = host
            req_obj.request = request

            http_req_objs[resource_id] = req_obj

            return resource_id
        }
    }

    return 0
}

/**
 * Returns a resource slot back to our pool.
 */
define_function http_release_resources(integer resource_id) {
    stack_var http_req_obj null

    if (timeline_active(HTTP_TIMEOUT_TL[resource_id])) {
        timeline_kill(HTTP_TIMEOUT_TL[resource_id])
    }

    if (http_socket_state[resource_id] == HTTP_SOCKET_STATE_OPEN) {
        ip_client_close(http_sockets[resource_id].port)
        http_socket_state[resource_id] = HTTP_SOCKET_STATE_CLOSING
    }

    clear_buffer http_socket_buff[resource_id]

    http_req_objs[resource_id] = null
}

/**
 * Sends a HTTP request.
 *
 * As we don't have the ability to block whist awaiting a response this will
 * return a sequence id. When a response is received by the http lib this
 * sequence id is passed to the callback function along with the response data.
 * It is the responsibility of the implementer to then handle these accordingly.
 */
define_function long http_execute_request(http_url url, http_request request) {
    stack_var integer resource_id
    stack_var http_req_obj req_obj
    stack_var char server_address[256]
    stack_var integer server_port
    stack_var integer pos

    if (url.host == '') {
        amx_log(AMX_ERROR, 'Invalid host')
        return 0
    }

    if (request.uri == '') {
        request.uri = url.uri
    }

    if (request.uri[1] != '/' &&
            request.uri != '*' &&
            left_string(request.uri, 7) != 'http://') {
        amx_log(AMX_ERROR, "'Invalid request URI (', request.uri, ')'")
        return 0
    }

    resource_id = http_build_req_obj(req_obj, url.host, request)
    if (resource_id == 0) {
        amx_log(AMX_ERROR, 'HTTP lib resources at capacity. Request dropped.')
        return 0
    }
    
    pos = find_string(url.host, ':', 1)
    if (pos) {
        server_address = left_string(url.host, pos - 1)
        server_port = atoi(right_string(url.host, length_string(url.host) - pos))
    } else {
        server_address = url.host
        server_port = 80
    }
    
    //server_address = url.host
    //server_port = 80
	
    ip_client_open(http_sockets[resource_id].port, server_address, server_port, IP_TCP)
    http_socket_state[resource_id] = HTTP_SOCKET_STATE_OPENING

    timeline_create(HTTP_TIMEOUT_TL[resource_id],
                HTTP_TIMEOUT_INTERVAL,
                1,
                TIMELINE_ABSOLUTE,
                TIMELINE_ONCE)

    // note: request transmitted from socket online event

    return req_obj.seq
}

/**
 * Remove one line of data from a buffer and return.
 *
 * Warning: this performs a desctructive action to the passed character buffer.
 */
define_function char[HTTP_MAX_LINE_LENGTH] http_readln(char buff[]) {
    stack_var char line[HTTP_MAX_LINE_LENGTH]

    line = remove_string(buff, "$0d, $0a", 1)
    line = left_string(line, length_string(line) - 2)

    return line
}

/**
 * Parse out HTTP response headers from a raw response in to a http_header 
 * array.
 *
 * Warning: this performs a desctructive action to the passed character buffer.
 */
define_function http_parse_headers(char buff[], http_header headers[]) {
    stack_var char line[HTTP_MAX_LINE_LENGTH]
    stack_var integer pos
    stack_var integer x

    for (x = 1; x <= max_length_array(headers); x++) {
        line = http_readln(buff)
        if (line == '') {
            break;
        }
        if (left_string(line, 5) != 'HTTP/') {
            pos = find_string(line, ': ', 1)
            headers[x].key = left_string(line, pos - 1)
            headers[x].value = right_string(line, length_string(line) - pos - 1)
        }
    }
    set_length_array(headers, x)
}

/**
 * Parse a raw HTTP response into a response structure.
 *
 * Warning: this performs a desctructive action on the passed character buffer
 * and also writes directly to the passed http_response variable
 */
define_function char http_parse_response(char buff[], http_response response) {
    stack_var char line[HTTP_MAX_LINE_LENGTH]

    line = http_readln(buff)
    if (left_string(line, 5) != 'HTTP/') {
        return false
    }
    response.version = left_string(remove_string(line, ' ', 1), 8)
    response.code = atoi(remove_string(line, ' ', 1))
    response.message = line

    http_parse_headers(buff, response.headers)

    response.body = buff

    return true
}

/**
 * Parses a URL string into it's component values.
 *
 * Warning: this performs a desctructive action on the passed character buffer
 * and also writes directly to the passed http_url variable
 */
define_function char http_parse_url(char buff[], http_url url) {
    stack_var integer pos
    stack_var char tmp[256]

    pos = find_string(buff, '://', 1)
    if (pos) {
        url.protocol = remove_string(buff, '://', 1)
        url.protocol = left_string(url.protocol, length_string(url.protocol) - 3)
        url.protocol = lower_string(url.protocol)
    } else {
        url.protocol = 'http'
    }

    pos = find_string(buff, '/', 1)
    if (pos) {
        url.host = left_string(buff, pos - 1)
        url.uri = right_string(buff, length_string(buff) - (pos - 1))
    } else {
        url.host = buff
        url.uri = '/'
    }

    //SEND_STRING 0, "'HOST: ', URL.HOST"
    //SEND_STRING 0, "'PROTOCOL: ', URL.PROTOCOL"
    //SEND_STRING 0, "'URI: ', URL.URI"
    return true
}


define_start

{
    stack_var integer x

    for (x = 1; x <= HTTP_MAX_PARALLEL_REQUESTS; x++) {
        http_sockets[x].number = 0
        http_sockets[x].port = HTTP_BASE_PORT + x - 1
        http_sockets[x].system = system_number
        create_buffer http_sockets[x], http_socket_buff[x]
    }
    set_length_array(http_sockets, HTTP_MAX_PARALLEL_REQUESTS)

    rebuild_event()
}


define_event

data_event[http_sockets] {

    online: {
        stack_var integer resource_id
        stack_var http_req_obj req_obj

        resource_id = get_last(http_sockets)
        req_obj = http_req_objs[resource_id]

        http_socket_state[resource_id] = HTTP_SOCKET_STATE_OPEN

        if (http_resource_in_use(resource_id)) {
	    //send_string 0,"http_build_request(req_obj.host, req_obj.request)"
            send_string data.device, http_build_request(req_obj.host, req_obj.request)
        } else {
            http_release_resources(resource_id)
        }
    }

    offline: {
        stack_var integer resource_id
        stack_var http_req_obj req_obj
        stack_var http_response response
        stack_var char valid_response

        resource_id = get_last(http_sockets)
        req_obj = http_req_objs[resource_id]

        http_socket_state[resource_id] = HTTP_SOCKET_STATE_CLOSED

        if (http_resource_in_use(resource_id)) {

            valid_response = http_parse_response(http_socket_buff[resource_id], response)

            http_release_resources(resource_id)

            if (valid_response) {
                #if_defined HTTP_RESPONSE_CALLBACK
                http_response_received(req_obj.seq, req_obj.host, req_obj.request, response)
                #end_if
            } else {
                amx_log(AMX_ERROR, "'HTTP parse error (', HTTP_ERR_TEXT[HTTP_ERR_MALFORMED_RESPONSE], ')'")

                #if_defined HTTP_ERROR_CALLBACK
                http_error(req_obj.seq, req_obj.host, req_obj.request, HTTP_ERR_MALFORMED_RESPONSE)
                #end_if
            }
        }
    }

    onerror: {
        stack_var integer resource_id
        stack_var http_req_obj req_obj

        resource_id = get_last(http_sockets)
        req_obj = http_req_objs[resource_id]

        if (data.number != HTTP_ERR_LOCAL_PORT_ALREADY_USED) {
            http_socket_state[resource_id] = HTTP_SOCKET_STATE_CLOSED
        }

        if (http_resource_in_use(resource_id)) {
            amx_log(AMX_ERROR, "'HTTP socket error (', HTTP_ERR_TEXT[data.number], ')'")

            http_release_resources(resource_id)

            #if_defined HTTP_ERROR_CALLBACK
            http_error(req_obj.seq, req_obj.host, req_obj.request, data.number)
            #end_if
        }
    }

    string: {}

}

timeline_event[HTTP_TIMEOUT_TL_1]
timeline_event[HTTP_TIMEOUT_TL_2]
timeline_event[HTTP_TIMEOUT_TL_3]
timeline_event[HTTP_TIMEOUT_TL_4]
timeline_event[HTTP_TIMEOUT_TL_5]
timeline_event[HTTP_TIMEOUT_TL_6]
timeline_event[HTTP_TIMEOUT_TL_7]
timeline_event[HTTP_TIMEOUT_TL_8]
timeline_event[HTTP_TIMEOUT_TL_9]
timeline_event[HTTP_TIMEOUT_TL_10]
timeline_event[HTTP_TIMEOUT_TL_11]
timeline_event[HTTP_TIMEOUT_TL_12]
timeline_event[HTTP_TIMEOUT_TL_13]
timeline_event[HTTP_TIMEOUT_TL_14]
timeline_event[HTTP_TIMEOUT_TL_15] {
    stack_var integer resource_id
    stack_var http_req_obj req_obj

    for (resource_id = 1; resource_id <= length_array(HTTP_TIMEOUT_TL); resource_id++) {
        if (timeline.id == HTTP_TIMEOUT_TL[resource_id]) {
            break
        }
    }
    req_obj = http_req_objs[resource_id]

    if (http_resource_in_use(resource_id)) {
        amx_log(AMX_ERROR, 'HTTP response timeout')

        http_release_resources(resource_id)

        #if_defined HTTP_ERROR_CALLBACK
        http_error(req_obj.seq, req_obj.host, req_obj.request, HTTP_ERR_RESPONSE_TIME_OUT)
        #end_if
    }
}
