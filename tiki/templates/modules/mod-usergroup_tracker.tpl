{* $Header: /cvsroot/tikiwiki/tiki/templates/modules/mod-usergroup_tracker.tpl,v 1.6 2007-02-18 11:21:19 mose Exp $ *}

{if $user}
{if !isset($tpl_module_title)}{assign var=tpl_module_title value="{tr}Login{/tr}"}{/if}
{tikimodule title=$tpl_module_title name="login_infos" flip=$module_params.flip decorations=$module_params.decorations}

<div><a class="linkmodule" href="tiki-logout.php">{tr}Logout{/tr}</a></div>

{if $userTracker eq 'y'}
<div>{tr}User informations{/tr}: </div>
<div class="">
{if $userTracker}
&nbsp;&nbsp;<a href="tiki-view_tracker_item.php?view=+user" class="linkmodule">{$user}</a>
{else}
{$user}
{/if}
</div>
{/if}


{if $groupTracker eq 'y'}
<div>{tr}Group informations{/tr}:</div>
<div class="box-data">
{if $groupTracker}
&nbsp;&nbsp;<a href="tiki-view_tracker_item.php?view=+group" class="linkmodule">{$group}</a>
{else}
{$group}
{/if}
</div>
{/if}

{/tikimodule}
{/if}

{if $groupTracker eq 'n' and $userTracker eq 'n' }
<a href="tiki-admin.php?page=login" class="linkmodule">{tr}You need to activate user and/or group trackers{/tr}</a>
{/if}

