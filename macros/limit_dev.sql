{% macro limit_lines_dev(environment = 'dev') %}
    {% if environment == 'dev' %}
        limit 5
    {% endif %}
{% endmacro %}