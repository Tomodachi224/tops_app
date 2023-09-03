<?php
namespace Drupal\assessment_tool\Form;

use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Drupal\assessment_tool\Controller\Regions;

class Engage extends FormBase {
  public function getFormId() {
    return 'assessment_tool_engage_form';
  }

	public function buildForm(array $form, FormStateInterface $form_state) {
    $form['#attached']['library'][] = 'assessment_tool/assessment_tabs';
    $form['#attached']['library'][] = 'assessment_tool/assessment_tool';

    $form['finish'] = [
      '#type' => 'value',
      '#value' => TRUE,
    ];

    if ($form_state->hasValue('finish')) {
      $post = \Drupal::request()->request;
      $session = \Drupal::request()->getSession();
      $session->set('health', $post->get('opt-health') ?: 1);
      $session->set('children', $post->get('opt-children') ?: 1);
      $session->set('worker', $post->get('opt-working') ?: 1);
      $session->set('older', $post->get('opt-older') ?: 1);

      $form['assessment'] = [
        '#type' => 'item',
        '#children' => $this->buildResult(),
        '#id' => 'tool-wrapper',
      ];
    }
    else {
      $form['assessment'] = [
        '#type' => 'item',
        '#children' => $this->buildPage(),
        '#id' => 'tool-wrapper',
      ];
    }

	  return $form;
	}

  public function validateForm(array &$form, FormStateInterface $form_state) {
  }

  public function submitForm(array &$form, FormStateInterface $form_state) {
    $form_state->setRebuild();
  }

