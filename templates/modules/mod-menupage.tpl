<!-- START of {$smarty.template} -->{if !isset($tpl_module_title)}{assign var=tpl_module_title value="{tr}Menu{/tr}"}{/if}
{tikimodule error=$module_params.error title=$tpl_module_title name="menu_$page" flip=$module_params.flip decorations=$module_params.decorations nobox=$module_params.nobox notitle=$module_params.notitle}
{$contentmenu}
{/tikimodule}
