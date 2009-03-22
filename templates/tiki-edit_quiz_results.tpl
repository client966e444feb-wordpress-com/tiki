<!-- START of {$smarty.template} -->{title url="tiki-edit_quiz_results.php?quizId=$quizId"}{tr}Edit quiz results{/tr}{/title}

<div class="navbar">
	{button href="tiki-list_quizzes.php" _text="{tr}List Quizzes{/tr}"} 
	{button href="tiki-quiz_stats.php" _text="{tr}Quiz Stats{/tr}"}
	{button href="tiki-quiz_stats_quiz.php?quizId=$quizId" _text="{tr}This Quiz Stats{/tr}"}
	{button href="tiki-edit_quiz.php?quizId=$quizId" _text="{tr}Edit this Quiz{/tr}"} 
	{button href="tiki-edit_quiz.php" _text="{tr}Admin Quizzes{/tr}"}
</div>

<h2>
	{tr}Create/edit questions for quiz{/tr}: <a href="tiki-edit_quiz.php?quizId={$quiz_info.quizId}" class="pageTitle">{$quiz_info.name}</a>
</h2>

<form action="tiki-edit_quiz_results.php" method="post">
	<input type="hidden" name="quizId" value="{$quizId|escape}" />
	<input type="hidden" name="resultId" value="{$resultId|escape}" />
	<table class="normal">
		<tr>
			<td class="formcolor">{tr}From Points{/tr}:</td>
			<td class="formcolor">
				<input type="text" name="fromPoints" value="{$fromPoints|escape}" />
			</td>
		</tr>
		<tr>
			<td class="formcolor">
				{tr}To Points{/tr}:
			</td>
			<td class="formcolor">
				<input type="text" name="toPoints" value="{$toPoints|escape}" />
			</td>
		</tr>
		<tr>
			<td class="formcolor">
				{tr}Answer{/tr}:
			</td>
			<td class="formcolor">
				<textarea name="answer" rows="10" cols="40">{$answer|escape}</textarea>
			</td>
		</tr>
		<tr>
			<td class="formcolor">
				&nbsp;
			</td>
			<td class="formcolor">
				<input type="submit" name="save" value="{tr}Save{/tr}" />
			</td>
		</tr>
	</table>
</form>

<h2>{tr}Results{/tr}</h2>

<table class="findtable">
	<tr>
		<td class="findtable">{tr}Find{/tr}</td>
		<td class="findtable">
			<form method="get" action="tiki-edit_quiz_results.php">
				<input type="text" name="find" value="{$find|escape}" />
				<input type="submit" value="{tr}Find{/tr}" name="search" />
				<input type="hidden" name="sort_mode" value="{$sort_mode|escape}" />
				<input type="hidden" name="quizId" value="{$quizId|escape}" />
			</form>
		</td>
	</tr>
</table>

<table class="normal">
	<tr>
		<th>
			<a href="tiki-edit_quiz_results.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'fromPoints_desc'}fromPoints_asc{else}fromPoints_desc{/if}">{tr}From Points{/tr}</a>
		</th>
		<th>
			<a href="tiki-edit_quiz_results.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'toPoints_desc'}toPoints_asc{else}toPoints_desc{/if}">{tr}To Points{/tr}</a>
		</th>
		<th>
			<a href="tiki-edit_quiz_results.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'position_desc'}answer_asc{else}answer_desc{/if}">{tr}Answer{/tr}</a>
		</th>
		<th>{tr}Action{/tr}</th>
	</tr>
	{cycle values="odd,even" print=false}
	{section name=user loop=$channels}
		<tr>
			<td class="{cycle advance=false}">{$channels[user].fromPoints}</td>
			<td class="{cycle advance=false}">{$channels[user].toPoints}</td>
			<td class="{cycle advance=false}">{$channels[user].answer|truncate:230:"(...)":true}</td>
			<td class="{cycle}">
				<a class="link" href="tiki-edit_quiz_results.php?quizId={$quizId}&amp;offset={$offset}&amp;sort_mode={$sort_mode}&amp;resultId={$channels[user].resultId}">{icon _id='page_edit' alt='{tr}Edit{/tr}'}</a>
				<a class="link" href="tiki-edit_quiz_results.php?quizId={$quizId}&amp;offset={$offset}&amp;sort_mode={$sort_mode}&amp;remove={$channels[user].resultId}">{icon _id='cross' alt='{tr}Remove{/tr}'}</a>
			</td>
		</tr>
	{/section}
</table>

{pagination_links cant=$cant_pages step=$prefs.maxRecords offset=$offset}{/pagination_links}<!-- END of {$smarty.template} -->
