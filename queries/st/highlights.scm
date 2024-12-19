; Comments
(inline_comment) @comment
(block_comment) @comment

; Identifiers

"FUNCTION_BLOCK" @keyword
"END_FUNCTION_BLOCK" @keyword
"FUNCTION" @keyword
"END_FUNCTION" @keyword
"PROGRAM" @keyword
"END_PROGRAM" @keyword
"METHOD" @keyword
"END_METHOD" @keyword
(abstract) @keyword
"PUBLIC" @keyword
"PROTECTED" @keyword
"INTERNAL" @keyword
"PRIVATE" @keyword
"FINAL" @keyword
"EXTENDS" @keyword
"IMPLEMENTS" @keyword
"CONSTANT" @keyword
"VAR" @keyword
"VAR_INPUT" @keyword
"VAR_OUTPUT" @keyword
"VAR_IN_OUT" @keyword
"VAR_IN_OUT" @keyword
"VAR_TEMP" @keyword
"VAR_STAT" @keyword
"VAR_INST" @keyword
"VAR_EXTERNAL" @keyword
"END_VAR" @keyword
"AT" @keyword
"ARRAY" @keyword
"OF" @keyword
"RETURN" @keyword

;
"(" @operator
")" @operator
"[" @operator
"]" @operator
 
;(type_identifier) @type
(integer) @number
(floating_point) @number
(boolean) @number
(string) @string
(wstring) @string
(variable type: (data_type (basic_data_type)) @type)
(data_type (basic_data_type) @type)
(string_type) @type
(variable type: (data_type (identifier)) @type)
(function_block name: (identifier) @function)
(method name: (identifier) @function)
(call (identifier) @property)
(variable name: (identifier) @property)
(implements (identifier) @function)
(extends (identifier) @function)
(array_type lower_bound: (identifier) @property)
(array_type upper_bound: (identifier) @property)
(address (address_specifier) @operator)
(address (address_type) @type)
(address (address_area) @number)

;operators
":=" @operator
";" @operator
":" @operator
"," @operator
".." @operator
"/" @operator
"*" @operator
"-" @operator
"+" @operator
"<" @operator
">" @operator
"<>" @operator
; "%" @operator
