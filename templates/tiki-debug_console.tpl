<!-- START of {$smarty.template} -->{* $Id$ *}

{if $tiki_p_admin eq 'y' and $prefs.feature_debug_console eq 'y'}
<div class="debugconsole" id="debugconsole" style="{$debugconsole_style}">

{* Command prompt form *}
<form method="post" action="{$console_father|escape}">
<table border="0" >
  <tr><td colspan="3" align="right">
    <b>{tr}Tiki Debugger Console{/tr}</b>
    <a class="separator" href="javascript:toggle('debugconsole');" title="{tr}Close{/tr}">
      <small>[x]</small>
    </a>
  </td></tr>
  <tr>
    <td class="formcolor"><small>{tr}Current URL{/tr}:</small></td>
    <td class="formcolor">{$console_father|escape}</td>
  </tr>
  <tr>
    <td class="formcolor">{tr}Command{/tr}:</td>
    <td class="formcolor"><input type="text" name="command" size="70" value='{$command|escape:"html"}' /></td>
  </tr>
  <tr>
    <td class="formcolor"></td>
    <td class="formcolor">
      <input type="submit" name="exec" value="{tr}exec{/tr}" /> &nbsp;&nbsp;&nbsp;&nbsp;
      <small>{tr}Type <code>help</code> to get list of available commands{/tr}</small>
    </td>
  </tr>
</table>
</form>

{* Generate tabs code if more than one tab, else make one div w/o button *}

{* 1) Buttons bar *}
{if count($tabs) > 1}
  <table><tr>
  {section name=i loop=$tabs}
    <td>
			{assign var=thistabshref value=$tabs[i].button_href}
			{assign var=thistabscaption value=$tabs[i].button_caption}
			{button href=$thistabshref _text=$thistabscaption}
    </td>
  {/section}
  </tr></table>
{/if}

{* 2) Divs with tabs *}
{section name=i loop=$tabs}
<div class="debugger-tab" id="{$tabs[i].tab_id}" style="display:{if $tabs[i].button_caption == 'console'}block{else}none{/if};">
    {$tabs[i].tab_code}
</div><!-- Tab: {$tabs[i].tab_id} -->
{/section}

</div><!-- debug console -->
{/if}<!-- END of {$smarty.template} -->
