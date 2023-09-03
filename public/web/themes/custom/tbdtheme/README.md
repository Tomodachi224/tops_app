# TBD Bootstrap 5 theme


## INTRODUCTION

This project holds both vanilla HTML theme and Drupal theme based on the bootstrap 5. For development of the theme we can edit in each part separately.

## REQUIREMENTS

### Installation: composer
INSTALLATION

Head to `Appearance` and install tbdtheme theme.

## CONFIGURATION

Head to `Appearance` and clicking tbdtheme `settings`.

## Development and patching

- Install development dependencies by running `yarn install`
- The run `yarn serve`
- To compile run `yarn run build`
- optional: create symlink from tbdtheme repo folder to a local Drupal installation to simplify development `ln -s /path/to/bootstrap5 /path/to/local-drupal-site/web/themes/contrib`

## FAQ

### FAQ - Menu subnesting

Nesting is considered bad practice in Bootstrap 5. It is bad for UX, mobile
usage and accessibility.

Hence, there are no examples in the [current documentation](https://getbootstrap.com/docs/5.0/components/dropdowns/#menu-items).

Read more:

* https://github.com/twbs/bootstrap/issues/27659
* https://github.com/twbs/bootstrap/issues/16387#issuecomment-97153831

Theme developers need to implement their own solution if they are catering
for multi level menus.

To get started copy `templates/navigation/menu--main.html.twig` to your
subtheme and modify as follows:

```
{% import _self as menus %}

{#
We call a macro which calls itself to render the full tree.
@see http://twig.sensiolabs.org/doc/tags/macro.html
#}
{{ menus.build_menu(items, attributes, 0) }}

{% macro build_menu(items, attributes, menu_level) %}
  {% import _self as menus %}
  {% if items %}
    {% if menu_level == 0 %}
    <ul{{ attributes.addClass('navbar-nav mr-auto') }}>
    {% else %}
    <ul class="dropdown-menu">
    {% endif %}
    {% for item in items %}
      {{ menus.add_link(item, attributes, menu_level) }}
    {% endfor %}
    </ul>
  {% endif %}
{% endmacro %}

{% macro add_link(item, attributes, menu_level) %}
  {% import _self as menus %}
  {%
    set list_item_classes = [
      'nav-item',
      item.is_expanded ? 'dropdown',
      item.is_expanded and (menu_level > 0) ? 'dropdown-submenu',
    ]
  %}
  {%
    set link_class = [
      'nav-item',
      'nav-link',
      item.in_active_trail ? 'active',
      menu_level == 0 and (item.is_expanded or item.is_collapsed) ? 'dropdown-toggle',
    ]
  %}
  {%
    set toggle_class = [
    ]
  %}
  <li{{ item.attributes.addClass(list_item_classes) }}>
    {% if menu_level == 0 %}
      {{ link(item.title, item.url, { 'class': link_class, 'data-toggle' : 'dropdown', 'title': ('Expand menu' | t) ~ ' ' ~ item.title }) }}
    {% else %}
      {{ link(item.title, item.url, { 'class': link_class }) }}
    {% endif %}
    {% if item.below %}
      {{ menus.build_menu(item.below, attributes, menu_level + 1) }}
    {% endif %}
  </li>
{% endmacro %}
```
