{* $Id$ *}

{if $prefs.feature_freetags eq 'y' and $tiki_p_view_freetags eq 'y' and $tagid}
{if !isset($tpl_module_title)}{assign value="{tr}Folksonomy{/tr}" var="tpl_module_title"}{/if}
{tikimodule title=$tpl_module_title name="freetag" flip=$module_params.flip decorations=$module_params.decorations nobox=$module_params.nobox}

{include file="freetag_list.tpl" deleteTag="y"}

{if $tiki_p_freetags_tag eq 'y'}
<form name="addTags" method="post" action="{$smarty.server.REQUEST_URI}">
<input type="text" name="addtags" maxlength="40" />
<input type="submit" name="Add" value="Add" />
</form>
{/if}

{/tikimodule}
{/if}
