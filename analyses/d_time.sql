with
    cleaned_d_time as (
        select
            time_id,
            {% if target.type == "postgres" %} action_timestamp::timestamp
            {% elif target.type == "bigquery" %} timestamp(action_timestamp)
            {% else %} action_timestamp
            {% endif %} as action_timestamp_
        from dbt-demo-397619.transactional.d_time
    )

select
    time_id,
    action_timestamp_,
    {% for part in ["year", "month", "week", "day", "dayofweek"] %}
        EXTRACT({{ part | upper }} FROM action_timestamp_) as action_{{ part }},
    {% endfor %} 

from cleaned_d_time
