{* $Id: $ *}

<!--  start jquery-tiki -->
{if !isset($jqdebug)}{assign var=jqdebug value=false}{/if}
{if $jqdebug}<script type="text/javascript" src="lib/jquery/jquery.js"></script>{else}
<script type="text/javascript" src="lib/jquery/jquery.min.js"></script>{/if}
<script type="text/javascript" src="lib/jquery_tiki/tiki-jquery.js"></script>
<script type="text/javascript">
<!--//--><![CDATA[//><!--
// Save $ as it's used for moo
var $old = $; $ = $jq;
//--><!]]>
</script>
{if $prefs.feature_jquery_ui eq 'y'}{* TODO optimise so not including all - maybe *}
{if $jqdebug}<script type="text/javascript" src="lib/jquery/jquery.ui/ui/jquery.ui.all.js"></script>{else}
<script type="text/javascript" src="lib/jquery/jquery.ui/ui/minified/jquery.ui.all.min.js"></script>{/if}
{/if}
{if $prefs.feature_jquery_tooltips eq 'y'}
<script type="text/javascript" src="lib/jquery/cluetip/jquery.dimensions.js"></script>
<script type="text/javascript" src="lib/jquery/cluetip/jquery.hoverIntent.js"></script>
<script type="text/javascript" src="lib/jquery/cluetip/jquery.cluetip.js"></script>
<link rel="stylesheet" href="lib/jquery/cluetip/jquery.cluetip.css" type="text/css" /> 
{/if}
{if $prefs.feature_jquery_autocomplete eq 'y'}
<script type="text/javascript" src="lib/jquery/jquery-autocomplete/lib/jquery.ajaxQueue.js"></script>
<script type="text/javascript" src="lib/jquery/jquery-autocomplete/lib/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="lib/jquery/jquery-autocomplete/jquery.autocomplete.min.js"></script>
<link rel="stylesheet" href="lib/jquery/jquery-autocomplete/jquery.autocomplete.css" type="text/css" /> 
{/if}
{if $prefs.feature_jquery_superfish eq 'y'}
{*<script type="text/javascript" src="lib/jquery/cluetip/jquery.hoverIntent.js"></script>*} 
{*<link rel="stylesheet" type="text/css" media="screen" href="lib/jquery/superfish/css/superfish.css" />*} 
<script type="text/javascript" src="lib/jquery/superfish/js/superfish.js"></script> 
{/if}

<script type="text/javascript">
<!--//--><![CDATA[//><!--
// Restore $
$jq = $; $ = $old; $old = false;
//--><!]]>
</script>

<script type="text/javascript">
<!--//--><![CDATA[//><!--

{* Object to hold prefs for jq *}
var jqueryTiki = new Object();
jqueryTiki.ui = {if $prefs.feature_jquery_ui eq 'y'}true{else}false{/if};
jqueryTiki.tooltips = {if $prefs.feature_jquery_tooltips eq 'y'}true{else}false{/if};
jqueryTiki.autocomplete = {if $prefs.feature_jquery_autocomplete eq 'y'}true{else}false{/if};
jqueryTiki.superfish = {if $prefs.feature_jquery_superfish eq 'y'}true{else}false{/if};
jqueryTiki.replection = {if $prefs.feature_jquery_reflection eq 'y'}true{else}false{/if};

jqueryTiki.effect = "{$prefs.jquery_effect}";	// Default effect
jqueryTiki.effect_direction = "{$prefs.jquery_effect_direction}";	// 'horizontal' | 'vertical' etc
jqueryTiki.effect_speed = "{$prefs.jquery_effect_speed}";	// 'slow' | 'normal' | 'fast' | milliseconds (int) ]
jqueryTiki.effect_tabs = "{$prefs.jquery_effect_tabs}";	// Different effect for tabs
jqueryTiki.effect_tabs_direction = "{$prefs.jquery_effect_tabs_direction}";
jqueryTiki.effect_tabs_speed = "{$prefs.jquery_effect_tabs_speed}";


//--><!]]>
</script>

<!--  end jquery-tiki -->
