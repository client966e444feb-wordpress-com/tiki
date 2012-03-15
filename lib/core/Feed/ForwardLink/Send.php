<?php
// (c) Copyright 2002-2012 by authors of the Tiki Wiki CMS Groupware Project
//
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

Class Feed_ForwardLink_Send
{
	var $type = "textlink";
	var $version = "0.1";
	
	static function add($item = array())
	{
		global $textlinkContribution;
		if (empty($textlinkContribution)) $textlinkContribution = array();
		array_push($textlinkContribution, (object)$item);
	}

	static function wikiView($args = array())
	{
		global $textlinkContribution;
		$me = new self();
		if (!empty($textlinkContribution)) {
			($me->send($textlinkContribution));
		}
	}

	static function send($items = array())
	{
		global $tikilib;

		$entry = array();
		$lastModif = 0;

		foreach ($items as $item) {
			if (empty($item->forwardLink->href)) continue;
			$item->forwardLink->href = str_replace(' ', '+', $item->forwardLink->href);

			$client = new Zend_Http_Client($item->forwardLink->href, array('timeout' => 60));

			$info = $tikilib->get_page_info($item->page);

			$entry[] = array(
				'textlink'=> $item->textlink,
				'forwardlink'=>$item->forwardLink
			);

			if ($info['lastModif'] > $lastModif)
				$lastModif = $info['lastModif'];
		}

		if (!empty($entry)) {
			$client->setParameterGet(array(
				'protocol'=> 'forwardlink',
				'contribution'=> json_encode(array(
					'version' => '1.0',
					'encoding' => 'UTF-8',
					'date'=> $lastModif,
					'feed' => array('type' => 'textlink', 'entry'=> $entry),
				)
			)));

			$response = $client->request(Zend_Http_Client::POST);
			$request = $client->getLastResponse();
			return $response->getBody();
		}
	}
}
