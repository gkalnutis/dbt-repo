{% test larger_than(model, column_name, threshold) %}

with validation as (
    select
        {{ column_name }} as field
    from {{ model }}
)

select
    field
from validation
where field <= {{threshold}}

{% endtest %}
