<?php
// (c) Copyright 2002-2016 by authors of the Tiki Wiki CMS Groupware Project
//
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

namespace Tiki\MailIn\Action;
use Tiki\MailIn\Account;
use Tiki\MailIn\Source\Message;

interface FactoryInterface
{
	function createAction(Account $account, Message $message);
}
