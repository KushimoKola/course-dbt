{%- macro snowflake__idempotent_key(column_list, column_alias = none) -%}
    base64_encode(md5(concat(
    {%- for col in column_list -%}
        {{ column_alias + "." if column_alias is not none }}{{ col }}{{ ", '::' ,"  if not loop.last}}
    {%- endfor -%}
    )))
{%- endmacro -%}
