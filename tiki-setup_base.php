<?php

// $Header: /cvsroot/tikiwiki/tiki/tiki-setup_base.php,v 1.29 2003-08-22 00:44:36 teedog Exp $

// Copyright (c) 2002-2003, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

//print("tiki-setup_base 1: before include setup.php: ".$tiki_timer->elapsed()."<br />");
require_once("setup.php");

//print("tiki-setup_base 2: before include tikilib.php: ".$tiki_timer->elapsed()."<br />");
require_once("lib/tikilib.php");

//print("tiki-setup_base 3: before rest of tiki-setup_base: ".$tiki_timer->elapsed()."<br />");
$tikilib = new TikiLib($dbTiki);
require_once("lib/userslib.php");
$userlib = new UsersLib($dbTiki);

// set session lifetime
$session_lifetime = $tikilib->get_preference('session_lifetime','0');
if ($session_lifetime > 0) {
    ini_set('session.gc_maxlifetime',$session_lifetime*60);
}

// is session data  stored in DB or in filesystem?
$session_db = $tikilib->get_preference('session_db','n');
if ($session_db == 'y') {
    include('db/local.php');
    $ADODB_SESSION_DRIVER=$db_tiki;
    $ADODB_SESSION_CONNECT=$host_tiki;
    $ADODB_SESSION_USER=$user_tiki;
    $ADODB_SESSION_PWD=$pass_tiki;
    $ADODB_SESSION_DB=$dbs_tiki;
    unset($db_tiki);
    unset($host_tiki);
    unset($user_tiki);
    unset($pass_tiki);
    unset($dbs_tiki);
    ini_set('session.save_handler','user');
    include('adodb-session.php');
}
session_start();

// check if the remember me feature is enabled
$rememberme = $tikilib->get_preference('rememberme', 'disabled');

// if remember me is enabled, check for cookie where auth hash is stored
// user gets logged in as the first user in the db with a matching hash
if ($rememberme != 'disabled') {
    if (isset($_COOKIE['tiki-user'])) {
        if (!isset($user)and !isset($_SESSION['user'])) {
            $user = $userlib->get_user_by_hash($_COOKIE['tiki-user']);

            $_SESSION['user'] = $user;
        }
    }
}

// check what auth metod is selected. default is for the 'tiki' to auth users
$auth_method = $tikilib->get_preference('auth_method', 'tiki');

// if the auth method is 'web site', look for the username in $_SERVER
if ($auth_method == 'ws') {
    if (isset($_SERVER['REMOTE_USER'])) {
        if ($userlib->user_exists($_SERVER['REMOTE_USER'])) {
            $_SESSION["user"] = $_SERVER['REMOTE_USER'];
        }
    }
}

// if the username is already saved in the session, pull it from there
if (isset($_SESSION["user"])) {
    $user = $_SESSION["user"];
} else {
    $user = NULL;
}

function tra($content) {
    global $lang_use_db;

    if ($lang_use_db != 'y') {
        global $lang;

        if ($content) {
            if (isset($lang[$content])) {
                return $lang[$content];
            } else {
                return $content;
            }
        }
    } else {
        global $tikilib;

        global $language;
        $query = "select tran from tiki_language where source='" . addslashes($content). "' and lang='" . $language . "'";
        $result = $tikilib->db->query($query);
        $res = $result->fetchRow(DB_FETCHMODE_ASSOC);

        if (!$res)
            return $content;

        if (!isset($res["tran"])) {
            global $record_untranslated;

            if ($record_untranslated == 'y') {
                $query = "insert into tiki_untranslated (source,lang) values('" . addslashes($content). "','" . $language . "')";

                //No eror checking here
                $tikilib->db->query($query);
            }

            return $content;
        }

        return $res["tran"];
    }
}

// function user_has_permission($user,$perm) 
$allperms = $userlib->get_permissions(0, -1, 'permName_desc', '', '');
$allperms = $allperms["data"];

foreach ($allperms as $vperm) {
    $perm = $vperm["permName"];

    if ($user != 'admin' && (!$user || !$userlib->user_has_permission($user, 'tiki_p_admin'))) {
        $$perm = 'n';

        $smarty->assign("$perm", 'n');
    } else {
        $$perm = 'y';

        $smarty->assign("$perm", 'y');
    }
}

// Permissions
// Get group permissions here
$perms = $userlib->get_user_permissions($user);

foreach ($perms as $perm) {
    //print("Asignando permiso global : $perm<br/>");
    $smarty->assign("$perm", 'y');

    $$perm = 'y';
}

// If the user can admin file galleries then assign all the file galleries permissions
if ($tiki_p_admin_file_galleries == 'y') {
    $perms = $userlib->get_permissions(0, -1, 'permName_desc', '', 'file galleries');

    foreach ($perms["data"] as $perm) {
        $perm = $perm["permName"];

        $smarty->assign("$perm", 'y');
        $$perm = 'y';
    }
}

if ($tiki_p_admin_workflow == 'y') {
    $perms = $userlib->get_permissions(0, -1, 'permName_desc', '', 'workflow');

    foreach ($perms["data"] as $perm) {
        $perm = $perm["permName"];

        $smarty->assign("$perm", 'y');
        $$perm = 'y';
    }
}

if ($tiki_p_admin_directory == 'y') {
    $perms = $userlib->get_permissions(0, -1, 'permName_desc', '', 'directory');

    foreach ($perms["data"] as $perm) {
        $perm = $perm["permName"];

        $smarty->assign("$perm", 'y');
        $$perm = 'y';
    }
}

