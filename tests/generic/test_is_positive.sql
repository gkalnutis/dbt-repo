{% test is_positive(model, column_name) %}

with validation as (
    select
        {{ column_name }} as positive_field
    from {{ model }}
)

select
    positive_field
from validation
where positive_field < 0

{% endtest %}
