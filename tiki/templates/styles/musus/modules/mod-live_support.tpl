{* $Header: /cvsroot/tikiwiki/tiki/templates/styles/musus/modules/mod-live_support.tpl,v 1.1 2004-01-07 04:31:24 musus Exp $ *}

{if $feature_live_support eq 'y'}
{tikimodule title="{tr}Live support{/tr}" name="live_support"}
{if $modsupport > 0}
<a href="#" onClick='javascript:window.open("tiki-live_support_client.php","","menubar=,scrollbars=yes,resizable=yes,height=450,width=300");'><img border="0" src="tiki-live_support_server.php?operators_online=1" alt="image" /></a>
{else}
<img border="0" src="tiki-live_support_server.php?operators_online=0" alt="image" />
{/if}
{if $tiki_p_live_support_admin eq 'y' or $user_is_operator eq 'y'}
<br /><a class="linkmodule" {jspopup href="tiki-live_support_console.php"}>{tr}Open operator console{/tr}</a>
{/if}
{/tikimodule}
{/if}
