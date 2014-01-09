{* $Id: layout_view.tpl 48366 2013-11-08 16:12:24Z lphuberdeau $ *}<!DOCTYPE html>
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="myModalLabel">{$title|escape}</h4>
		</div>
		<div class="modal-body">
			{block name=content}{/block}
			{block name=show_content}{/block}
			{if $headerlib}
				{$headerlib->output_js_config()}
				{$headerlib->output_js_files()}
				{$headerlib->output_js()}
			{/if}
			{if !empty($smarty.request.show_smarty_debug)}
				{debug}
			{/if}
		</div>
	</div>
</div>
