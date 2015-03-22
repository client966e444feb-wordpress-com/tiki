{* $Id$ *}
{if !$viewItemPretty.override}
	{title help="trackers"}{$tracker_item_main_value}{/title}
{/if}


{if ! isset($print_page) || $print_page ne 'y'}

	{* --------- navigation ------ *}
	<div class="t_navbar">
		<div class="pull-right btn-group">
			<a class="btn btn-link" data-toggle="dropdown" data-hover="dropdown" href="#">
				{icon name="more"}
			</a>
			<ul class="dropdown-menu dropdown-menu-right">
				<li class="dropdown-title">
					{tr}Tracker item actions{/tr}
				</li>
				<li class="divider"></li>
				<li>
					{if $viewItemPretty.override}
						{self_link print='y' vi_tpl={$viewItemPretty.value}}
							{icon name="print"} {tr}Print{/tr}
						{/self_link}
					{else}
						{self_link print='y'}
							{icon name="print"} {tr}Print{/tr}
						{/self_link}
					{/if}
				</li>
				{if $item_info.logs.cant|default:null}
					<a href="tiki-tracker_view_history.php?itemId={$itemId}">
						{icon name="history"} {tr}History{/tr}
					</a>
				{/if}
				<li>
					{monitor_link type=trackeritem object=$itemId linktext="{tr}Notification{/tr}" class="link" title=""}
				</li>
				{if $prefs.feature_user_watches eq 'y' and $tiki_p_watch_trackers eq 'y'}
					<li>
						{if $user_watching_tracker ne 'y'}
							<a href="tiki-view_tracker_item.php?trackerId={$trackerId}&amp;itemId={$itemId}&amp;watch=add">
								{icon name="watch"} {tr}Monitor{/tr}
							</a>
						{else}
							<a href="tiki-view_tracker_item.php?trackerId={$trackerId}&amp;itemId={$itemId}&amp;watch=stop">
								{icon name="stop-watching"} {tr}Stop monitoring{/tr}
							</a>
						{/if}
					</li>
					{if $prefs.feature_group_watches eq 'y' and ( $tiki_p_admin_users eq 'y' or $tiki_p_admin eq 'y' )}
						<li>
							<a href="tiki-object_watches.php?objectId={$itemId|escape:"url"}&amp;watch_event=tracker_item_modified&amp;objectType=tracker+{$trackerId}&amp;objectName={$tracker_info.name|escape:"url"}&amp;objectHref={'tiki-view_tracker_item.php?trackerId='|cat:$trackerId|cat:'&itemId='|cat:$itemId|escape:"url"}">
								{icon name="watch-group"} {tr}Group monitor{/tr}
							</a>
						</li>
					{/if}
				{/if}
			</ul>
		</div>
		{if $canModify && $prefs.tracker_legacy_insert neq 'y'}
			<a class="btn btn-default" href="{bootstrap_modal controller=tracker action=update_item trackerId=$trackerId itemId=$itemId}">{icon name="edit"} {tr}Edit{/tr}</a>
		{/if}
	
		{* only include actions bar if no custom view template is assigned *}
		{if !$viewItemPretty.override}
			{include file="tracker_actions.tpl"}
		{/if}
		
		{* show button back only if tpl has been set with vi_tpl or ei_tpl *}
		{if $viewItemPretty.override and !empty($referer)}
			<a class="btn btn-default" href="{$referer}" title="{tr}Back{/tr}">{icon name="arrow-circle-left"} {tr}Back{/tr}</a>
		{/if}
	</div>

	<div class="categbar" align="right">
		{if $user and $prefs.feature_user_watches eq 'y'}
			{if $category_watched eq 'y'}
				{tr}Watched by categories:{/tr}
				{section name=i loop=$watching_categories}
					<a href="tiki-browse_categories.php?parentId={$watching_categories[i].categId}">{$watching_categories[i].name|escape}</a>&nbsp;
				{/section}
			{/if}
		{/if}
	</div>

	{* ------- return/next/previous tab --- *}
	{if $canView}
		{pagination_links cant=$cant|default:null offset=$offset reloff=$smarty.request.reloff|default:null itemname="{tr}Item{/tr}"}
			{* Do not specify an itemId in URL used for pagination, because it will use the specified itemId instead of moving to another item *}
			{$smarty.server.php_self|default:null}?{query itemId=NULL trackerId=$trackerId}
		{/pagination_links}
	{/if}
	
	{include file='tracker_error.tpl'}
	