  protected function buildPage() {
    return '
      <div id="diagram"></div>
      <div id="assessment" class="idTabs">
        <ul class="tabs-title clearfix">
          <li><a href="#tab-health" class="icon-health selected" title="Health">Health</a></li>
          <li class="divider"></li>
          <li><a href="#tab-children" class="icon-children" title="Children">Children</a></li>
          <li class="divider"></li>
          <li><a href="#tab-working" class="icon-working" title="Working-Age">Working-Age</a></li>
          <li class="divider"></li>
          <li><a href="#tab-older" class="icon-older" title="Older Persons">Older Persons</a></li>
          <li class="divider"></li>
          <li><button type="submit" class="icon-finish">Finish</button></li>
        </ul>
        
        <div class="tabs-container">
          <div id="tab-health" class="tab-content clearfix">
            <p class="tab-description">Select the scenario that best describes access to health care in your country:</p>
            <ul class="list-icheck list-radio">
              <li><input type="radio" id="opt-health-4" name="opt-health" value="4"><label for="opt-health-4">All residents have access to essential publicly funded health care services.</label></li>
              <li><input type="radio" id="opt-health-3" name="opt-health" value="3"><label for="opt-health-3">Publicly funded health care is currently implemented, but gaps in coverage remain.</label></li>
              <li><input type="radio" id="opt-health-2" name="opt-health" value="2"><label for="opt-health-2">Constitutional provisions or legislation entitles residents to health coverage, but publicly funded schemes are not currently implemented.</label></li>
              <li><input type="radio" id="opt-health-1" name="opt-health" value="1" checked><label for="opt-health-1">Residents only have access to private health care and there is no legal framework for the provision of public health care.</label></li>
            </ul>

            <div id="control-health-4" class="tab-control-question">
              <p><strong>Are national healthcare schemes designed to meet the needs of the following groups?</strong></p>
              <ul class="list-icheck list-checkbox">
                <li><input type="checkbox" id="cq-health-45" name="cq-health-45" value="5"><label for="cq-health-45"><span class="tooltips" title="Article 43 of the International Convention on the Protection of the Rights of All Migrant Workers and Members of Their Families (1990) states that “migrant workers shall enjoy equality of treatment with nationals of the State of employment in … access to social and health services …”">Migrant Workers</span></label></li>
                <li><input type="checkbox" id="cq-health-44" name="cq-health-44" value="4"><label for="cq-health-44"><span class="tooltips" title="Article 25 of the Convention on the Rights of Persons with Disabilities (2006), requires that States, “provide persons with disabilities with the same range, quality and standard of free or affordable health care and programmes as provided to other persons, including in the area of sexual and reproductive health and population-based public health programmes …”">Persons with disabilities</span></label></li>
                <li><input type="checkbox" id="cq-health-43" name="cq-health-43" value="3"><label for="cq-health-43"><span class="tooltips" title="Article 12 of the Convention on the Elimination of All Forms of Discrimination Against Women (1979), requires States to “take all appropriate measures to eliminate discrimination against women in the field of health care in order to ensure, on a basis of equality of men and women, access to health care services, including those related to family planning.”">Girls and Women</span></label></li>
                <li><input type="checkbox" id="cq-health-42" name="cq-health-42" value="2"><label for="cq-health-42"><span class="tooltips" title="Section 38 of the Political Declaration on HIV/AIDS adopted by the UN General Assembly on 10 June 2010 reaffirms “the commitment [of Member States] to fulfil obligations to promote … human rights and fundamental freedoms for all in accordance with the Charter, the Universal Declaration of Human Rights … in particular, of people living with and affected by HIV, including their families, and the need to take into account the particularities of each country in sustaining national HIV and AIDS responses, reaching all people living with HIV, delivering HIV prevention, treatment, care and support and strengthening health systems, in particular primary health care.”">Persons living with and affected by HIV/AIDS</span></label></li>
                <li><input type="checkbox" id="cq-health-41" name="cq-health-41" value="1"><label for="cq-health-41"><span class="tooltips" title="Article 14 of the Madrid International Plan of Action on Ageing (2002) outlines state commitments in “providing older persons with universal and equal access to health care and services, including physical and mental health services, and … [recognition] that the growing needs of an ageing population require additional policies, in particular care and treatment, the promotion of healthy lifestyles and supportive environments.”">Older Persons</span></label></li>
              </ul>
            </div>

            <div id="control-health-2" class="tab-control-question">
              <p><strong>Do constitutional and/or legal provisions grant equal rights to health care for the following groups?</strong></p>
              <ul class="list-icheck list-checkbox">
                <li><input type="checkbox" id="cq-health-25" name="cq-health-25" value="5"><label for="cq-health-25"><span class="tooltips" title="Article 43 of the International Convention on the Protection of the Rights of All Migrant Workers and Members of Their Families (1990) states that “migrant workers shall enjoy equality of treatment with nationals of the State of employment in … access to social and health services …”">Migrant Workers</span></label></li>
                <li><input type="checkbox" id="cq-health-24" name="cq-health-24" value="4"><label for="cq-health-24"><span class="tooltips" title="Article 25 of the Convention on the Rights of Persons with Disabilities (2006), requires that States, “provide persons with disabilities with the same range, quality and standard of free or affordable health care and programmes as provided to other persons, including in the area of sexual and reproductive health and population-based public health programmes …”">Persons with disabilities</span></label></li>
                <li><input type="checkbox" id="cq-health-23" name="cq-health-23" value="3"><label for="cq-health-23"><span class="tooltips" title="Article 12 of the Convention on the Elimination of All Forms of Discrimination Against Women (1979), requires States to “take all appropriate measures to eliminate discrimination against women in the field of health care in order to ensure, on a basis of equality of men and women, access to health care services, including those related to family planning.”">Girls and Women</span></label></li>
                <li><input type="checkbox" id="cq-health-22" name="cq-health-22" value="2"><label for="cq-health-22"><span class="tooltips" title="Section 38 of the Political Declaration on HIV/AIDS adopted by the UN General Assembly on 10 June 2010 reaffirms “the commitment [of Member States] to fulfil obligations to promote … human rights and fundamental freedoms for all in accordance with the Charter, the Universal Declaration of Human Rights … in particular, of people living with and affected by HIV, including their families, and the need to take into account the particularities of each country in sustaining national HIV and AIDS responses, reaching all people living with HIV, delivering HIV prevention, treatment, care and support and strengthening health systems, in particular primary health care.”">Persons living with and affected by HIV/AIDS</span></label></li>
                <li><input type="checkbox" id="cq-health-21" name="cq-health-21" value="1"><label for="cq-health-21"><span class="tooltips" title="Article 14 of the Madrid International Plan of Action on Ageing (2002) outlines state commitments in “providing older persons with universal and equal access to health care and services, including physical and mental health services, and … [recognition] that the growing needs of an ageing population require additional policies, in particular care and treatment, the promotion of healthy lifestyles and supportive environments.”">Older Persons</span></label></li>
              </ul>
            </div>
            
            <div class="tab-navigation" style="display:block; clear:both; text-align:center;">
              <a href="#tab-children" class="next"><img src="/modules/custom_spp/assessment_tool/images/icon-next.png"></a>
            </div>
          </div>
            
          <div id="tab-children" class="tab-content clearfix">
            <p class="tab-description">Select the scenario that best describes access to social security for children in your country:</p>
            <ul class="list-icheck list-radio">
              <li><input type="radio" id="opt-children-4" name="opt-children" value="4"><label for="opt-children-4">All children have access to a nationally defined minimum level of publicly funded income security.</label></li>
              <li><input type="radio" id="opt-children-3" name="opt-children" value="3"><label for="opt-children-3">Publicly funded income security is currently available, but does not reach all children.</label></li>
              <li><input type="radio" id="opt-children-2" name="opt-children" value="2"><label for="opt-children-2">Constitutional provisions or legislation entitles children to income security, but publicly funded schemes are not currently implemented.</label></li>
              <li><input type="radio" id="opt-children-1" name="opt-children" value="1" checked><label for="opt-children-1">Children only have access to private social security and there is no legal framework for the provision of public income security.</label></li>
            </ul>

            <div id="control-children-4" class="tab-control-question">
              <p><strong>Are social security schemes inclusive of children in the following groups?</strong></p>
              <ul class="list-icheck list-checkbox">
                <li><input type="checkbox" id="cq-children-43" name="cq-children-43" value="3"><label for="cq-children-43"><span class="tooltips" title="Article 45 of the International Convention on the Protection of the Rights of All Migrant Workers and Members of Their Families (1990), stipulates that “States of employment shall pursue a policy, where appropriate in collaboration with the States of origin, aimed at facilitating the integration of children of migrant workers in the local school system, particularly in respect of teaching them the local language.”">Migrant children</span></label></li>
                <li><input type="checkbox" id="cq-children-42" name="cq-children-42" value="2"><label for="cq-children-42"><span class="tooltips" title="Article 23 of the Convention on the Rights of the Child (1990), stipulates that “recognizing the special needs of a disabled child, assistance … shall be provided free of charge … and shall be designed to ensure that the disabled child has effective access to and receives education, training [and] health care services …”">Children with disabilities</span></label></li>
                <li><input type="checkbox" id="cq-children-41" name="cq-children-41" value="1"><label for="cq-children-41"><span class="tooltips" title="Article 28 of the Convention on the Rights of the Child (1990), requires States to “recognize the right of the child to education, and with a view to achieving this right progressively and on the basis of equal opportunity, they shall, in particular, make primary education compulsory and available free to all.’">Girls</span></label></li>
              </ul>
            </div>

            <div id="control-children-2" class="tab-control-question">
              <p><strong>Do constitutional and/or legal provisions grant the right to basic social security for the following groups?</strong></p>
              <ul class="list-icheck list-checkbox">
                <li><input type="checkbox" id="cq-children-23" name="cq-children-23" value="3"><label for="cq-children-23"><span class="tooltips" title="Article 45 of the International Convention on the Protection of the Rights of All Migrant Workers and Members of Their Families (1990), stipulates that “States of employment shall pursue a policy, where appropriate in collaboration with the States of origin, aimed at facilitating the integration of children of migrant workers in the local school system, particularly in respect of teaching them the local language.”">Migrant children</span></label></li>
                <li><input type="checkbox" id="cq-children-22" name="cq-children-22" value="2"><label for="cq-children-22"><span class="tooltips" title="Article 23 of the Convention on the Rights of the Child (1990), stipulates that “recognizing the special needs of a disabled child, assistance … shall be provided free of charge … and shall be designed to ensure that the disabled child has effective access to and receives education, training [and] health care services …”">Children with disabilities</span></label></li>
                <li><input type="checkbox" id="cq-children-21" name="cq-children-21" value="1"><label for="cq-children-21"><span class="tooltips" title="Article 28 of the Convention on the Rights of the Child (1990), requires States to “recognize the right of the child to education, and with a view to achieving this right progressively and on the basis of equal opportunity, they shall, in particular, make primary education compulsory and available free to all.’">Girls</span></label></li>
              </ul>
            </div>

            <div class="tab-navigation" style="display:block; clear:both; text-align:center;">
              <a href="#tab-health" class="previous"><img src="/modules/custom_spp/assessment_tool/images/icon-previous.png"></a>
              <a href="#tab-working" class="next"><img src="/modules/custom_spp/assessment_tool/images/icon-next.png"></a>
            </div>
          </div>
            
          <div id="tab-working" class="tab-content clearfix">
            <p class="tab-description">Select the scenario that best describes access to income security for working-age groups in your country:</p>
            <ul class="list-icheck list-radio">
              <li><input type="radio" id="opt-working-4" name="opt-working" value="4"><label for="opt-working-4">All working-age residents have access to a nationally defined minimum level of publicly funded income security.</label></li>
              <li><input type="radio" id="opt-working-3" name="opt-working" value="3"><label for="opt-working-3">Publicly funded income security is currently available, but does not reach all working-age residents.</label></li>
              <li><input type="radio" id="opt-working-2" name="opt-working" value="2"><label for="opt-working-2">Constitutional provisions or legislation entitles working-age residents to income security, but publicly funded schemes are not currently implemented.</label></li>
              <li><input type="radio" id="opt-working-1" name="opt-working" value="1" checked><label for="opt-working-1">Working-age residents only have access to private income security and there is no legal framework for the provision of public income security.</label></li>
            </ul>

            <div id="control-working-4" class="tab-control-question">
              <p><strong>Do income security schemes provide equal access to people of working-age in the following groups?</strong></p>
              <ul class="list-icheck list-checkbox">
                <li><input type="checkbox" id="cq-working-43" name="cq-working-43" value="3"><label for="cq-working-43"><span class="tooltips" title="Article 54 of the International Convention on the Protection of the Rights of All Migrant Workers and Members of Their Families (1990), stipulates that “migrant workers shall enjoy equality of treatment with nationals of the State of employment in respect of protection against dismissal, unemployment benefits, [and] access to public work schemes intended to combat unemployment.”">Migrant Workers</span></label></li>
                <li><input type="checkbox" id="cq-working-42" name="cq-working-42" value="2"><label for="cq-working-42"><span class="tooltips" title="Article 27 of the Convention on the Rights of Persons with Disabilities (2006), requires that “States Parties shall safeguard and promote the realization of the right to work, including for those who acquire a disability during the course of employment.”">Working-age persons with disabilities</span></label></li>
                <li><input type="checkbox" id="cq-working-41" name="cq-working-41" value="1"><label for="cq-working-41"><span class="tooltips" title="Article 11 of the Convention on the Elimination of All Forms of Discrimination Against Women (1979), requires State to “take all appropriate measures to eliminate discrimination against women in the field of employment in order to ensure … the right to social security, particularly in cases of retirement, unemployment, sickness, invalidity and old age and other incapacity to work, as well as the right to paid leave.”">Working-age women</span></label></li>
              </ul>
            </div>

            <div id="control-working-2" class="tab-control-question">
              <p><strong>Do constitutional and/or legal provisions grant equal rights to basic income security for the following groups?</strong></p>
              <ul class="list-icheck list-checkbox">
                <li><input type="checkbox" id="cq-working-23" name="cq-working-23" value="3"><label for="cq-working-23"><span class="tooltips" title="Article 54 of the International Convention on the Protection of the Rights of All Migrant Workers and Members of Their Families (1990), stipulates that “migrant workers shall enjoy equality of treatment with nationals of the State of employment in respect of protection against dismissal, unemployment benefits, [and] access to public work schemes intended to combat unemployment.”">Migrant Workers</span></label></li>
                <li><input type="checkbox" id="cq-working-22" name="cq-working-22" value="2"><label for="cq-working-22"><span class="tooltips" title="Article 27 of the Convention on the Rights of Persons with Disabilities (2006), requires that “States Parties shall safeguard and promote the realization of the right to work, including for those who acquire a disability during the course of employment.”">Working-age persons with disabilities</span></label></li>
                <li><input type="checkbox" id="cq-working-21" name="cq-working-21" value="1"><label for="cq-working-21"><span class="tooltips" title="Article 11 of the Convention on the Elimination of All Forms of Discrimination Against Women (1979), requires State to “take all appropriate measures to eliminate discrimination against women in the field of employment in order to ensure … the right to social security, particularly in cases of retirement, unemployment, sickness, invalidity and old age and other incapacity to work, as well as the right to paid leave.”">Working-age women</span></label></li>
              </ul>
            </div>

            <div class="tab-navigation" style="display:block; clear:both; text-align:center;">
              <a href="#tab-children" class="previous"><img src="/modules/custom_spp/assessment_tool/images/icon-previous.png"></a>
              <a href="#tab-older" class="next"><img src="/modules/custom_spp/assessment_tool/images/icon-next.png"></a>
            </div>
          </div>
        
          <div id="tab-older" class="tab-content clearfix">
            <p class="tab-description">Select the scenario that best describes access to income security for older persons in your country:</p>
            <ul class="list-icheck list-radio">
              <li><input type="radio" id="opt-older-4" name="opt-older" value="4"><label for="opt-older-4">All older persons have access to a nationally defined minimum level of publicly funded income security.</label></li>
              <li><input type="radio" id="opt-older-3" name="opt-older" value="3"><label for="opt-older-3">Publicly funded income security is currently available, but does not reach all older persons.</label></li>
              <li><input type="radio" id="opt-older-2" name="opt-older" value="2"><label for="opt-older-2">Constitutional provisions or legislation entitles older persons to income security, but publicly funded schemes are not currently implemented.</label></li>
              <li><input type="radio" id="opt-older-1" name="opt-older" value="1" checked><label for="opt-older-1">Older persons only have access to private income security and there is no legal framework for the provision of public income security.</label></li>
            </ul>

            <div id="control-older-4" class="tab-control-question">
              <p><strong>Are income security schemes designed to effectively reach older persons in the following groups?</strong></p>
              <ul class="list-icheck list-checkbox">
                <li><input type="checkbox" id="cq-older-43" name="cq-older-43" value="3"><label for="cq-older-43"><span class="tooltips" title="Article 7 of the International Convention on the Protection of the Rights of All Migrant Workers and Members of Their Families (1990), requires States to “undertake, in accordance with the international instruments concerning human rights, to respect and to ensure to all migrant workers and members of their families within their territory or subject to their jurisdiction the rights provided for in the present Convention without distinction of any kind such as … age …”">Older Migrants</span></label></li>
                <li><input type="checkbox" id="cq-older-42" name="cq-older-42" value="2"><label for="cq-older-42"><span class="tooltips" title="Article 28 of the Convention on the Rights of Persons with Disabilities (2006), requires State parties to “to ensure access by persons with disabilities, in particular … older persons with disabilities, to social protection programmes and poverty reduction programmes.”">Older persons with disabilities</span></label></li>
                <li><input type="checkbox" id="cq-older-41" name="cq-older-41" value="1"><label for="cq-older-41"><span class="tooltips" title="Article 11 of the Convention on the Elimination of All Forms of Discrimination Against Women (1979), requires states to “take all appropriate measures … to ensure, on a basis of equality of men and women, the … right to social security, particularly in cases of retirement, unemployment, sickness, invalidity and old age.”">Older women</span></label></li>
              </ul>
            </div>

            <div id="control-older-2" class="tab-control-question">
              <p><strong>Do constitutional and/or legal provisions grant the right to basic income security for the following groups?</strong></p>
              <ul class="list-icheck list-checkbox">
                <li><input type="checkbox" id="cq-older-23" name="cq-older-23" value="3"><label for="cq-older-23"><span class="tooltips" title="Article 7 of the International Convention on the Protection of the Rights of All Migrant Workers and Members of Their Families (1990), requires States to “undertake, in accordance with the international instruments concerning human rights, to respect and to ensure to all migrant workers and members of their families within their territory or subject to their jurisdiction the rights provided for in the present Convention without distinction of any kind such as … age …”">Older Migrants</span></label></li>
                <li><input type="checkbox" id="cq-older-22" name="cq-older-22" value="2"><label for="cq-older-22"><span class="tooltips" title="Article 28 of the Convention on the Rights of Persons with Disabilities (2006), requires State parties to “to ensure access by persons with disabilities, in particular … older persons with disabilities, to social protection programmes and poverty reduction programmes.”">Older persons with disabilities</span></label></li>
                <li><input type="checkbox" id="cq-older-21" name="cq-older-21" value="1"><label for="cq-older-21"><span class="tooltips" title="Article 11 of the Convention on the Elimination of All Forms of Discrimination Against Women (1979), requires states to “take all appropriate measures … to ensure, on a basis of equality of men and women, the … right to social security, particularly in cases of retirement, unemployment, sickness, invalidity and old age.”">Older women</span></label></li>
              </ul>
            </div>

            <div class="tab-navigation" style="display:block; clear:both; text-align:center;">
              <a href="#tab-working" class="previous"><img src="/modules/custom_spp/assessment_tool/images/icon-previous.png"></a>
              <button type="submit" class="icon-finish">Finish</button>
            </div>
          </div>
        </div>
      </div><!-- #tabs-tool -->
    ';
  }

