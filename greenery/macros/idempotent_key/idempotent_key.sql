{%- macro idempotent_key(column_list, column_alias = none) -%}
    {{ return(adapter.dispatch('idempotent_key')(column_list, column_alias)) }}
{%- endmacro -%}
