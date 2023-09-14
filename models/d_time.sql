{{config(materialized='table', tags=['dim'])}}

with
    cleaned_d_time as (
        select
            time_id,
            {% if target.type == "postgres" %} action_timestamp::timestamp
            {% elif target.type == "bigquery" %} timestamp(action_timestamp)
            {% else %} action_timestamp
            {% endif %} as action_timestamp_
        from {{source('postgres', 'd_time')}}
    )

select
    time_id,
    action_timestamp_,
    {% for part in ["year", "month", "week", "day", "dayofweek"] %}
        EXTRACT({{ part | upper }} FROM action_timestamp_) as action_{{ part }},
    {% endfor %} 

from cleaned_d_time
{{limit_lines_dev()}}
