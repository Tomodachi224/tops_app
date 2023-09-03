<?php
namespace Drupal\assessment_tool\Form;

use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;
use Symfony\Component\HttpFoundation\RedirectResponse;


class Map extends FormBase {
  public function getFormId() {
    return 'assessment_tool_map_form';
  }

	public function buildForm(array $form, FormStateInterface $form_state) {
    $form['#attached']['library'][] = 'assessment_tool/assessment_map';

    $form['map'] = [
      '#type' => 'item',
      '#children' => $this->buildMap(),
      '#id' => 'world-map',
    ];

	  return $form;
	}

  public function validateForm(array &$form, FormStateInterface $form_state) {
  }

  public function submitForm(array &$form, FormStateInterface $form_state) {
  }

  protected function buildMap() {
    $html = '
      <img src="/modules/custom_spp/assessment_tool/images/world-map.png" usemap="#world" />
      <map name="world">
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="577,123,577,121,574,116,573,118,575,124,578,129,579,134,581,141,583,142,584,140,581,135,581,132,583,132" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="588,154,588,151,590,151,592,149,590,147,588,148,583,144,582,145,583,149,581,153,583,156,585,155,583,153,585,152" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="579,177,580,178,581,175,584,175,587,174,589,172,587,165,588,164,588,160,585,157,583,158,584,161,584,167,582,169,580,169,579,173,577,172,574,174,571,177,573,177,579,175" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="576,178,578,179,577,176,574,178,576,180" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="571,178,569,180,571,180,570,182,572,185,573,183,572,178" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="536,211,534,213,537,215,538,213,538,211" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="555,202,555,204,557,207,558,204,558,200,557,199" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="481,235,481,238,483,240,485,239,485,236,482,232" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="532,258,530,256,527,253,525,250,520,246,516,243,515,241,513,241,511,240,511,243,514,244,518,248,521,256,528,263,531,262" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="540,257,542,257,544,258,547,258,548,260,551,257,551,255,553,250,555,249,553,247,553,243,556,241,554,240,551,238,550,241,547,242,544,246,542,246,541,249,538,248,537,251" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="547,269,547,267,544,267,544,265,540,264,539,265,537,265,536,264,532,263,531,265,536,267,541,268" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="561,255,564,253,561,253,559,254,558,253,560,251,566,251,568,249,568,248,565,250,560,249,558,250,557,253,555,257,555,259,556,259,556,262,558,262,560,257,561,261,564,259" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="596,267,597,269,601,270,604,266,607,268,611,271,616,272,609,265,611,264,607,262,605,259,598,257,592,254,588,258,586,257,585,253,582,252,579,253,581,256,584,256,581,257,583,260,586,260,591,262,593,264,591,268" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="556,268,553,268,551,268,553,269" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="573,268,569,268,565,270,563,273,568,270" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="559,268,557,269,562,268" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="576,257,573,258,579,259" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="617,262,612,262,613,264,617,264,619,262,621,260,619,260" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="566,235,564,234,562,236,566,237,566,239,569,239,569,237,570,238,570,234,568,232" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="561,214,557,214,556,219,559,224,561,223,565,225,563,223,560,222,560,220,561,217" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="560,228,560,225,558,224" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="561,230,563,229,561,228" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="564,230,562,232,564,233" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="565,226,568,229,568,227" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="625,265,626,264,624,262" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="641,296,646,298,639,293" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="665,289,668,290,667,287" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="612,298,610,293,606,291,605,280,602,280,600,274,597,286,594,287,586,281,589,276,586,276,581,275,576,277,575,281,572,281,570,279,567,281,563,286,561,285,557,291,552,292,545,295,542,301,543,304,542,309,544,318,541,323,546,326,551,323,557,324,561,321,566,320,572,319,577,320,578,323,579,327,585,323,586,329,586,336,591,339,595,337,597,340,605,337,607,330,614,321,617,312,616,305" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="594,346,592,345,592,353,594,354,597,351,599,345,597,346" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="640,354,637,357,634,360,632,360,627,365,631,369,635,366,637,362,641,360,641,358,645,355,645,352,643,350" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="654,343,652,339,650,332,651,340,649,345,647,345,647,347,649,348,649,350,647,352,648,354,653,349,654,346,657,342,656,342" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="402,75,406,79,412,81,412,79,409,77,407,72,408,68,410,62,413,56,419,52,418,49,415,49,412,53,407,56,404,66,404,73" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="440,24,442,21,441,18,437,16,436,19,436,22" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="443,29,449,30,451,28,449,26,447,22,443,22,441,25" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="460,29,458,27,452,25,454,34" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="517,33,522,29,522,25,515,24,515,27,511,24,510,27,514,32" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="532,25,525,25,530,27" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="524,35,523,39,528,37" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="598,139,595,142,592,146,595,144" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="601,130,603,124,602,124" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="557,231,556,229,556,230,552,234" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="560,271,556,270,555,270,558,272" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="573,248,572,251,574,253,573,251,575,251,574,250,575,249,573,249" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="646,283,646,283,645,281" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="638,272,632,268,634,271" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="668,286,670,286,671,285" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="383,32,380,34,386,33" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="384,37,386,36,387,34,384,35" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="401,32,400,31,401,29,398,30,399,33" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="403,27,401,25,400,27,402,29" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="394,28,394,24,393,24,393,26,391,29,395,31" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="396,35,397,34,396,32,394,34" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="378,166,378,165,377,165,376,166,376,166,376,166,376,167,376,167,376,168,376,168,375,168,376,169,377,169,376,169,376,170,377,169,378,169,378,168,380,168,380,168,381,167,380,167,380,167,379,167,379,166,379,165,379,165,378,165" />
        <area shape="poly" class="asia" title="Asia-Pacific" alt="Asia-Pacific" data-maphilight=\'{"fillColor":"6B4D9F"}\' coords="607,61,611,60,611,55,608,52,609,50,611,52,613,49,616,51,621,51,618,45,617,39,613,38,611,40,612,43,607,39,590,37,579,38,584,44,582,45,578,40,576,43,569,45,569,48,564,47,563,44,558,41,551,45,546,43,541,40,536,41,528,41,527,44,530,47,523,51,519,50,520,55,513,52,510,46,501,46,503,49,495,50,494,48,484,51,478,58,481,42,474,35,470,37,468,39,464,34,461,33,460,38,462,41,455,45,449,49,446,55,450,59,441,62,444,67,446,67,449,71,440,67,435,72,437,76,438,79,440,82,443,82,440,84,442,86,440,93,439,92,439,84,437,82,433,74,432,68,426,68,427,74,426,76,428,82,432,84,432,87,424,83,420,82,415,80,414,81,419,85,419,88,412,88,409,87,402,92,401,95,399,95,397,93,399,92,397,89,395,90,396,95,397,98,394,97,390,100,391,103,390,104,386,102,385,104,388,106,387,107,383,105,382,99,380,99,378,96,385,98,389,99,391,97,391,94,382,88,377,88,373,88,371,91,374,94,373,96,375,101,375,104,378,110,375,117,377,119,375,120,374,125,375,130,380,131,381,134,384,137,382,139,383,141,387,140,390,145,393,145,398,147,398,151,397,153,396,154,395,154,396,155,395,157,394,157,395,159,397,159,401,162,402,163,403,166,403,167,401,168,399,167,398,168,394,167,393,166,392,166,391,165,389,165,386,166,385,167,382,167,381,167,381,168,382,168,381,169,381,169,378,169,377,169,376,170,376,171,377,171,377,173,376,174,378,175,379,177,382,178,382,179,384,179,384,177,387,178,388,179,391,178,392,177,393,178,395,177,394,178,394,179,396,179,396,177,399,177,401,177,403,177,410,176,410,176,411,178,413,180,412,183,416,186,419,191,419,191,422,191,425,196,431,199,434,196,436,200,442,200,445,202,453,201,455,204,457,205,458,206,461,206,459,207,462,211,466,209,468,220,473,228,475,233,477,235,481,231,481,227,481,221,486,217,493,210,493,209,495,207,497,208,501,206,506,212,508,217,508,220,510,220,513,217,514,219,515,223,517,227,517,235,518,237,520,238,521,244,526,248,528,249,526,245,526,242,523,239,521,237,520,235,518,233,518,231,518,230,519,225,521,225,521,226,523,226,528,231,529,235,532,231,536,229,537,226,535,219,531,216,529,212,531,209,534,207,537,210,538,208,543,205,549,204,554,196,556,188,554,188,555,183,551,178,549,177,550,173,554,171,554,169,550,169,547,171,544,167,544,166,546,165,549,160,552,161,550,163,550,166,553,164,556,163,558,164,558,169,560,168,562,170,562,175,563,177,565,175,566,176,568,172,563,165,561,164,562,162,564,160,564,156,567,152,569,153,572,151,575,143,576,134,572,119,568,117,567,119,564,119,563,116,560,116,564,106,564,100,566,97,575,96,576,93,580,94,581,96,585,93,584,84,589,81,590,84,592,85,594,81,592,77,595,76,597,84,595,86,594,96,592,104,601,121,604,123,604,111,606,107,604,103,606,102,600,95,599,88,602,85,603,87,604,84,607,82,610,84,610,79,611,75,614,71,618,70,617,66" />
        
        <area shape="poly" class="africa" title="Africa" alt="Africa" data-maphilight=\'{"fillColor":"B02E6A"}\' coords="422,274,418,281,413,282,411,285,412,288,410,293,410,299,413,301,417,300,424,281" />
        <area shape="poly" class="africa" title="Africa" alt="Africa" data-maphilight=\'{"fillColor":"B02E6A"}\' coords="376,212,374,212,359,205,355,207,351,206,350,203,348,203,346,200,347,199,347,191,345,188,344,186,342,184,344,183,344,178,332,178,328,180,326,182,327,186,328,187,327,188,324,188,324,189,323,190,318,193,315,194,313,195,313,197,305,197,305,197,303,200,298,208,299,219,296,223,298,224,298,227,303,232,306,237,309,238,315,243,322,241,325,242,329,241,333,239,337,239,339,242,341,243,346,242,347,243,348,247,346,252,348,257,350,258,354,265,353,268,355,272,354,274,352,277,351,281,351,286,353,289,355,294,357,303,360,308,362,314,361,316,365,320,368,319,376,318,381,315,387,308,388,306,389,303,389,302,391,300,394,299,395,296,395,293,394,289,399,285,404,282,406,279,405,274,406,271,404,270,404,267,404,264,403,263,406,257,415,247,419,245,423,239,426,233,426,229,413,231,410,229,412,228,407,223,404,221,402,216,399,214,398,208,376,208" />
        
        <area shape="poly" class="mena" title="Middle East & North Africa" alt="Middle East & North Africa" data-maphilight=\'{"fillColor":"00AACD"}\' coords="441,208,439,204,437,204,435,202,434,199,431,203,426,204,425,203,425,200,424,199,424,202,422,198,419,194,418,192,419,191,416,186,412,183,413,180,411,178,410,176,410,176,403,177,401,177,399,177,396,177,396,179,394,179,395,182,393,187,391,189,385,189,382,190,375,189,369,186,366,188,366,190,364,192,362,190,358,189,356,187,352,186,347,184,349,181,347,177,344,178,344,183,342,184,344,186,345,188,347,191,347,199,346,200,348,203,350,203,351,206,355,207,359,205,374,212,376,212,376,208,398,208,398,208,396,207,394,201,389,193,393,196,394,196,397,200,399,203,401,204,402,207,403,210,406,212,407,215,409,218,412,227,414,226,416,225,417,225,421,224,422,223,428,221,429,219,433,218,434,216,435,216,436,214,438,214,438,212" />
        <area shape="poly" class="mena" title="Middle East & North Africa" alt="Middle East & North Africa" data-maphilight=\'{"fillColor":"00AACD"}\' coords="313,197,313,195,315,194,318,193,323,190,324,189,324,188,327,188,328,187,327,186,326,182,321,181,320,180,317,184,313,186,311,189,312,192,310,195,306,196,305,197,305,197" />
        
        <area shape="poly" class="latin" title="Latin America & Caribbean" alt="Latin America & Caribbean" data-maphilight=\'{"fillColor":"F6911E"}\' coords="171,208,173,206,176,205,179,206,185,208,191,211,189,212,184,212,185,211,184,210,182,208,180,208,179,208,176,207,177,206,175,206,174,207" />
        <area shape="poly" class="latin" title="Latin America & Caribbean" alt="Latin America & Caribbean" data-maphilight=\'{"fillColor":"F6911E"}\' coords="191,215,194,214,193,212,195,212,198,212,202,215,197,215,196,217,194,216" />
        <area shape="poly" class="latin" title="Latin America & Caribbean" alt="Latin America & Caribbean" data-maphilight=\'{"fillColor":"F6911E"}\' coords="263,261,260,260,256,257,247,256,245,254,237,251,236,249,233,243,230,240,223,239,217,235,210,230,208,232,206,231,202,231,202,229,199,229,195,230,196,228,194,227,192,229,189,229,185,235,180,232,177,234,175,233,172,230,173,222,169,220,163,220,164,216,165,213,167,209,167,208,161,210,159,213,157,215,152,215,149,212,147,208,147,204,148,200,145,198,144,195,143,191,140,190,138,192,136,190,133,186,124,186,118,183,113,183,114,187,117,193,116,194,120,197,120,201,124,205,125,204,123,202,122,198,117,189,117,185,120,187,123,194,126,197,125,199,128,200,131,205,132,209,131,211,135,215,138,216,140,218,148,221,152,219,157,224,160,224,165,226,168,230,168,232,175,235,178,237,179,236,178,235,180,233,184,239,183,245,179,250,177,254,176,261,181,267,186,279,192,283,194,284,198,288,199,301,198,309,199,320,196,328,198,333,197,335,198,339,200,339,200,356,204,369,214,374,219,372,215,370,212,365,210,360,214,355,214,352,211,350,211,348,214,346,214,342,217,340,213,339,213,336,217,337,218,335,218,331,223,331,226,329,227,326,224,320,231,321,240,306,240,302,246,297,252,295,255,291,257,285,257,277,264,269,265,265" />
        <area shape="poly" class="latin" title="Latin America & Caribbean" alt="Latin America & Caribbean" data-maphilight=\'{"fillColor":"F6911E"}\' coords="204,216,204,215,207,215" />
        <area shape="poly" class="latin" title="Latin America & Caribbean" alt="Latin America & Caribbean" data-maphilight=\'{"fillColor":"F6911E"}\' coords="184,201,184,202,185,202" />
        <area shape="poly" class="latin" title="Latin America & Caribbean" alt="Latin America & Caribbean" data-maphilight=\'{"fillColor":"F6911E"}\' coords="184,203,185,203,185,204" />
        <area shape="poly" class="latin" title="Latin America & Caribbean" alt="Latin America & Caribbean" data-maphilight=\'{"fillColor":"F6911E"}\' coords="192,209,192,210,192,210,193,210,193,209" />
        <area shape="poly" class="latin" title="Latin America & Caribbean" alt="Latin America & Caribbean" data-maphilight=\'{"fillColor":"F6911E"}\' coords="187,201,190,206,190,203" />
        <area shape="poly" class="latin" title="Latin America & Caribbean" alt="Latin America & Caribbean" data-maphilight=\'{"fillColor":"F6911E"}\' coords="213,216,215,224,215,219" />
      </map>
    ';
    return $html;
  }

}