  protected function buildResult() {
    $session = \Drupal::request()->getSession();
    $region = $session->get('region');
    $health = $session->get('health');
    $children = $session->get('children');
    $worker = $session->get('worker');
    $older = $session->get('older');

    $results = [];
    $results['health'][1] = "Residents only have access to private health care and there is no legal framework for the provision of public health care.";
    $results['health'][2] = "Constitutional provisions or legislation entitles residents to health coverage, but publicly funded schemes are not currently implemented.";
    $results['health'][3] = "Publicly funded health care is currently implemented, but gaps in coverage remain.";
    $results['health'][4] = "All residents have access to essential publicly funded health care services.";

    $results['children'][1] = "Children only have access to private social security and there is no legal framework for the provision of public income security.";
    $results['children'][2] = "Constitutional provisions or legislation entitles children to income security, but publicly funded schemes are not currently implemented.";
    $results['children'][3] = "Publicly funded income security is currently available, but does not reach all children.";
    $results['children'][4] = "All children have access to a nationally defined minimum level of publicly funded income security.";

    $results['worker'][1] = "Working-age residents only have access to private income security and there is no legal framework for the provision of public income security.";
    $results['worker'][2] = "Constitutional provisions or legislation entitles working-age residents to income security, but publicly funded schemes are not currently implemented.";
    $results['worker'][3] = "Publicly funded income security is currently available, but does not reach all working-age residents.";
    $results['worker'][4] = "All working-age residents have access to a nationally defined minimum level of publicly funded income security.";

    $results['older'][1] = "Older persons only have access to private income security and there is no legal framework for the provision of public income security.";
    $results['older'][2] = "Constitutional provisions or legislation entitles older persons to income security, but publicly funded schemes are not currently implemented.";
    $results['older'][3] = "Publicly funded income security is currently available, but does not reach all older persons.";
    $results['older'][4] = "All older persons have access to a nationally defined minimum level of publicly funded income security.";

    // $regions = new Regions();
    $url = ''; //$regions->getRegion()[$region]['url'];

    return '
      <div id="diagram"></div>
      <div id="tool-end">
        <p>This pie chart provides an approximation of the extent of social protection coverage in your national context and has been generated based on your response to the control questions.</p>

        <ul class="list-result">
          <li class="list-health" data-option="' . $health . '">' . $results['health'][$health] . '</li>
          <li class="list-children" data-option="' . $children . '">' . $results['children'][$children] . '</li>
          <li class="list-working" data-option="' . $worker . '">' . $results['worker'][$worker] . '</li>
          <li class="list-older" data-option="' . $older . '">' . $results['older'][$older] . '</li>
          <li class="list-gap">Indicates your gaps in coverage</li>
        </ul>

        <!--div class="form-action">
          <a href="/engage/assessment-tool/' . $url . '" class="btn btn-primary">Generate Good Practices</a>
        </div-->
      </div><!-- #tool-end -->
    ';
  }
}
