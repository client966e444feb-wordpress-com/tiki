<?php
/** 
 * @group integration
 */
class MembershipTest extends TikiTestCase
{

	protected $userlib;

	function setUp() {
		parent::setUp();
		global $cachelib;

		$this->userlib = new UsersLib();

		$cachelib->invalidate( 'grouplist' );

		$this->userlib->remove_user( 'membershiptest_a' );
		$this->userlib->remove_user( 'membershiptest_b' );
		$this->userlib->remove_user( 'membershiptest_c' );
		$this->userlib->remove_group( 'MembershipTest' );

		$cachelib->invalidate( 'grouplist' );

		$this->userlib->add_group( 'MembershipTest', '', '', 0, 0, '', '', 0, '', 0, 0, 'n', 45 );

		$this->userlib->add_user( 'membershiptest_a', 'abc', 'a@example.com' );
		$this->userlib->add_user( 'membershiptest_b', 'abc', 'a@example.com' );
		$this->userlib->add_user( 'membershiptest_c', 'abc', 'a@example.com' );

		$this->userlib->assign_user_to_group( 'membershiptest_a', 'MembershipTest' );
		$this->userlib->assign_user_to_group( 'membershiptest_b', 'MembershipTest' );
	}

	function tearDown() {
		parent::tearDown();
		$this->userlib->remove_user( 'membershiptest_a' );
		$this->userlib->remove_user( 'membershiptest_b' );
		$this->userlib->remove_user( 'membershiptest_c' );
		$this->userlib->remove_group( 'MembershipTest' );
	}

	function testExtendMembership() {
		
		$this->userlib->extend_membership( 'membershiptest_a', 'MembershipTest', 3 );

		$expect = $this->userlib->now + 45 * 2 * ( 3600 * 24 );

		$this->assertEquals( $expect, 
			$this->userlib->getOne( 'SELECT `created` FROM `users_usergroups` WHERE `userId` = ? AND `groupName` = "MembershipTest"',
				array( $this->userlib->get_user_id( 'membershiptest_a' ) )
			)
		);
		$this->assertEquals( $this->userlib->now, 
			$this->userlib->getOne( 'SELECT `created` FROM `users_usergroups` WHERE `userId` = ? AND `groupName` = "MembershipTest"',
				array( $this->userlib->get_user_id( 'membershiptest_b' ) )
			)
		);
	}

	function testExtendExpiredMembership() {
		$id = $this->userlib->get_user_id( 'membershiptest_b' );

		$this->userlib->query( 'UPDATE `users_usergroups` SET `created` = `created` - 12*3600 - 45*24*3600 WHERE `userId` = ?', array( $id ) );

		$this->userlib->extend_membership( 'membershiptest_b', 'MembershipTest', 2 );

		$expect = $this->userlib->now + 45 * ( 3600 * 24 );

		$this->assertEquals( $expect, 
			$this->userlib->getOne( 'SELECT `created` FROM `users_usergroups` WHERE `userId` = ? AND `groupName` = "MembershipTest"',
				array( $this->userlib->get_user_id( 'membershiptest_b' ) )
			)
		);
	}
}
