<?php
// (c) Copyright 2002-2009 by authors of the Tiki Wiki/CMS/Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id: /cvsroot/tikiwiki/tiki/tiki-poll_form.php,v 1.18 2007-10-12 07:55:29 nyloth Exp $
$section = 'poll';
require_once ('tiki-setup.php');
require_once ('lib/tikilib.php'); // httpScheme()
include_once ('lib/polls/polllib.php');
if (!isset($polllib)) {
	$polllib = new PollLib;
}
if ($prefs['feature_polls'] != 'y') {
	$smarty->assign('msg', tra("This feature is disabled") . ": feature_polls");
	$smarty->display("error.tpl");
	die;
}
// Now check permissions to access this page
if ($tiki_p_vote_poll != 'y') {
	$smarty->assign('errortype', 401);
	$smarty->assign('msg', tra("Permission denied. You cannot view this page."));
	$smarty->display("error.tpl");
	die;
}
if (!isset($_REQUEST["pollId"])) {
	$smarty->assign('msg', tra("No poll indicated"));
	$smarty->display("error.tpl");
	die;
}
$poll_info = $polllib->get_poll($_REQUEST["pollId"]);
$options = $polllib->list_poll_options($_REQUEST["pollId"]);
$smarty->assign_by_ref('menu_info', $poll_info);
$smarty->assign_by_ref('channels', $options);
$smarty->assign('ownurl', $tikilib->httpPrefix() . $_SERVER["REQUEST_URI"]);
ask_ticket('poll-form');
// Display the template
$smarty->assign('title', $poll_info['title']);
$smarty->assign('mid', 'tiki-poll_form.tpl');
$smarty->display("tiki.tpl");
