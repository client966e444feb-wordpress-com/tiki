{* $Id$ *}
{if $prefs.use_minified_scripts == 'y'}{assign var=minified value='.min'}{assign var=minidir value='minified'}{else}{assign var=minified value=''}{assign var=minidir value=''}{/if}
<!--  start jquery-tiki -->
<script type="text/javascript" src="lib/jquery/jquery{$minified}.js"></script>
<script type="text/javascript" src="lib/jquery_tiki/tiki-jquery.js"></script>
{if $prefs.feature_jquery_ui eq 'y' or $prefs.feature_jquery_tooltips eq 'y' or $prefs.feature_jquery_autocomplete eq 'y' or $prefs.feature_jquery_superfish eq 'y' or $prefs.feature_jquery_reflection eq 'y'}
<script type="text/javascript">
<!--//--><![CDATA[//><!--
// Save $ if it's used for moo {* note: add plugins between this block and the Restore $ *}
{literal}var $old; if ($) {$old = $;} $ = $jq;{/literal}
//--><!]]>
</script>
{if $prefs.feature_jquery_ui eq 'y'}{* TODO optimise so not including all - maybe - one day *}
<script type="text/javascript" src="lib/jquery/jquery-ui/ui/{$minidir}/jquery-ui{$minified}.js"></script>
{/if}
{if $prefs.feature_jquery_tooltips eq 'y'}
<script type="text/javascript" src="lib/jquery/cluetip/jquery.dimensions.js"></script>
<script type="text/javascript" src="lib/jquery/cluetip/jquery.hoverIntent.js"></script>
<script type="text/javascript" src="lib/jquery/cluetip/jquery.cluetip.js"></script>
<link rel="stylesheet" href="lib/jquery/cluetip/jquery.cluetip.css" type="text/css" /> 
{/if}
{if $prefs.feature_jquery_autocomplete eq 'y'}
<script type="text/javascript" src="lib/jquery/jquery-autocomplete/lib/jquery.ajaxQueue.js"></script>
<script type="text/javascript" src="lib/jquery/jquery-autocomplete/lib/jquery.bgiframe{$minified}.js"></script>
<script type="text/javascript" src="lib/jquery/jquery-autocomplete/jquery.autocomplete{$minified}.js"></script>
<link rel="stylesheet" href="lib/jquery/jquery-autocomplete/jquery.autocomplete.css" type="text/css" /> 
{/if}
{if $prefs.feature_jquery_superfish eq 'y'}
<script type="text/javascript" src="lib/jquery/superfish/js/superfish.js"></script> 
{/if}
{if $prefs.feature_jquery_reflection eq 'y'}
<script type="text/javascript" src="lib/jquery/reflection-jquery/js/reflection.js"></script> 
{/if}
{if $prefs.feature_jquery_sheet eq 'y'}
<link rel="stylesheet" href="lib/jquery/jquery.sheet/jquery.sheet.base.css" type="text/css" /> 
<script type="text/javascript" src="lib/jquery/jquery.sheet/jquery.sheet{$minified}.js"></script> 
{/if}
{if $prefs.feature_jquery_tablesorter eq 'y'}
<link rel="stylesheet" href="lib/jquery_tiki/tablesorter/themes/tiki/style.css" type="text/css" /> 
<script type="text/javascript" src="lib/jquery/tablesorter/jquery.tablesorter{$minified}.js"></script>
<script type="text/javascript" src="lib/jquery/tablesorter/addons/pager/jquery.tablesorter.pager.js"></script>
{/if}
<script type="text/javascript">
<!--//--><![CDATA[//><!--
// Restore $
{literal}$jq = $; if ($old) { $ = $old; $old = $jq.undefined };{/literal}
//--><!]]>
</script>
{/if}{* end if $prefs.feature_jquery_ui eq 'y' or $prefs.feature_jquery_tooltips etc *}
<script type="text/javascript">
<!--//--><![CDATA[//><!--

{* Object to hold prefs for jq *}
var jqueryTiki = new Object();
jqueryTiki.ui = {if $prefs.feature_jquery_ui eq 'y'}true{else}false{/if};
jqueryTiki.tooltips = {if $prefs.feature_jquery_tooltips eq 'y'}true{else}false{/if};
jqueryTiki.autocomplete = {if $prefs.feature_jquery_autocomplete eq 'y'}true{else}false{/if};
jqueryTiki.superfish = {if $prefs.feature_jquery_superfish eq 'y'}true{else}false{/if};
jqueryTiki.replection = {if $prefs.feature_jquery_reflection eq 'y'}true{else}false{/if};
jqueryTiki.tablesorter = {if $prefs.feature_jquery_tablesorter eq 'y'}true{else}false{/if};

jqueryTiki.effect = "{$prefs.jquery_effect}";				// Default effect
jqueryTiki.effect_direction = "{$prefs.jquery_effect_direction}";	// 'horizontal' | 'vertical' etc
jqueryTiki.effect_speed = "{$prefs.jquery_effect_speed}";	// 'slow' | 'normal' | 'fast' | milliseconds (int) ]
jqueryTiki.effect_tabs = "{$prefs.jquery_effect_tabs}";		// Different effect for tabs
jqueryTiki.effect_tabs_direction = "{$prefs.jquery_effect_tabs_direction}";
jqueryTiki.effect_tabs_speed = "{$prefs.jquery_effect_tabs_speed}";

//--><!]]>
</script>
<!--  end jquery-tiki -->
