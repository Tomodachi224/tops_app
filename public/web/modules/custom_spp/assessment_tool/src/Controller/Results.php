<?php
namespace Drupal\assessment_tool\Controller;

use Drupal\Core\Controller\ControllerBase;
use Drupal\Core\Link;
use Drupal\Core\Url;
use Drupal\assessment_tool\Controller\Regions;

class Results extends ControllerBase {
	public function page($region = NULL) {
    $region = \Drupal\Component\Utility\Xss::filter($region);

    $result = new Regions();
    $region_id = $result->setRegion($region);
    $regions = $result->getRegion();

    $region_list = '';
    for ($i=1; $i < 5; $i++) {
      if ($region_id == $i) { $region_list .= '<li class="region-name active">' . $regions[$i]['name'] . '</li>'; }
      else { $region_list .= '<li class="region-name"><a href="/engage/assessment-tool/' . $regions[$i]['url'] . '" title="' . $regions[$i]['name'] . '">' . $regions[$i]['name'] . '</a></li>'; }
    }

    $session = \Drupal::request()->getSession();
    $region = $session->get('region');
    $health = $session->get('health');
    $children = $session->get('children');
    $worker = $session->get('worker');
    $older = $session->get('older');

    $level = [];
    $level[1] = 192;
    $level[2] = 193;
    $level[3] = 194;
    $level[4] = 195;
    $level[5] = 196;

    $params = [];
    $params['health'] = ['input' => $health, 'component' => 184, 'level' => $level[$health + 1]];
    $params['children'] = ['input' => $children, 'component' => 185, 'level' => $level[$children + 1]];
    $params['worker'] = ['input' => $worker, 'component' => 186, 'level' => $level[$worker + 1]];
    $params['older'] = ['input' => $older, 'component' => 187, 'level' => $level[$older + 1]];

    $practices = [];
    foreach ($params as $key => $param) {
      $query = \Drupal::entityQuery('node');
      $query->condition('type', 'good_practice');
      $query->condition('field_country.entity.field_region', $region);
      $query->condition('field_component', $param['component']);
      $query->condition('field_level', $param['level']);
      $query->sort('nid', 'ASC');
      $nids = $query->execute();
      $nid = array_rand($nids);
      $node = \Drupal\node\Entity\Node::load($nid);
      $practices[$key] = $node->body->value;
    }

    $build['#attached']['library'][] = 'assessment_tool/assessment_tabs';
    $build['#title'] = 'Good Practices from ' . $regions[$region]['name'] . ' and comparative examples from other regions';

    $build['page'] = [
      '#type' => 'item',
      '#children' => $this->buildPage($region_list, $practices),
      '#id' => 'result-content',
    ];

	  return $build;
	}

  protected function buildPage($region_list, $practices) {
    return '
      <div id="tabs-result" class="idTabs">
          <ul class="tabs-title clearfix">
              <li><a href="#tab-health" class="icon-health selected" title="Health">Health</a></li>
              <li><a href="#tab-children" class="icon-children" title="Children">Children</a></li>
              <li><a href="#tab-working" class="icon-working" title="Working-Age">Working-Age</a></li>
              <li><a href="#tab-older" class="icon-older" title="Older Persons">Older Persons</a></li>
          </ul>
          
          <ul class="list-region">' . $region_list . '</ul>

          <div class="tabs-container">
            <div id="tab-health" class="tab-content">' . $practices['health'] . '</div>
            <div id="tab-children" class="tab-content">' . $practices['children'] . '</div>
            <div id="tab-working" class="tab-content">' . $practices['worker'] . '</div>
            <div id="tab-older" class="tab-content">' . $practices['older'] . '</div>
          </div>
      </div><!-- #tabs-result -->

      <ul class="result-bottom clearfix">
          <li><a class="btn btn-primary" href="/">Home</a></li><!--  onClick="javascript:window.opener.location.href=\'/\';window.close();" //-->
          <li><a class="btn btn-primary" href="/engage">Start Again</a></li><!--  onClick="javascript:window.opener.location.href=\'/engage\';window.close();" //-->
          <li><a class="btn btn-primary" href="/good-practices-map" target="_blank">Navigate All Good Practices</a></li>
          <li><a class="btn btn-primary" href="/feedback">Feedback</a></li><!--  onClick="javascript:window.opener.location.href=\'/feedback\';window.close();" //-->
          <li><a class="btn btn-primary" href="" onClick="javascript:window.print();">Print</a></li>
      </ul>
    ';
  }

}