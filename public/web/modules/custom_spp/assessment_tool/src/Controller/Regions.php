<?php
namespace Drupal\assessment_tool\Controller;

use Drupal\Core\Controller\ControllerBase;
use Drupal\Core\Url;
use Symfony\Component\HttpFoundation\RedirectResponse;

class Regions extends ControllerBase {
  public function setRedirect($region = NULL) {
    $region = \Drupal\Component\Utility\Xss::filter($region);

    $region_id = $this->setRegion($region);
    return new RedirectResponse(Url::fromRoute('assessment_tool.engage')->toString());
  }

  public function setRegion($region = NULL) {
    $region_id = 3;
    if ($region == 'africa') { $region_id = 1; }
    elseif ($region == 'latin-america-caribbean') { $region_id = 2; }
    elseif ($region == 'asia-pacific') { $region_id = 3; }
    elseif ($region == 'middle-east-north-africa') { $region_id = 4; }

    $session = \Drupal::request()->getSession()->set('region', $region_id);
    return $region_id;
  }

  public function getRegion() {
    $regions = [];
    $regions[1] = ['url' => 'africa', 'name' => 'Africa'];
    $regions[2] = ['url' => 'latin-america-caribbean', 'name' => 'Latin America and the Caribbean'];
    $regions[3] = ['url' => 'asia-pacific', 'name' => 'Asia-Pacific'];
    $regions[4] = ['url' => 'middle-east-north-africa', 'name' => 'Middle East and the North Africa'];

    return $regions;
  }

}