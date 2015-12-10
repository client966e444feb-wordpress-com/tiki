<?php
// (c) Copyright 2002-2015 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

/**
 * Handler class for WebService
 * 
 * Letter key: ~W~
 *
 */
class Tracker_Field_WebService extends Tracker_Field_Abstract
{
	public static function getTypes()
	{
		return array(
			'W' => array(
				'name' => tr('Webservice'),
				'description' => tr('Displays the result of a registered webservice call.'),
				'readonly' => true,
				'help' => 'Webservice+tracker+field',				
				'prefs' => array('trackerfield_webservice', 'feature_webservices'),
				'tags' => array('advanced'),
				'default' => 'n',
				'params' => array(
					'service' => array(
						'name' => tr('Service Name'),
						'description' => tr('Webservice name as registered in Tiki.'),
						'filter' => 'word',
						'legacy_index' => 0,
					),
					'template' => array(
						'name' => tr('Template Name'),
						'description' => tr('Template name to use for rendering as registered with the webservice.'),
						'filter' => 'word',
						'legacy_index' => 1,
					),
					'params' => array(
						'name' => tr('Parameters'),
						'description' => tr('URL-encoded list of parameters to send to the webservice. %field_name% can be used in the string to be replaced with the values in the tracker item by field permName, Id or Name.'),
						'filter' => 'url',
						'legacy_index' => 2,
					),
				),
			),
		);
	}

	function getFieldData(array $requestData = array())
	{	
		return array();
	}

	function renderInput($context = array())
	{
		$this->renderOutput($context);	// read only
	}

	function renderOutput($context = array())
	{
			
		if (!$this->getOption('service') || !$this->getOption('template')) {
			return false;
		}
	
		require_once 'lib/webservicelib.php';

		if (!($webservice = Tiki_Webservice::getService($this->getOption('service')))  ||
			!($template = $webservice->getTemplate($this->getOption('template'))) ) {
				return false;
		}

		$ws_params = array();
		
		if ( $this->getOption('params') ) {
			parse_str($this->getOption('params'), $ws_params);
			foreach ($ws_params as $ws_param_name => &$ws_param_value) {
				if (preg_match('/(.*)%(.*)%(.*)/', $ws_param_value, $matches)) {
					$ws_param_field_name = $matches[2];

					$field = $this->getTrackerDefinition()->getField($ws_param_field_name);
					if (! $field) {
						$field = $this->getTrackerDefinition()->getFieldFromName($ws_param_field_name);
					}
					if ($field) {
						$value = TikiLib::lib('trk')->get_field_value($field, $this->getItemData());
						$ws_params[$ws_param_name] = preg_replace('/%' . $ws_param_field_name . '%/', $value, $ws_param_value);
					}
				}
			}
		}

		$response = $webservice->performRequest($ws_params);
		$output = $template->render($response, 'html');
					
		return $output;
	}
}