{/if} 
{* print_page *}



{tabset name='tabs_view_tracker_item' skipsingle=1 toggle=n}

	{* when printing, no js is called to select the tab thus no class "active" assigned (would show nothing). print=y sets this class on printing *}
	{tab name="{tr}View{/tr}" print=y} 
		{* --- tab with view ------------------------------------------------------------------------- *}
		{* In most cases one will not want this header when viewing an item *}
		{* <h3>{$tracker_info.name|escape}</h3> *}
		<h3></h3>
		{if $tracker_is_multilingual}
			<div class="translations">
				<a href="{service controller=translation action=manage type=trackeritem source=$itemId}">{tr}Translations{/tr}</a>
			</div>
			{jq}
				$('.translations a').click(function () {
					var link = this;
					$(this).serviceDialog({
						title: $(link).text(),
						data: {
							controller: 'translation',
							action: 'manage',
							type: 'trackeritem',
							source: "{{$itemId|escape}}"
						}
					});
					return false;
				});
			{/jq}
		{/if}

		{* show item *}
		{trackerfields mode=view trackerId=$trackerId itemId=$itemId fields=$fields itemId=$itemId viewItemPretty=$viewItemPretty.value}

		{* -------------------------------------------------- section with comments --- *}
		{if $tracker_info.useComments eq 'y' and ($tiki_p_tracker_view_comments ne 'n' or $tiki_p_comment_tracker_items ne 'n') and $prefs.tracker_show_comments_below eq 'y'}
			<a id="Comments"></a>
			<div id="comment-container-below" class="well well-sm" data-target="{service controller=comment action=list type=trackeritem objectId=$itemId}"></div>
			{jq}
				var id = '#comment-container-below';
				$(id).comment_load($(id).data('target'));
			{/jq}

		{/if}

	{/tab}

	{* -------------------------------------------------- tab with comments --- *}
	{if $tracker_info.useComments eq 'y' and ($tiki_p_tracker_view_comments ne 'n' or $tiki_p_comment_tracker_items ne 'n') and $prefs.tracker_show_comments_below ne 'y'}

		{tab name="{tr}Comments{/tr} (`$comCount`)" print=n}
			<div id="comment-container" data-target="{service controller=comment action=list type=trackeritem objectId=$itemId}"></div>
			{jq}
				var id = '#comment-container';
				$(id).comment_load($(id).data('target'));
			{/jq}

		{/tab}
	{/if}

	{* ---------------------------------------- tab with attachments --- *}
	{if $tracker_info.useAttachments eq 'y' and $tiki_p_tracker_view_attachments eq 'y'}
		{tab name="{tr}Attachments{/tr} (`$attCount`)" print=n}
			{include file='attachments_tracker.tpl'}
		{/tab}
	{/if}

	{* --------------------------------------------------------------- tab with edit --- *}
	{if (! isset($print_page) || $print_page ne 'y') && $canModify && $prefs.tracker_legacy_insert eq 'y'}
		{tab name=$editTitle}
			<h2>{tr}Edit Item{/tr}</h2>

			<div class="nohighlight">
				{include file="tracker_validator.tpl"}

				{if $tiki_p_admin_trackers eq 'y' and !empty($trackers)}
					<form>
						<input type="hidden" name="itemId" value="{$itemId}">
						<select name="moveto">
							{foreach from=$trackers item=tracker}
								{if $tracker.trackerId ne $trackerId}
									<option value="{$tracker.trackerId}">{$tracker.name|escape}</option>
								{/if}
							{/foreach}
						</select>
						<input type="submit" class="btn btn-default btn-sm" name="go" value="{tr}Move to another tracker{/tr}">
					</form>
				{/if}

				<form enctype="multipart/form-data" action="tiki-view_tracker_item.php" method="post" id="editItemForm">
					{if $special}
						<input type="hidden" name="view" value=" {$special}">
					{else}
						<input type="hidden" name="trackerId" value="{$trackerId|escape}">
						<input type="hidden" name="itemId" value="{$itemId|escape}">
					{/if}
					{if $from}
						<input type="hidden" name="from" value="{$from}">
					{/if}
					{section name=ix loop=$fields}
						{if !empty($fields[ix].value)}
							<input type="hidden" name="{$fields[ix].name|escape}" value="{$fields[ix].value|escape}">
						{/if}
					{/section}
					{if $cant}
						<input type="hidden" name="cant" value="{$cant}">
					{/if}

					{remarksbox type="warning" title="{tr}Warning{/tr}"}<em class='mandatory_note'>{tr}Fields marked with an * are mandatory.{/tr}</em>{/remarksbox}

					<table class="formcolor">
						<tr>
							<td colspan="2">
								{if count($fields) >= 5}
									<input type="submit" class="btn btn-default btn-sm" name="save" value="{tr}Save{/tr}" onclick="needToConfirm=false">
									{* --------------------------- to return to tracker list after saving --------- *}
									{if $canView}
										<input type="submit" class="btn btn-default btn-sm" name="save_return" value="{tr}Save{/tr} &amp; {tr}Back to Items list{/tr}" onclick="needToConfirm=false">
										{if $canRemove}
											<a class="link" href="tiki-view_tracker.php?trackerId={$trackerId}&amp;remove={$itemId}" title="{tr}Delete{/tr}">{icon _id='cross' alt="{tr}Delete{/tr}"}</a>
										{/if}
									{/if}
								{/if}
							</td>
						</tr>
						{* ------------------- *}
						{if $tracker_info.showStatus eq 'y' or ($tracker_info.showStatusAdminOnly eq 'y' and $tiki_p_admin_trackers eq 'y')}
							<tr>
								<td class="formlabel">{tr}Status{/tr}</td>
								<td class="formcontent">
									{include file='tracker_status_input.tpl' item=$item_info form_status=edstatus}
								</td>
							</tr>
						{/if}

						
						{* no template defined in the tracker *}
						{if empty($editItemPretty.value)}

							{foreach from=$ins_fields key=ix item=cur_field}
								<tr>
									<td>
										{$cur_field.name|tra}
										{if $cur_field.isMandatory eq 'y'}
											<em class='mandatory_star'>*</em>
										{/if}
									</td>
									<td>
										{trackerinput field=$cur_field item=$item_info inTable=formcolor showDescription=y}
									</td>
								</tr>
							{/foreach}

							{trackerheader level=-1 title='' inTable='formcolor'}

						{else}
						{* we have a preset template: it could be a wiki:myPage or a tpl:MyTpl.tpl *}
						{* Note: tracker plugin usally consumes a pagename or a tpl filename without a prefix of tpl: or wiki: as the tracker definition does *}
							<tr>
								<td colspan="4">
								{if $editItemPretty.type eq 'wiki'}
									{wikiplugin _name=tracker trackerId=$trackerId itemId=$itemId view=page wiki=$editItemPretty.value formtag='n'}{/wikiplugin}
								{else}
									{wikiplugin _name=tracker trackerId=$trackerId itemId=$itemId view=page tpl=$editItemPretty.value formtag='n'}{/wikiplugin}
								{/if}
								</td>
							</tr>
						{/if}

						{if $groupforalert ne ''}

							<tr>
								<td>{tr}Choose users to alert{/tr}</td>
								<td>
									{section name=idx loop=$listusertoalert}
										{if $showeachuser eq ''}
											<input type="hidden" name="listtoalert[]" value="{$listusertoalert[idx].user}">
										{else}
											<input type="checkbox" name="listtoalert[]" value="{$listusertoalert[idx].user}"> {$listusertoalert[idx].user}
										{/if}
									{/section}
								</td>
							</tr>
						{/if}


						{* -------------------- antibot code -------------------- *}
						{if $prefs.feature_antibot eq 'y' && $user eq ''}
							{include file='antibot.tpl'}
						{/if}
						<tr>
							<td colspan="2">
								<input type="submit" class="btn btn-default btn-sm" name="save" value="{tr}Save{/tr}" onclick="needToConfirm=false">
								{* --------------------------- to return to tracker list after saving --------- *}
								{if $canView}
									<input type="submit" class="btn btn-default btn-sm" name="save_return" value="{tr}Save{/tr} &amp; {tr}Back to Items List{/tr}" onclick="needToConfirm=false">
								{/if}
								{if $canRemove}
									<a class="link" href="tiki-view_tracker.php?trackerId={$trackerId}&amp;remove={$itemId}" title="{tr}Delete{/tr}">{icon _id='cross' alt="{tr}Delete{/tr}"}</a>
								{/if}
								{if $item_info.logs.cant}
									<a class="link" href="tiki-tracker_view_history.php?itemId={$itemId}" title="{tr}History{/tr}">{icon _id='database' alt="{tr}History{/tr}"}</a>
								{/if}
								{if $tiki_p_admin_trackers eq 'y' && empty($trackers)}
									<a class="link" href="tiki-view_tracker_item.php?itemId={$itemId}&moveto" title="{tr}Move to another tracker{/tr}">{icon _id='arrow_right' alt="{tr}Move to another tracker{/tr}"}</a>
								{/if}
							</td>
						</tr>
					</table>

					{* ------------------- *}
				</form>

				{foreach from=$ins_fields item=cur_field}
					{if $cur_field.type eq 'x'}
						{capture name=trkaction}
							<form action="{$cur_field.options_array[2]}" {if $cur_field.options_array[1] eq 'post'}method="post"{else}method="get"{/if}>
								{section name=tl loop=$cur_field.options_array start=3}
									{assign var=valvar value=$cur_field.options_array[tl]|regex_replace:"/^[^:]*:/":""|escape}
									{if $info.$valvar eq ''}
										{assign var=valvar value=$cur_field.options_array[tl]|regex_replace:"/^[^\=]*\=/":""|escape}
										<input type="hidden" name="{$cur_field.options_array[tl]|regex_replace:"/\=.*$/":""|escape}" value="{$valvar|escape}">
									{else}
										<input type="hidden" name="{$cur_field.options_array[tl]|regex_replace:"/:.*$/":""|escape}" value="{$info.$valvar|escape}">
									{/if}
								{/section}
								<table class="formcolor">
									<tr>
										<td>{$cur_field.name|tra}</td>
										<td><input type="submit" class="btn btn-default btn-sm" name="trck_act" value="{$cur_field.options_array[0]|escape}" ></td>
									<tr>
								</table>
							</form>
						{/capture}
						{assign var=trkact value=$trkact|cat:$smarty.capture.trkaction}
					{/if}
				{/foreach}
				{if $trkact}
					<h2>{tr}Special Operations{/tr}</h2>
					{$trkact}
				{/if}
			</div><!--nohighlight-->{*important comment to delimit the zone not to highlight in a search result*}
		{/tab}
	{/if}

{/tabset}

<br><br>

{if isset($print_page) && $print_page eq 'y'}
	{tr}The original document is available at{/tr} <a href="{$base_url|escape}{$itemId|sefurl:trackeritem}">{$base_url|escape}{$itemId|sefurl:trackeritem}</a>
{/if}
