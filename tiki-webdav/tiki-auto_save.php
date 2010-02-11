<?php
// (c) Copyright 2002-2010 by authors of the Tiki Wiki/CMS/Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

// Called by FCKEditor and defined in setup_fckeditor.tpl - FCKConfig.ajaxAutoSaveTargetUrl

$inputConfiguration = array( array(
	'staticKeyFilters' => array(
		'editor_id' => 'alpha',
//		'data' => 'alpha',
//		'script' => 'alpha',
	),
) );

require_once('tiki-setup.php');

if ($prefs['feature_ajax'] != 'y' || $prefs['feature_ajax_autosave'] != 'y') {
	return;
}

require_once('lib/ajax/ajaxlib.php');

if (isset($_REQUEST['editor_id']) and isset($_REQUEST['data'])) {
	auto_save($_REQUEST['editor_id'],$_REQUEST['data'],$_REQUEST['script']);
	header( 'Content-Type:text/xml; charset=UTF-8' ) ;
	echo '<?xml version="1.0" encoding="UTF-8"?>';
	echo '<adapter command="draft">';
	echo '<result message="success" />';
	echo '</adapter>';
}