if ($tiki_p_admin_charts == 'y') {
    $perms = $userlib->get_permissions(0, -1, 'permName_desc', '', 'charts');

    foreach ($perms["data"] as $perm) {
        $perm = $perm["permName"];

        $smarty->assign("$perm", 'y');
        $$perm = 'y';
    }
}

if ($tiki_p_blog_admin == 'y') {
    $perms = $userlib->get_permissions(0, -1, 'permName_desc', '', 'blogs');

    foreach ($perms["data"] as $perm) {
        $perm = $perm["permName"];

        $smarty->assign("$perm", 'y');
        $$perm = 'y';
    }
}

if ($tiki_p_admin_trackers == 'y') {
    $perms = $userlib->get_permissions(0, -1, 'permName_desc', '', 'trackers');

    foreach ($perms["data"] as $perm) {
        $perm = $perm["permName"];

        $smarty->assign("$perm", 'y');
        $$perm = 'y';
    }
}

if ($tiki_p_admin_galleries == 'y') {
    $perms = $userlib->get_permissions(0, -1, 'permName_desc', '', 'image galleries');

    foreach ($perms["data"] as $perm) {
        $perm = $perm["permName"];

        $smarty->assign("$perm", 'y');
        $$perm = 'y';
    }
}

if ($tiki_p_admin_forum == 'y') {
    $perms = $userlib->get_permissions(0, -1, 'permName_desc', '', 'forums');

    foreach ($perms["data"] as $perm) {
        $perm = $perm["permName"];

        $smarty->assign("$perm", 'y');
        $$perm = 'y';
    }
}

if ($tiki_p_admin_wiki == 'y') {
    $perms = $userlib->get_permissions(0, -1, 'permName_desc', '', 'wiki');

    foreach ($perms["data"] as $perm) {
        $perm = $perm["permName"];

        $smarty->assign("$perm", 'y');
        $$perm = 'y';
    }
}

if ($tiki_p_admin_faqs == 'y') {
    $perms = $userlib->get_permissions(0, -1, 'permName_desc', '', 'faqs');

    foreach ($perms["data"] as $perm) {
        $perm = $perm["permName"];

        $smarty->assign("$perm", 'y');
        $$perm = 'y';
    }
}

if ($tiki_p_admin_shoutbox == 'y') {
    $perms = $userlib->get_permissions(0, -1, 'permName_desc', '', 'shoutbox');

    foreach ($perms["data"] as $perm) {
        $perm = $perm["permName"];

        $smarty->assign("$perm", 'y');
        $$perm = 'y';
    }
}

if ($tiki_p_admin_quizzes == 'y') {
    $perms = $userlib->get_permissions(0, -1, 'permName_desc', '', 'quizzes');

    foreach ($perms["data"] as $perm) {
        $perm = $perm["permName"];

        $smarty->assign("$perm", 'y');
        $$perm = 'y';
    }
}

if ($tiki_p_admin_cms == 'y') {
    $perms = $userlib->get_permissions(0, -1, 'permName_desc', '', 'cms');

    foreach ($perms["data"] as $perm) {
        $perm = $perm["permName"];

        $smarty->assign("$perm", 'y');
        $$perm = 'y';
    }

    $perms = $userlib->get_permissions(0, -1, 'permName_desc', '', 'topics');

    foreach ($perms["data"] as $perm) {
        $perm = $perm["permName"];

        $smarty->assign("$perm", 'y');
        $$perm = 'y';
    }
}

$tikiIndex = $tikilib->get_preference("tikiIndex", 'tiki-index.php');

$style = $tikilib->get_preference("style", 'moreneat.css');
$smarty->assign('style', $style);

$slide_style = $tikilib->get_preference("slide_style", 'slidestyle.css');
$smarty->assign('slide_style', $slide_style);

$feature_userPreferences = $tikilib->get_preference("feature_userPreferences", 'n');
$change_language = $tikilib->get_preference("change_language", 'y');
$change_theme = $tikilib->get_preference("change_theme", 'y');

$language = $tikilib->get_preference('language', 'en');

/* This seems to be done in tiki-setup.php
if ($feature_userPreferences == 'y') {
    // Check for FEATURES for the user
    $user_style = $tikilib->get_preference("style", 'moreneat.css');

    if ($user) {
        if ($change_theme == 'y') {
            $user_style = $tikilib->get_user_preference($user, 'theme', $style);

            if ($user_style) {
                $style = $user_style;
            }
        }

        if ($change_language == 'y') {
            $user_language = $tikilib->get_user_preference($user, 'language', $language);

            if ($user_language) {
                $language = $user_language;
            }
        }
    }

    $smarty->assign('style', $style);
    $smarty->assign('language', $language);
}

$stlstl = explode('.', $style);
$style_base = $stlstl[0];
*/

// Fix IIS servers not setting what they should set (ay ay IIS, ay ay)
if (!isset($_SERVER['QUERY_STRING']))
    $_SERVER['QUERY_STRING'] = '';

if (!isset($_SERVER['REQUEST_URI']) || empty($_SERVER['REQUEST_URI'])) {
    $_SERVER['REQUEST_URI'] = $_SERVER['PHP_SELF'] . '/' . $_SERVER['QUERY_STRING'];
}

//really needed? (todo: check)
//if ($lang_use_db!='y') {
global $lang;
include_once('lang/' . $language . '/language.php');

//}

// added for wirtual hosting suport
if (!isset($tikidomain)) {
    $tikidomain = "";
} else {
    $tikidomain .= "/";
}

$smarty->assign("tikidomain", $tikidomain);

// Debug console open/close
$smarty->assign('debugconsole_style',
    isset($_COOKIE["debugconsole"]) && ($_COOKIE["debugconsole"] == 'o') ? 'display:block;' : 'display:none;');

?>
