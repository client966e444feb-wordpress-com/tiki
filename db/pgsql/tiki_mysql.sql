-- MySQL dump 8.21
--
-- Host: localhost    Database: tiki
---------------------------------------------------------
-- Server version	3.23.49-log

--
-- Table structure for table 'galaxia_activities'
--

CREATE TABLE galaxia_activities (
  activityId int(14) NOT NULL auto_increment,
  name varchar(80) NOT NULL default '',
  normalized_name varchar(80) NOT NULL default '',
  pId int(14) NOT NULL default '0',
  type enum('start','end','split','switch','join','activity','standalone') NOT NULL default 'start',
  isAutoRouted char(1) NOT NULL default '',
  flowNum int(10) NOT NULL default '0',
  isInteractive char(1) NOT NULL default '',
  lastModif int(14) NOT NULL default '0',
  description text NOT NULL,
  PRIMARY KEY  (activityId)
) TYPE=MyISAM;

--
-- Table structure for table 'galaxia_activity_roles'
--

CREATE TABLE galaxia_activity_roles (
  activityId int(14) NOT NULL default '0',
  roleId int(14) NOT NULL default '0',
  PRIMARY KEY  (activityId,roleId)
) TYPE=MyISAM;

--
-- Table structure for table 'galaxia_instance_activities'
--

CREATE TABLE galaxia_instance_activities (
  instanceId int(14) NOT NULL default '0',
  activityId int(14) NOT NULL default '0',
  started int(14) NOT NULL default '0',
  ended int(14) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  status enum('running','completed') NOT NULL default 'running',
  PRIMARY KEY  (instanceId,activityId)
) TYPE=MyISAM;

--
-- Table structure for table 'galaxia_instance_comments'
--

CREATE TABLE galaxia_instance_comments (
  cId int(14) NOT NULL auto_increment,
  instanceId int(14) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  activityId int(14) NOT NULL default '0',
  hash varchar(32) NOT NULL default '',
  title varchar(250) NOT NULL default '',
  comment text NOT NULL,
  activity varchar(80) NOT NULL default '',
  timestamp int(14) NOT NULL default '0',
  PRIMARY KEY  (cId)
) TYPE=MyISAM;

--
-- Table structure for table 'galaxia_instances'
--

CREATE TABLE galaxia_instances (
  instanceId int(14) NOT NULL auto_increment,
  pId int(14) NOT NULL default '0',
  started int(14) NOT NULL default '0',
  owner varchar(200) NOT NULL default '',
  nextActivity int(14) NOT NULL default '0',
  nextUser varchar(200) NOT NULL default '',
  ended int(14) NOT NULL default '0',
  status enum('active','exception','aborted','completed') NOT NULL default 'active',
  properties longblob,
  PRIMARY KEY  (instanceId)
) TYPE=MyISAM;

--
-- Table structure for table 'galaxia_processes'
--

CREATE TABLE galaxia_processes (
  pId int(14) NOT NULL auto_increment,
  name varchar(80) NOT NULL default '',
  isValid char(1) NOT NULL default '',
  isActive char(1) NOT NULL default '',
  version varchar(12) NOT NULL default '',
  description text NOT NULL,
  lastModif int(14) NOT NULL default '0',
  normalized_name varchar(80) NOT NULL default '',
  PRIMARY KEY  (pId)
) TYPE=MyISAM;

--
-- Table structure for table 'galaxia_roles'
--

CREATE TABLE galaxia_roles (
  roleId int(14) NOT NULL auto_increment,
  pId int(14) NOT NULL default '0',
  lastModif int(14) NOT NULL default '0',
  name varchar(80) NOT NULL default '',
  description text NOT NULL,
  PRIMARY KEY  (roleId)
) TYPE=MyISAM;

--
-- Table structure for table 'galaxia_transitions'
--

CREATE TABLE galaxia_transitions (
  pId int(14) NOT NULL default '0',
  actFromId int(14) NOT NULL default '0',
  actToId int(14) NOT NULL default '0',
  PRIMARY KEY  (actFromId,actToId)
) TYPE=MyISAM;

--
-- Table structure for table 'galaxia_user_roles'
--

CREATE TABLE galaxia_user_roles (
  pId int(14) NOT NULL default '0',
  roleId int(14) NOT NULL auto_increment,
  user varchar(200) NOT NULL default '',
  PRIMARY KEY  (roleId,user)
) TYPE=MyISAM;

--
-- Table structure for table 'galaxia_workitems'
--

CREATE TABLE galaxia_workitems (
  itemId int(14) NOT NULL auto_increment,
  instanceId int(14) NOT NULL default '0',
  orderId int(14) NOT NULL default '0',
  activityId int(14) NOT NULL default '0',
  properties longblob,
  started int(14) NOT NULL default '0',
  ended int(14) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  PRIMARY KEY  (itemId)
) TYPE=MyISAM;

--
-- Table structure for table 'messu_messages'
--

CREATE TABLE messu_messages (
  msgId int(14) NOT NULL auto_increment,
  user varchar(200) NOT NULL default '',
  user_from varchar(200) NOT NULL default '',
  user_to text NOT NULL,
  user_cc text NOT NULL,
  user_bcc text NOT NULL,
  subject varchar(255) NOT NULL default '',
  body text NOT NULL,
  hash varchar(32) NOT NULL default '',
  date int(14) NOT NULL default '0',
  isRead char(1) NOT NULL default '',
  isReplied char(1) NOT NULL default '',
  isFlagged char(1) NOT NULL default '',
  priority int(2) NOT NULL default '0',
  PRIMARY KEY  (msgId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_actionlog'
--

CREATE TABLE tiki_actionlog (
  action varchar(255) NOT NULL default '',
  lastModif int(14) NOT NULL default '0',
  pageName varchar(160) NOT NULL default '',
  user varchar(200) NOT NULL default '',
  ip varchar(15) NOT NULL default '',
  comment varchar(200) NOT NULL default ''
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_articles'
--

CREATE TABLE tiki_articles (
  articleId int(8) NOT NULL auto_increment,
  title varchar(80) NOT NULL default '',
  authorName varchar(60) NOT NULL default '',
  topicId int(14) NOT NULL default '0',
  topicName varchar(40) NOT NULL default '',
  size int(12) NOT NULL default '0',
  useImage char(1) NOT NULL default '',
  image_name varchar(80) NOT NULL default '',
  image_type varchar(80) NOT NULL default '',
  image_size int(14) NOT NULL default '0',
  image_x int(4) NOT NULL default '0',
  image_y int(4) NOT NULL default '0',
  image_data longblob,
  publishDate int(14) NOT NULL default '0',
  created int(14) NOT NULL default '0',
  heading text NOT NULL,
  body text NOT NULL,
  hash varchar(32) NOT NULL default '',
  author varchar(200) NOT NULL default '',
  reads int(14) NOT NULL default '0',
  votes int(8) NOT NULL default '0',
  points int(14) NOT NULL default '0',
  type varchar(50) NOT NULL default '',
  rating decimal(4,2) NOT NULL default '0.00',
  isfloat char(1) NOT NULL default '',
  PRIMARY KEY  (articleId),
  KEY title (title),
  KEY heading (heading(255)),
  KEY body (body(255)),
  KEY reads (reads),
  FULLTEXT KEY ft (title,heading,body)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_banners'
--

CREATE TABLE tiki_banners (
  bannerId int(12) NOT NULL auto_increment,
  client varchar(200) NOT NULL default '',
  url varchar(255) NOT NULL default '',
  title varchar(255) NOT NULL default '',
  alt varchar(250) NOT NULL default '',
  which varchar(50) NOT NULL default '',
  imageData longblob,
  imageType varchar(200) NOT NULL default '',
  imageName varchar(100) NOT NULL default '',
  HTMLData text NOT NULL,
  fixedURLData varchar(255) NOT NULL default '',
  textData text NOT NULL,
  fromDate int(14) NOT NULL default '0',
  toDate int(14) NOT NULL default '0',
  useDates char(1) NOT NULL default '',
  mon char(1) NOT NULL default '',
  tue char(1) NOT NULL default '',
  wed char(1) NOT NULL default '',
  thu char(1) NOT NULL default '',
  fri char(1) NOT NULL default '',
  sat char(1) NOT NULL default '',
  sun char(1) NOT NULL default '',
  hourFrom varchar(4) NOT NULL default '',
  hourTo varchar(4) NOT NULL default '',
  created int(14) NOT NULL default '0',
  maxImpressions int(8) NOT NULL default '0',
  impressions int(8) NOT NULL default '0',
  clicks int(8) NOT NULL default '0',
  zone varchar(40) NOT NULL default '',
  PRIMARY KEY  (bannerId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_banning'
--

CREATE TABLE tiki_banning (
  banId int(12) NOT NULL auto_increment,
  mode enum('user','ip') NOT NULL default 'user',
  title varchar(200) NOT NULL default '',
  ip1 char(3) NOT NULL default '',
  ip2 char(3) NOT NULL default '',
  ip3 char(3) NOT NULL default '',
  ip4 char(3) NOT NULL default '',
  user varchar(200) NOT NULL default '',
  date_from timestamp(14) NOT NULL,
  date_to timestamp(14) NOT NULL,
  use_dates char(1) NOT NULL default '',
  created int(14) NOT NULL default '0',
  message text NOT NULL,
  PRIMARY KEY  (banId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_banning_sections'
--

CREATE TABLE tiki_banning_sections (
  banId int(12) NOT NULL default '0',
  section varchar(100) NOT NULL default '',
  PRIMARY KEY  (banId,section)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_blog_activity'
--

CREATE TABLE tiki_blog_activity (
  blogId int(8) NOT NULL default '0',
  day int(14) NOT NULL default '0',
  posts int(8) NOT NULL default '0',
  PRIMARY KEY  (blogId,day)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_blog_posts'
--

CREATE TABLE tiki_blog_posts (
  postId int(8) NOT NULL auto_increment,
  blogId int(8) NOT NULL default '0',
  data text NOT NULL,
  created int(14) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  trackbacks_to text NOT NULL,
  trackbacks_from text NOT NULL,
  title varchar(80) NOT NULL default '',
  PRIMARY KEY  (postId),
  KEY data (data(255)),
  KEY blogId (blogId),
  KEY created (created),
  FULLTEXT KEY ft (data)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_blog_posts_images'
--

CREATE TABLE tiki_blog_posts_images (
  imgId int(14) NOT NULL auto_increment,
  postId int(14) NOT NULL default '0',
  filename varchar(80) NOT NULL default '',
  filetype varchar(80) NOT NULL default '',
  filesize int(14) NOT NULL default '0',
  data longblob,
  PRIMARY KEY  (imgId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_blogs'
--

CREATE TABLE tiki_blogs (
  blogId int(8) NOT NULL auto_increment,
  created int(14) NOT NULL default '0',
  lastModif int(14) NOT NULL default '0',
  title varchar(200) NOT NULL default '',
  description text NOT NULL,
  user varchar(200) NOT NULL default '',
  public char(1) NOT NULL default '',
  posts int(8) NOT NULL default '0',
  maxPosts int(8) NOT NULL default '0',
  hits int(8) NOT NULL default '0',
  activity decimal(4,2) NOT NULL default '0.00',
  heading text NOT NULL,
  use_find char(1) NOT NULL default '',
  use_title char(1) NOT NULL default '',
  add_date char(1) NOT NULL default '',
  add_poster char(1) NOT NULL default '',
  allow_comments char(1) NOT NULL default '',
  PRIMARY KEY  (blogId),
  KEY title (title),
  KEY description (description(255)),
  KEY hits (hits),
  FULLTEXT KEY ft (title,description)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_calendar_categories'
--

CREATE TABLE tiki_calendar_categories (
  calcatId int(11) NOT NULL auto_increment,
  calendarId int(14) NOT NULL default '0',
  name varchar(255) NOT NULL default '',
  PRIMARY KEY  (calcatId),
  UNIQUE KEY catname (calendarId,name(16))
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_calendar_items'
--

CREATE TABLE tiki_calendar_items (
  calitemId int(14) NOT NULL auto_increment,
  calendarId int(14) NOT NULL default '0',
  start int(14) NOT NULL default '0',
  end int(14) NOT NULL default '0',
  locationId int(14) NOT NULL default '0',
  categoryId int(14) NOT NULL default '0',
  priority enum('1','2','3','4','5','6','7','8','9') NOT NULL default '1',
  status enum('0','1','2') NOT NULL default '0',
  url varchar(255) NOT NULL default '',
  lang char(2) NOT NULL default 'en',
  name varchar(255) NOT NULL default '',
  description blob,
  user varchar(40) NOT NULL default '',
  created int(14) NOT NULL default '0',
  lastmodif int(14) NOT NULL default '0',
  PRIMARY KEY  (calitemId),
  KEY calendarId (calendarId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_calendar_locations'
--

CREATE TABLE tiki_calendar_locations (
  callocId int(14) NOT NULL auto_increment,
  calendarId int(14) NOT NULL default '0',
  name varchar(255) NOT NULL default '',
  description blob,
  PRIMARY KEY  (callocId),
  UNIQUE KEY locname (calendarId,name(16))
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_calendar_roles'
--

CREATE TABLE tiki_calendar_roles (
  calitemId int(14) NOT NULL default '0',
  username varchar(40) NOT NULL default '',
  role enum('0','1','2','3','6') NOT NULL default '0',
  PRIMARY KEY  (calitemId,username(16),role)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_calendars'
--

CREATE TABLE tiki_calendars (
  calendarId int(14) NOT NULL auto_increment,
  name varchar(80) NOT NULL default '',
  description varchar(255) NOT NULL default '',
  user varchar(40) NOT NULL default '',
  customlocations enum('n','y') NOT NULL default 'n',
  customcategories enum('n','y') NOT NULL default 'n',
  customlanguages enum('n','y') NOT NULL default 'n',
  custompriorities enum('n','y') NOT NULL default 'n',
  customparticipants enum('n','y') NOT NULL default 'n',
  created int(14) NOT NULL default '0',
  lastmodif int(14) NOT NULL default '0',
  PRIMARY KEY  (calendarId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_categories'
--

CREATE TABLE tiki_categories (
  categId int(12) NOT NULL auto_increment,
  name varchar(100) NOT NULL default '',
  description varchar(250) NOT NULL default '',
  parentId int(12) NOT NULL default '0',
  hits int(8) NOT NULL default '0',
  PRIMARY KEY  (categId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_categorized_objects'
--

CREATE TABLE tiki_categorized_objects (
  catObjectId int(12) NOT NULL auto_increment,
  type varchar(50) NOT NULL default '',
  objId varchar(255) NOT NULL default '',
  description text NOT NULL,
  created int(14) NOT NULL default '0',
  name varchar(200) NOT NULL default '',
  href varchar(200) NOT NULL default '',
  hits int(8) NOT NULL default '0',
  PRIMARY KEY  (catObjectId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_category_objects'
--

CREATE TABLE tiki_category_objects (
  catObjectId int(12) NOT NULL default '0',
  categId int(12) NOT NULL default '0',
  PRIMARY KEY  (catObjectId,categId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_category_sites'
--

CREATE TABLE tiki_category_sites (
  categId int(10) NOT NULL default '0',
  siteId int(14) NOT NULL default '0',
  PRIMARY KEY  (categId,siteId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_chart_items'
--

CREATE TABLE tiki_chart_items (
  itemId int(14) NOT NULL auto_increment,
  title varchar(250) NOT NULL default '',
  description text NOT NULL,
  chartId int(14) NOT NULL default '0',
  created int(14) NOT NULL default '0',
  URL varchar(250) NOT NULL default '',
  votes int(14) NOT NULL default '0',
  points int(14) NOT NULL default '0',
  average decimal(4,2) NOT NULL default '0.00',
  PRIMARY KEY  (itemId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_charts'
--

CREATE TABLE tiki_charts (
  chartId int(14) NOT NULL auto_increment,
  title varchar(250) NOT NULL default '',
  description text NOT NULL,
  hits int(14) NOT NULL default '0',
  singleItemVotes char(1) NOT NULL default '',
  singleChartVotes char(1) NOT NULL default '',
  suggestions char(1) NOT NULL default '',
  autoValidate char(1) NOT NULL default '',
  topN int(6) NOT NULL default '0',
  maxVoteValue int(4) NOT NULL default '0',
  frequency int(14) NOT NULL default '0',
  showAverage char(1) NOT NULL default '',
  isActive char(1) NOT NULL default '',
  showVotes char(1) NOT NULL default '',
  useCookies char(1) NOT NULL default '',
  lastChart int(14) NOT NULL default '0',
  voteAgainAfter int(14) NOT NULL default '0',
  created int(14) NOT NULL default '0',
  hist int(12) NOT NULL default '0',
  PRIMARY KEY  (chartId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_charts_rankings'
--

CREATE TABLE tiki_charts_rankings (
  chartId int(14) NOT NULL default '0',
  itemId int(14) NOT NULL default '0',
  position int(14) NOT NULL default '0',
  timestamp int(14) NOT NULL default '0',
  lastPosition int(14) NOT NULL default '0',
  period int(14) NOT NULL default '0',
  rvotes int(14) NOT NULL default '0',
  raverage decimal(4,2) NOT NULL default '0.00',
  PRIMARY KEY  (chartId,itemId,period)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_charts_votes'
--

CREATE TABLE tiki_charts_votes (
  user varchar(200) NOT NULL default '',
  itemId int(14) NOT NULL default '0',
  timestamp int(14) NOT NULL default '0',
  chartId int(14) NOT NULL default '0',
  PRIMARY KEY  (user,itemId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_chat_channels'
--

CREATE TABLE tiki_chat_channels (
  channelId int(8) NOT NULL auto_increment,
  name varchar(30) NOT NULL default '',
  description varchar(250) NOT NULL default '',
  max_users int(8) NOT NULL default '0',
  mode char(1) NOT NULL default '',
  moderator varchar(200) NOT NULL default '',
  active char(1) NOT NULL default '',
  refresh int(6) NOT NULL default '0',
  PRIMARY KEY  (channelId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_chat_messages'
--

CREATE TABLE tiki_chat_messages (
  messageId int(8) NOT NULL auto_increment,
  channelId int(8) NOT NULL default '0',
  data varchar(255) NOT NULL default '',
  poster varchar(200) NOT NULL default 'anonymous',
  timestamp int(14) NOT NULL default '0',
  PRIMARY KEY  (messageId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_chat_users'
--

CREATE TABLE tiki_chat_users (
  nickname varchar(200) NOT NULL default '',
  channelId int(8) NOT NULL default '0',
  timestamp int(14) NOT NULL default '0',
  PRIMARY KEY  (nickname,channelId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_comments'
--

CREATE TABLE tiki_comments (
  threadId int(14) NOT NULL auto_increment,
  object varchar(32) NOT NULL default '',
  parentId int(14) NOT NULL default '0',
  userName varchar(200) NOT NULL default '',
  commentDate int(14) NOT NULL default '0',
  hits int(8) NOT NULL default '0',
  type char(1) NOT NULL default '',
  points decimal(8,2) NOT NULL default '0.00',
  votes int(8) NOT NULL default '0',
  average decimal(8,4) NOT NULL default '0.0000',
  title varchar(100) NOT NULL default '',
  data text NOT NULL,
  hash varchar(32) NOT NULL default '',
  summary varchar(240) NOT NULL default '',
  smiley varchar(80) NOT NULL default '',
  user_ip varchar(15) NOT NULL default '',
  PRIMARY KEY  (threadId),
  KEY title (title),
  KEY data (data(255)),
  KEY object (object),
  KEY hits (hits),
  FULLTEXT KEY ft (title,data)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_content'
--

CREATE TABLE tiki_content (
  contentId int(8) NOT NULL auto_increment,
  description text NOT NULL,
  PRIMARY KEY  (contentId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_content_templates'
--

CREATE TABLE tiki_content_templates (
  templateId int(10) NOT NULL auto_increment,
  content longblob,
  name varchar(200) NOT NULL default '',
  created int(14) NOT NULL default '0',
  PRIMARY KEY  (templateId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_content_templates_sections'
--

CREATE TABLE tiki_content_templates_sections (
  templateId int(10) NOT NULL default '0',
  section varchar(250) NOT NULL default '',
  PRIMARY KEY  (templateId,section)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_cookies'
--

CREATE TABLE tiki_cookies (
  cookieId int(10) NOT NULL auto_increment,
  cookie varchar(255) NOT NULL default '',
  PRIMARY KEY  (cookieId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_copyrights'
--

CREATE TABLE tiki_copyrights (
  copyrightId int(12) NOT NULL auto_increment,
  page varchar(200) NOT NULL default '',
  title varchar(200) NOT NULL default '',
  year int(11) NOT NULL default '0',
  authors varchar(200) NOT NULL default '',
  copyright_order int(11) NOT NULL default '0',
  userName varchar(200) NOT NULL default '',
  PRIMARY KEY  (copyrightId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_directory_categories'
--

CREATE TABLE tiki_directory_categories (
  categId int(10) NOT NULL auto_increment,
  parent int(10) NOT NULL default '0',
  name varchar(240) NOT NULL default '',
  description text NOT NULL,
  childrenType char(1) NOT NULL default '',
  sites int(10) NOT NULL default '0',
  viewableChildren int(4) NOT NULL default '0',
  allowSites char(1) NOT NULL default '',
  showCount char(1) NOT NULL default '',
  editorGroup varchar(200) NOT NULL default '',
  hits int(12) NOT NULL default '0',
  PRIMARY KEY  (categId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_directory_search'
--

CREATE TABLE tiki_directory_search (
  term varchar(250) NOT NULL default '',
  hits int(14) NOT NULL default '0',
  PRIMARY KEY  (term)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_directory_sites'
--

CREATE TABLE tiki_directory_sites (
  siteId int(14) NOT NULL auto_increment,
  name varchar(240) NOT NULL default '',
  description text NOT NULL,
  url varchar(255) NOT NULL default '',
  country varchar(255) NOT NULL default '',
  hits int(12) NOT NULL default '0',
  isValid char(1) NOT NULL default '',
  created int(14) NOT NULL default '0',
  lastModif int(14) NOT NULL default '0',
  cache longblob,
  cache_timestamp int(14) NOT NULL default '0',
  PRIMARY KEY  (siteId),
  FULLTEXT KEY ft (name,description)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_drawings'
--

CREATE TABLE tiki_drawings (
  drawId int(12) NOT NULL auto_increment,
  version int(8) NOT NULL default '0',
  name varchar(250) NOT NULL default '',
  filename_draw varchar(250) NOT NULL default '',
  filename_pad varchar(250) NOT NULL default '',
  timestamp int(14) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  PRIMARY KEY  (drawId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_dsn'
--

CREATE TABLE tiki_dsn (
  dsnId int(12) NOT NULL auto_increment,
  name varchar(20) NOT NULL default '',
  dsn varchar(255) NOT NULL default '',
  PRIMARY KEY  (dsnId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_eph'
--

CREATE TABLE tiki_eph (
  ephId int(12) NOT NULL auto_increment,
  title varchar(250) NOT NULL default '',
  isFile char(1) NOT NULL default '',
  filename varchar(250) NOT NULL default '',
  filetype varchar(250) NOT NULL default '',
  filesize varchar(250) NOT NULL default '',
  data longblob,
  textdata longblob,
  publish int(14) NOT NULL default '0',
  hits int(10) NOT NULL default '0',
  PRIMARY KEY  (ephId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_extwiki'
--

CREATE TABLE tiki_extwiki (
  extwikiId int(12) NOT NULL auto_increment,
  name varchar(20) NOT NULL default '',
  extwiki varchar(255) NOT NULL default '',
  PRIMARY KEY  (extwikiId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_faq_questions'
--

CREATE TABLE tiki_faq_questions (
  questionId int(10) NOT NULL auto_increment,
  faqId int(10) NOT NULL default '0',
  position int(4) NOT NULL default '0',
  question text NOT NULL,
  answer text NOT NULL,
  PRIMARY KEY  (questionId),
  KEY faqId (faqId),
  KEY question (question(255)),
  KEY answer (answer(255)),
  FULLTEXT KEY ft (question,answer)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_faqs'
--

CREATE TABLE tiki_faqs (
  faqId int(10) NOT NULL auto_increment,
  title varchar(200) NOT NULL default '',
  description text NOT NULL,
  created int(14) NOT NULL default '0',
  questions int(5) NOT NULL default '0',
  hits int(8) NOT NULL default '0',
  canSuggest char(1) NOT NULL default '',
  PRIMARY KEY  (faqId),
  KEY title (title),
  KEY description (description(255)),
  KEY hits (hits),
  FULLTEXT KEY ft (title,description),
  FULLTEXT KEY ft2 (description)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_featured_links'
--

CREATE TABLE tiki_featured_links (
  url varchar(200) NOT NULL default '',
  title varchar(40) NOT NULL default '',
  description text NOT NULL,
  hits int(8) NOT NULL default '0',
  position int(6) NOT NULL default '0',
  type char(1) NOT NULL default '',
  PRIMARY KEY  (url)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_file_galleries'
--

CREATE TABLE tiki_file_galleries (
  galleryId int(14) NOT NULL auto_increment,
  name varchar(80) NOT NULL default '',
  description text NOT NULL,
  created int(14) NOT NULL default '0',
  visible char(1) NOT NULL default '',
  lastModif int(14) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  hits int(14) NOT NULL default '0',
  votes int(8) NOT NULL default '0',
  points decimal(8,2) NOT NULL default '0.00',
  maxRows int(10) NOT NULL default '0',
  public char(1) NOT NULL default '',
  show_id char(1) NOT NULL default '',
  show_icon char(1) NOT NULL default '',
  show_name char(1) NOT NULL default '',
  show_size char(1) NOT NULL default '',
  show_description char(1) NOT NULL default '',
  max_desc int(8) NOT NULL default '0',
  show_created char(1) NOT NULL default '',
  show_dl char(1) NOT NULL default '',
  PRIMARY KEY  (galleryId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_files'
--

CREATE TABLE tiki_files (
  fileId int(14) NOT NULL auto_increment,
  galleryId int(14) NOT NULL default '0',
  name varchar(40) NOT NULL default '',
  description text NOT NULL,
  created int(14) NOT NULL default '0',
  filename varchar(80) NOT NULL default '',
  filesize int(14) NOT NULL default '0',
  filetype varchar(250) NOT NULL default '',
  data longblob,
  user varchar(200) NOT NULL default '',
  downloads int(14) NOT NULL default '0',
  votes int(8) NOT NULL default '0',
  points decimal(8,2) NOT NULL default '0.00',
  path varchar(255) NOT NULL default '',
  hash varchar(32) NOT NULL default '',
  reference_url varchar(250) NOT NULL default '',
  is_reference char(1) NOT NULL default '',
  PRIMARY KEY  (fileId),
  KEY name (name),
  KEY description (description(255)),
  KEY downloads (downloads),
  FULLTEXT KEY ft (name,description)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_forum_attachments'
--

CREATE TABLE tiki_forum_attachments (
  attId int(14) NOT NULL auto_increment,
  threadId int(14) NOT NULL default '0',
  qId int(14) NOT NULL default '0',
  forumId int(14) NOT NULL default '0',
  filename varchar(250) NOT NULL default '',
  filetype varchar(250) NOT NULL default '',
  filesize int(12) NOT NULL default '0',
  data longblob,
  dir varchar(200) NOT NULL default '',
  created int(14) NOT NULL default '0',
  path varchar(250) NOT NULL default '',
  PRIMARY KEY  (attId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_forum_reads'
--

CREATE TABLE tiki_forum_reads (
  user varchar(200) NOT NULL default '',
  threadId int(14) NOT NULL default '0',
  forumId int(14) NOT NULL default '0',
  timestamp int(14) NOT NULL default '0',
  PRIMARY KEY  (user,threadId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_forums'
--

CREATE TABLE tiki_forums (
  forumId int(8) NOT NULL auto_increment,
  name varchar(200) NOT NULL default '',
  description text NOT NULL,
  created int(14) NOT NULL default '0',
  lastPost int(14) NOT NULL default '0',
  threads int(8) NOT NULL default '0',
  comments int(8) NOT NULL default '0',
  controlFlood char(1) NOT NULL default '',
  floodInterval int(8) NOT NULL default '0',
  moderator varchar(200) NOT NULL default '',
  hits int(8) NOT NULL default '0',
  mail varchar(200) NOT NULL default '',
  useMail char(1) NOT NULL default '',
  usePruneUnreplied char(1) NOT NULL default '',
  pruneUnrepliedAge int(8) NOT NULL default '0',
  usePruneOld char(1) NOT NULL default '',
  pruneMaxAge int(8) NOT NULL default '0',
  topicsPerPage int(6) NOT NULL default '0',
  topicOrdering varchar(100) NOT NULL default '',
  threadOrdering varchar(100) NOT NULL default '',
  section varchar(200) NOT NULL default '',
  topics_list_replies char(1) NOT NULL default '',
  topics_list_reads char(1) NOT NULL default '',
  topics_list_pts char(1) NOT NULL default '',
  topics_list_lastpost char(1) NOT NULL default '',
  topics_list_author char(1) NOT NULL default '',
  vote_threads char(1) NOT NULL default '',
  moderator_group varchar(200) NOT NULL default '',
  approval_type varchar(20) NOT NULL default '',
  outbound_address char(1) NOT NULL default '',
  inbound_address char(1) NOT NULL default '',
  topic_smileys char(1) NOT NULL default '',
  ui_avatar char(1) NOT NULL default '',
  ui_flag char(1) NOT NULL default '',
  ui_posts char(1) NOT NULL default '',
  ui_email char(1) NOT NULL default '',
  ui_online char(1) NOT NULL default '',
  topic_summary char(1) NOT NULL default '',
  show_description char(1) NOT NULL default '',
  att varchar(80) NOT NULL default '',
  att_store varchar(4) NOT NULL default '',
  att_store_dir varchar(250) NOT NULL default '',
  att_max_size int(12) NOT NULL default '0',
  ui_level char(1) NOT NULL default '',
  forum_password varchar(32) NOT NULL default '',
  forum_use_password char(1) NOT NULL default '',
  inbound_pop_server varchar(250) NOT NULL default '',
  inbound_pop_port int(4) NOT NULL default '0',
  inbound_pop_user varchar(200) NOT NULL default '',
  inbound_pop_password varchar(80) NOT NULL default '',
  PRIMARY KEY  (forumId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_forums_queue'
--

CREATE TABLE tiki_forums_queue (
  qId int(14) NOT NULL auto_increment,
  object varchar(32) NOT NULL default '',
  parentId int(14) NOT NULL default '0',
  forumId int(14) NOT NULL default '0',
  timestamp int(14) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  title varchar(240) NOT NULL default '',
  data text NOT NULL,
  type varchar(60) NOT NULL default '',
  hash varchar(32) NOT NULL default '',
  topic_smiley varchar(80) NOT NULL default '',
  topic_title varchar(240) NOT NULL default '',
  summary varchar(240) NOT NULL default '',
  PRIMARY KEY  (qId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_forums_reported'
--

CREATE TABLE tiki_forums_reported (
  threadId int(12) NOT NULL default '0',
  forumId int(12) NOT NULL default '0',
  parentId int(12) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  timestamp int(14) NOT NULL default '0',
  reason varchar(250) NOT NULL default '',
  PRIMARY KEY  (threadId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_galleries'
--

CREATE TABLE tiki_galleries (
  galleryId int(14) NOT NULL auto_increment,
  name varchar(80) NOT NULL default '',
  description text NOT NULL,
  created int(14) NOT NULL default '0',
  lastModif int(14) NOT NULL default '0',
  visible char(1) NOT NULL default '',
  theme varchar(60) NOT NULL default '',
  user varchar(200) NOT NULL default '',
  hits int(14) NOT NULL default '0',
  maxRows int(10) NOT NULL default '0',
  rowImages int(10) NOT NULL default '0',
  thumbSizeX int(10) NOT NULL default '0',
  thumbSizeY int(10) NOT NULL default '0',
  public char(1) NOT NULL default '',
  PRIMARY KEY  (galleryId),
  KEY name (name),
  KEY description (description(255)),
  KEY hits (hits),
  FULLTEXT KEY ft (name,description)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_galleries_scales'
--

CREATE TABLE tiki_galleries_scales (
  galleryId int(14) NOT NULL default '0',
  xsize int(11) NOT NULL default '0',
  ysize int(11) NOT NULL default '0',
  PRIMARY KEY  (galleryId,xsize,ysize)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_games'
--

CREATE TABLE tiki_games (
  gameName varchar(200) NOT NULL default '',
  hits int(8) NOT NULL default '0',
  votes int(8) NOT NULL default '0',
  points int(8) NOT NULL default '0',
  PRIMARY KEY  (gameName)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_group_inclusion'
--

CREATE TABLE tiki_group_inclusion (
  groupName varchar(30) NOT NULL default '',
  includeGroup varchar(30) NOT NULL default '',
  PRIMARY KEY  (groupName,includeGroup)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_history'
--

CREATE TABLE tiki_history (
  pageName varchar(160) NOT NULL default '',
  version int(8) NOT NULL default '0',
  lastModif int(14) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  ip varchar(15) NOT NULL default '',
  comment varchar(200) NOT NULL default '',
  data longblob,
  description varchar(200) NOT NULL default '',
  PRIMARY KEY  (pageName,version)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_hotwords'
--

CREATE TABLE tiki_hotwords (
  word varchar(40) NOT NULL default '',
  url varchar(255) NOT NULL default '',
  PRIMARY KEY  (word)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_html_pages'
--

CREATE TABLE tiki_html_pages (
  pageName varchar(40) NOT NULL default '',
  content longblob,
  refresh int(10) NOT NULL default '0',
  type char(1) NOT NULL default '',
  created int(14) NOT NULL default '0',
  PRIMARY KEY  (pageName)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_html_pages_dynamic_zones'
--

CREATE TABLE tiki_html_pages_dynamic_zones (
  pageName varchar(40) NOT NULL default '',
  zone varchar(80) NOT NULL default '',
  type char(2) NOT NULL default '',
  content text NOT NULL,
  PRIMARY KEY  (pageName,zone)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_images'
--

CREATE TABLE tiki_images (
  imageId int(14) NOT NULL auto_increment,
  galleryId int(14) NOT NULL default '0',
  name varchar(40) NOT NULL default '',
  description text NOT NULL,
  created int(14) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  hits int(14) NOT NULL default '0',
  path varchar(255) NOT NULL default '',
  PRIMARY KEY  (imageId),
  KEY ti_gId (galleryId),
  KEY ti_cr (created),
  KEY ti_hi (hits),
  KEY ti_us (user),
  FULLTEXT KEY ft (name,description)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_images_data'
--

CREATE TABLE tiki_images_data (
  imageId int(14) NOT NULL default '0',
  xsize int(8) NOT NULL default '0',
  ysize int(8) NOT NULL default '0',
  type char(1) NOT NULL default '',
  filesize int(14) NOT NULL default '0',
  filetype varchar(80) NOT NULL default '',
  filename varchar(80) NOT NULL default '',
  data longblob,
  PRIMARY KEY  (imageId,xsize,ysize,type),
  KEY t_i_d_it (imageId,type)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_images_old'
--

CREATE TABLE tiki_images_old (
  imageId int(14) NOT NULL auto_increment,
  galleryId int(14) NOT NULL default '0',
  name varchar(40) NOT NULL default '',
  description text NOT NULL,
  created int(14) NOT NULL default '0',
  filename varchar(80) NOT NULL default '',
  filetype varchar(80) NOT NULL default '',
  filesize int(14) NOT NULL default '0',
  data longblob,
  xsize int(8) NOT NULL default '0',
  ysize int(8) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  t_data longblob,
  t_type varchar(30) NOT NULL default '',
  hits int(14) NOT NULL default '0',
  path varchar(255) NOT NULL default '',
  PRIMARY KEY  (imageId),
  KEY name (name),
  KEY description (description(255)),
  KEY hits (hits),
  FULLTEXT KEY ft (name,description)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_language'
--

CREATE TABLE tiki_language (
  source tinyblob NOT NULL,
  lang char(2) NOT NULL default '',
  tran tinyblob,
  PRIMARY KEY  (source(255),lang)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_languages'
--

CREATE TABLE tiki_languages (
  lang char(2) NOT NULL default '',
  language varchar(255) NOT NULL default '',
  PRIMARY KEY  (lang)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_link_cache'
--

CREATE TABLE tiki_link_cache (
  cacheId int(14) NOT NULL auto_increment,
  url varchar(250) NOT NULL default '',
  data longblob,
  refresh int(14) NOT NULL default '0',
  PRIMARY KEY  (cacheId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_links'
--

CREATE TABLE tiki_links (
  fromPage varchar(160) NOT NULL default '',
  toPage varchar(160) NOT NULL default '',
  PRIMARY KEY  (fromPage,toPage)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_live_support_events'
--

CREATE TABLE tiki_live_support_events (
  eventId int(14) NOT NULL auto_increment,
  reqId varchar(32) NOT NULL default '',
  type varchar(40) NOT NULL default '',
  seqId int(14) NOT NULL default '0',
  senderId varchar(32) NOT NULL default '',
  data text NOT NULL,
  timestamp int(14) NOT NULL default '0',
  PRIMARY KEY  (eventId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_live_support_message_comments'
--

CREATE TABLE tiki_live_support_message_comments (
  cId int(12) NOT NULL auto_increment,
  msgId int(12) NOT NULL default '0',
  data text NOT NULL,
  timestamp int(14) NOT NULL default '0',
  PRIMARY KEY  (cId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_live_support_messages'
--

CREATE TABLE tiki_live_support_messages (
  msgId int(12) NOT NULL auto_increment,
  data text NOT NULL,
  timestamp int(14) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  username varchar(200) NOT NULL default '',
  priority int(2) NOT NULL default '0',
  status char(1) NOT NULL default '',
  assigned_to varchar(200) NOT NULL default '',
  resolution varchar(100) NOT NULL default '',
  title varchar(200) NOT NULL default '',
  module int(4) NOT NULL default '0',
  email varchar(250) NOT NULL default '',
  PRIMARY KEY  (msgId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_live_support_modules'
--

CREATE TABLE tiki_live_support_modules (
  modId int(4) NOT NULL auto_increment,
  name varchar(90) NOT NULL default '',
  PRIMARY KEY  (modId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_live_support_operators'
--

CREATE TABLE tiki_live_support_operators (
  user varchar(200) NOT NULL default '',
  accepted_requests int(10) NOT NULL default '0',
  status varchar(20) NOT NULL default '',
  longest_chat int(10) NOT NULL default '0',
  shortest_chat int(10) NOT NULL default '0',
  average_chat int(10) NOT NULL default '0',
  last_chat int(14) NOT NULL default '0',
  time_online int(10) NOT NULL default '0',
  votes int(10) NOT NULL default '0',
  points int(10) NOT NULL default '0',
  status_since int(14) NOT NULL default '0',
  PRIMARY KEY  (user)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_live_support_requests'
--

CREATE TABLE tiki_live_support_requests (
  reqId varchar(32) NOT NULL default '',
  user varchar(200) NOT NULL default '',
  tiki_user varchar(200) NOT NULL default '',
  email varchar(200) NOT NULL default '',
  operator varchar(200) NOT NULL default '',
  operator_id varchar(32) NOT NULL default '',
  user_id varchar(32) NOT NULL default '',
  reason text NOT NULL,
  req_timestamp int(14) NOT NULL default '0',
  timestamp int(14) NOT NULL default '0',
  status varchar(40) NOT NULL default '',
  resolution varchar(40) NOT NULL default '',
  chat_started int(14) NOT NULL default '0',
  chat_ended int(14) NOT NULL default '0',
  PRIMARY KEY  (reqId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_mail_events'
--

CREATE TABLE tiki_mail_events (
  event varchar(200) NOT NULL default '',
  object varchar(200) NOT NULL default '',
  email varchar(200) NOT NULL default ''
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_mailin_accounts'
--

CREATE TABLE tiki_mailin_accounts (
  accountId int(12) NOT NULL auto_increment,
  user varchar(200) NOT NULL default '',
  account varchar(50) NOT NULL default '',
  pop varchar(255) NOT NULL default '',
  port int(4) NOT NULL default '0',
  username varchar(100) NOT NULL default '',
  pass varchar(100) NOT NULL default '',
  active char(1) NOT NULL default '',
  type varchar(40) NOT NULL default '',
  smtp varchar(255) NOT NULL default '',
  useAuth char(1) NOT NULL default '',
  smtpPort int(4) NOT NULL default '0',
  PRIMARY KEY  (accountId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_menu_languages'
--

CREATE TABLE tiki_menu_languages (
  menuId int(8) NOT NULL auto_increment,
  language char(2) NOT NULL default '',
  PRIMARY KEY  (menuId,language)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_menu_options'
--

CREATE TABLE tiki_menu_options (
  optionId int(8) NOT NULL auto_increment,
  menuId int(8) NOT NULL default '0',
  type char(1) NOT NULL default '',
  name varchar(20) NOT NULL default '',
  url varchar(255) NOT NULL default '',
  position int(4) NOT NULL default '0',
  PRIMARY KEY  (optionId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_menus'
--

CREATE TABLE tiki_menus (
  menuId int(8) NOT NULL auto_increment,
  name varchar(20) NOT NULL default '',
  description text NOT NULL,
  type char(1) NOT NULL default '',
  PRIMARY KEY  (menuId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_minical_events'
--

CREATE TABLE tiki_minical_events (
  user varchar(200) NOT NULL default '',
  eventId int(12) NOT NULL auto_increment,
  title varchar(250) NOT NULL default '',
  description text NOT NULL,
  start int(14) NOT NULL default '0',
  end int(14) NOT NULL default '0',
  security char(1) NOT NULL default '',
  duration int(3) NOT NULL default '0',
  topicId int(12) NOT NULL default '0',
  reminded char(1) NOT NULL default '',
  PRIMARY KEY  (eventId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_minical_topics'
--

CREATE TABLE tiki_minical_topics (
  user varchar(200) NOT NULL default '',
  topicId int(12) NOT NULL auto_increment,
  name varchar(250) NOT NULL default '',
  filename varchar(200) NOT NULL default '',
  filetype varchar(200) NOT NULL default '',
  filesize varchar(200) NOT NULL default '',
  data longblob,
  path varchar(250) NOT NULL default '',
  isIcon char(1) NOT NULL default '',
  PRIMARY KEY  (topicId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_modules'
--

CREATE TABLE tiki_modules (
  name varchar(200) NOT NULL default '',
  position char(1) NOT NULL default '',
  ord int(4) NOT NULL default '0',
  type char(1) NOT NULL default '',
  title varchar(40) NOT NULL default '',
  cache_time int(14) NOT NULL default '0',
  rows int(4) NOT NULL default '0',
  groups text NOT NULL,
  params varchar(250) NOT NULL default '',
  PRIMARY KEY  (name)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_newsletter_subscriptions'
--

CREATE TABLE tiki_newsletter_subscriptions (
  nlId int(12) NOT NULL default '0',
  email varchar(255) NOT NULL default '',
  code varchar(32) NOT NULL default '',
  valid char(1) NOT NULL default '',
  subscribed int(14) NOT NULL default '0',
  PRIMARY KEY  (nlId,email)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_newsletters'
--

CREATE TABLE tiki_newsletters (
  nlId int(12) NOT NULL auto_increment,
  name varchar(200) NOT NULL default '',
  description text NOT NULL,
  created int(14) NOT NULL default '0',
  lastSent int(14) NOT NULL default '0',
  editions int(10) NOT NULL default '0',
  users int(10) NOT NULL default '0',
  allowAnySub char(1) NOT NULL default '',
  frequency int(14) NOT NULL default '0',
  PRIMARY KEY  (nlId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_newsreader_marks'
--

CREATE TABLE tiki_newsreader_marks (
  user varchar(200) NOT NULL default '',
  serverId int(12) NOT NULL default '0',
  groupName varchar(255) NOT NULL default '',
  timestamp int(14) NOT NULL default '0',
  PRIMARY KEY  (user,serverId,groupName)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_newsreader_servers'
--

CREATE TABLE tiki_newsreader_servers (
  user varchar(200) NOT NULL default '',
  serverId int(12) NOT NULL auto_increment,
  server varchar(250) NOT NULL default '',
  port int(4) NOT NULL default '0',
  username varchar(200) NOT NULL default '',
  password varchar(200) NOT NULL default '',
  PRIMARY KEY  (serverId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_page_footnotes'
--

CREATE TABLE tiki_page_footnotes (
  user varchar(200) NOT NULL default '',
  pageName varchar(250) NOT NULL default '',
  data text NOT NULL,
  PRIMARY KEY  (user,pageName)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_pages'
--

CREATE TABLE tiki_pages (
  pageName varchar(160) NOT NULL default '',
  hits int(8) NOT NULL default '0',
  data text NOT NULL,
  lastModif int(14) NOT NULL default '0',
  comment varchar(200) NOT NULL default '',
  version int(8) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  ip varchar(15) NOT NULL default '',
  flag char(1) NOT NULL default '',
  points int(8) NOT NULL default '0',
  votes int(8) NOT NULL default '0',
  pageRank decimal(5,3) NOT NULL default '0.000',
  description varchar(200) NOT NULL default '',
  cache longblob,
  cache_timestamp int(14) NOT NULL default '0',
  creator varchar(200) NOT NULL default '',
  PRIMARY KEY  (pageName),
  KEY pageName (pageName),
  KEY data (data(255)),
  KEY pageRank (pageRank),
  FULLTEXT KEY ft (pageName,data)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_pageviews'
--

CREATE TABLE tiki_pageviews (
  day int(14) NOT NULL default '0',
  pageviews int(14) NOT NULL default '0',
  PRIMARY KEY  (day)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_poll_options'
--

CREATE TABLE tiki_poll_options (
  pollId int(8) NOT NULL default '0',
  optionId int(8) NOT NULL auto_increment,
  title varchar(200) NOT NULL default '',
  votes int(8) NOT NULL default '0',
  PRIMARY KEY  (optionId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_polls'
--

CREATE TABLE tiki_polls (
  pollId int(8) NOT NULL auto_increment,
  title varchar(200) NOT NULL default '',
  votes int(8) NOT NULL default '0',
  active char(1) NOT NULL default '',
  publishDate int(14) NOT NULL default '0',
  PRIMARY KEY  (pollId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_preferences'
--

CREATE TABLE tiki_preferences (
  name varchar(40) NOT NULL default '',
  value varchar(250) NOT NULL default '',
  PRIMARY KEY  (name)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_private_messages'
--

CREATE TABLE tiki_private_messages (
  messageId int(8) NOT NULL auto_increment,
  toNickname varchar(200) NOT NULL default '',
  data varchar(255) NOT NULL default '',
  poster varchar(200) NOT NULL default 'anonymous',
  timestamp int(14) NOT NULL default '0',
  PRIMARY KEY  (messageId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_programmed_content'
--

CREATE TABLE tiki_programmed_content (
  pId int(8) NOT NULL auto_increment,
  contentId int(8) NOT NULL default '0',
  publishDate int(14) NOT NULL default '0',
  data text NOT NULL,
  PRIMARY KEY  (pId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_quiz_question_options'
--

CREATE TABLE tiki_quiz_question_options (
  optionId int(10) NOT NULL auto_increment,
  questionId int(10) NOT NULL default '0',
  optionText text NOT NULL,
  points int(4) NOT NULL default '0',
  PRIMARY KEY  (optionId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_quiz_questions'
--

CREATE TABLE tiki_quiz_questions (
  questionId int(10) NOT NULL auto_increment,
  quizId int(10) NOT NULL default '0',
  question text NOT NULL,
  position int(4) NOT NULL default '0',
  type char(1) NOT NULL default '',
  maxPoints int(4) NOT NULL default '0',
  PRIMARY KEY  (questionId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_quiz_results'
--

CREATE TABLE tiki_quiz_results (
  resultId int(10) NOT NULL auto_increment,
  quizId int(10) NOT NULL default '0',
  fromPoints int(4) NOT NULL default '0',
  toPoints int(4) NOT NULL default '0',
  answer text NOT NULL,
  PRIMARY KEY  (resultId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_quiz_stats'
--

CREATE TABLE tiki_quiz_stats (
  quizId int(10) NOT NULL default '0',
  questionId int(10) NOT NULL default '0',
  optionId int(10) NOT NULL default '0',
  votes int(10) NOT NULL default '0',
  PRIMARY KEY  (quizId,questionId,optionId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_quiz_stats_sum'
--

CREATE TABLE tiki_quiz_stats_sum (
  quizId int(10) NOT NULL default '0',
  quizName varchar(255) NOT NULL default '',
  timesTaken int(10) NOT NULL default '0',
  avgpoints decimal(5,2) NOT NULL default '0.00',
  avgavg decimal(5,2) NOT NULL default '0.00',
  avgtime decimal(5,2) NOT NULL default '0.00',
  PRIMARY KEY  (quizId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_quizzes'
--

CREATE TABLE tiki_quizzes (
  quizId int(10) NOT NULL auto_increment,
  name varchar(255) NOT NULL default '',
  description text NOT NULL,
  canRepeat char(1) NOT NULL default '',
  storeResults char(1) NOT NULL default '',
  questionsPerPage int(4) NOT NULL default '0',
  timeLimited char(1) NOT NULL default '',
  timeLimit int(14) NOT NULL default '0',
  created int(14) NOT NULL default '0',
  taken int(10) NOT NULL default '0',
  PRIMARY KEY  (quizId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_received_articles'
--

CREATE TABLE tiki_received_articles (
  receivedArticleId int(14) NOT NULL auto_increment,
  receivedFromSite varchar(200) NOT NULL default '',
  receivedFromUser varchar(200) NOT NULL default '',
  receivedDate int(14) NOT NULL default '0',
  title varchar(80) NOT NULL default '',
  authorName varchar(60) NOT NULL default '',
  size int(12) NOT NULL default '0',
  useImage char(1) NOT NULL default '',
  image_name varchar(80) NOT NULL default '',
  image_type varchar(80) NOT NULL default '',
  image_size int(14) NOT NULL default '0',
  image_x int(4) NOT NULL default '0',
  image_y int(4) NOT NULL default '0',
  image_data longblob,
  publishDate int(14) NOT NULL default '0',
  created int(14) NOT NULL default '0',
  heading text NOT NULL,
  body longblob,
  hash varchar(32) NOT NULL default '',
  author varchar(200) NOT NULL default '',
  type varchar(50) NOT NULL default '',
  rating decimal(4,2) NOT NULL default '0.00',
  PRIMARY KEY  (receivedArticleId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_received_pages'
--

CREATE TABLE tiki_received_pages (
  receivedPageId int(14) NOT NULL auto_increment,
  pageName varchar(160) NOT NULL default '',
  data longblob,
  comment varchar(200) NOT NULL default '',
  receivedFromSite varchar(200) NOT NULL default '',
  receivedFromUser varchar(200) NOT NULL default '',
  receivedDate int(14) NOT NULL default '0',
  description varchar(200) NOT NULL default '',
  PRIMARY KEY  (receivedPageId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_referer_stats'
--

CREATE TABLE tiki_referer_stats (
  referer varchar(50) NOT NULL default '',
  hits int(10) NOT NULL default '0',
  last int(14) NOT NULL default '0',
  PRIMARY KEY  (referer)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_related_categories'
--

CREATE TABLE tiki_related_categories (
  categId int(10) NOT NULL default '0',
  relatedTo int(10) NOT NULL default '0',
  PRIMARY KEY  (categId,relatedTo)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_rss_modules'
--

CREATE TABLE tiki_rss_modules (
  rssId int(8) NOT NULL auto_increment,
  name varchar(30) NOT NULL default '',
  description text NOT NULL,
  url varchar(255) NOT NULL default '',
  refresh int(8) NOT NULL default '0',
  lastUpdated int(14) NOT NULL default '0',
  content longblob,
  PRIMARY KEY  (rssId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_search_stats'
--

CREATE TABLE tiki_search_stats (
  term varchar(50) NOT NULL default '',
  hits int(10) NOT NULL default '0',
  PRIMARY KEY  (term)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_semaphores'
--

CREATE TABLE tiki_semaphores (
  semName varchar(30) NOT NULL default '',
  timestamp int(14) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  PRIMARY KEY  (semName)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_sent_newsletters'
--

CREATE TABLE tiki_sent_newsletters (
  editionId int(12) NOT NULL auto_increment,
  nlId int(12) NOT NULL default '0',
  users int(10) NOT NULL default '0',
  sent int(14) NOT NULL default '0',
  subject varchar(200) NOT NULL default '',
  data longblob,
  PRIMARY KEY  (editionId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_sessions'
--

CREATE TABLE tiki_sessions (
  sessionId varchar(32) NOT NULL default '',
  timestamp int(14) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  PRIMARY KEY  (sessionId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_shoutbox'
--

CREATE TABLE tiki_shoutbox (
  msgId int(10) NOT NULL auto_increment,
  message varchar(255) NOT NULL default '',
  timestamp int(14) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  hash varchar(32) NOT NULL default '',
  PRIMARY KEY  (msgId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_structures'
--

CREATE TABLE tiki_structures (
  page varchar(240) NOT NULL default '',
  parent varchar(240) NOT NULL default '',
  pos int(4) NOT NULL default '0',
  PRIMARY KEY  (page,parent)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_submissions'
--

CREATE TABLE tiki_submissions (
  subId int(8) NOT NULL auto_increment,
  title varchar(80) NOT NULL default '',
  authorName varchar(60) NOT NULL default '',
  topicId int(14) NOT NULL default '0',
  topicName varchar(40) NOT NULL default '',
  size int(12) NOT NULL default '0',
  useImage char(1) NOT NULL default '',
  image_name varchar(80) NOT NULL default '',
  image_type varchar(80) NOT NULL default '',
  image_size int(14) NOT NULL default '0',
  image_x int(4) NOT NULL default '0',
  image_y int(4) NOT NULL default '0',
  image_data longblob,
  publishDate int(14) NOT NULL default '0',
  created int(14) NOT NULL default '0',
  heading text NOT NULL,
  body longblob,
  hash varchar(32) NOT NULL default '',
  author varchar(200) NOT NULL default '',
  reads int(14) NOT NULL default '0',
  votes int(8) NOT NULL default '0',
  points int(14) NOT NULL default '0',
  type varchar(50) NOT NULL default '',
  rating decimal(4,2) NOT NULL default '0.00',
  isfloat char(1) NOT NULL default '',
  PRIMARY KEY  (subId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_suggested_faq_questions'
--

CREATE TABLE tiki_suggested_faq_questions (
  sfqId int(10) NOT NULL auto_increment,
  faqId int(10) NOT NULL default '0',
  question text NOT NULL,
  answer text NOT NULL,
  created int(14) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  PRIMARY KEY  (sfqId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_survey_question_options'
--

CREATE TABLE tiki_survey_question_options (
  optionId int(12) NOT NULL auto_increment,
  questionId int(12) NOT NULL default '0',
  qoption text NOT NULL,
  votes int(10) NOT NULL default '0',
  PRIMARY KEY  (optionId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_survey_questions'
--

CREATE TABLE tiki_survey_questions (
  questionId int(12) NOT NULL auto_increment,
  surveyId int(12) NOT NULL default '0',
  question text NOT NULL,
  options text NOT NULL,
  type char(1) NOT NULL default '',
  position int(5) NOT NULL default '0',
  votes int(10) NOT NULL default '0',
  value int(10) NOT NULL default '0',
  average decimal(4,2) NOT NULL default '0.00',
  PRIMARY KEY  (questionId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_surveys'
--

CREATE TABLE tiki_surveys (
  surveyId int(12) NOT NULL auto_increment,
  name varchar(200) NOT NULL default '',
  description text NOT NULL,
  taken int(10) NOT NULL default '0',
  lastTaken int(14) NOT NULL default '0',
  created int(14) NOT NULL default '0',
  status char(1) NOT NULL default '',
  PRIMARY KEY  (surveyId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_tags'
--

CREATE TABLE tiki_tags (
  tagName varchar(80) NOT NULL default '',
  pageName varchar(160) NOT NULL default '',
  hits int(8) NOT NULL default '0',
  data longblob,
  lastModif int(14) NOT NULL default '0',
  comment varchar(200) NOT NULL default '',
  version int(8) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  ip varchar(15) NOT NULL default '',
  flag char(1) NOT NULL default '',
  description varchar(200) NOT NULL default '',
  PRIMARY KEY  (tagName,pageName)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_theme_control_categs'
--

CREATE TABLE tiki_theme_control_categs (
  categId int(12) NOT NULL default '0',
  theme varchar(250) NOT NULL default '',
  PRIMARY KEY  (categId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_theme_control_objects'
--

CREATE TABLE tiki_theme_control_objects (
  objId varchar(250) NOT NULL default '',
  type varchar(250) NOT NULL default '',
  name varchar(250) NOT NULL default '',
  theme varchar(250) NOT NULL default '',
  PRIMARY KEY  (objId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_theme_control_sections'
--

CREATE TABLE tiki_theme_control_sections (
  section varchar(250) NOT NULL default '',
  theme varchar(250) NOT NULL default '',
  PRIMARY KEY  (section)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_topics'
--

CREATE TABLE tiki_topics (
  topicId int(14) NOT NULL auto_increment,
  name varchar(40) NOT NULL default '',
  image_name varchar(80) NOT NULL default '',
  image_type varchar(80) NOT NULL default '',
  image_size int(14) NOT NULL default '0',
  image_data longblob,
  active char(1) NOT NULL default '',
  created int(14) NOT NULL default '0',
  PRIMARY KEY  (topicId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_tracker_fields'
--

CREATE TABLE tiki_tracker_fields (
  fieldId int(12) NOT NULL auto_increment,
  trackerId int(12) NOT NULL default '0',
  name varchar(80) NOT NULL default '',
  options text NOT NULL,
  type char(1) NOT NULL default '',
  isMain char(1) NOT NULL default '',
  isTblVisible char(1) NOT NULL default '',
  PRIMARY KEY  (fieldId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_tracker_item_attachments'
--

CREATE TABLE tiki_tracker_item_attachments (
  attId int(12) NOT NULL auto_increment,
  itemId varchar(40) NOT NULL default '',
  filename varchar(80) NOT NULL default '',
  filetype varchar(80) NOT NULL default '',
  filesize int(14) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  data longblob,
  path varchar(255) NOT NULL default '',
  downloads int(10) NOT NULL default '0',
  created int(14) NOT NULL default '0',
  comment varchar(250) NOT NULL default '',
  PRIMARY KEY  (attId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_tracker_item_comments'
--

CREATE TABLE tiki_tracker_item_comments (
  commentId int(12) NOT NULL auto_increment,
  itemId int(12) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  data text NOT NULL,
  title varchar(200) NOT NULL default '',
  posted int(14) NOT NULL default '0',
  PRIMARY KEY  (commentId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_tracker_item_fields'
--

CREATE TABLE tiki_tracker_item_fields (
  itemId int(12) NOT NULL default '0',
  fieldId int(12) NOT NULL default '0',
  value text NOT NULL,
  PRIMARY KEY  (itemId,fieldId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_tracker_items'
--

CREATE TABLE tiki_tracker_items (
  itemId int(12) NOT NULL auto_increment,
  trackerId int(12) NOT NULL default '0',
  created int(14) NOT NULL default '0',
  status char(1) NOT NULL default '',
  lastModif int(14) NOT NULL default '0',
  PRIMARY KEY  (itemId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_trackers'
--

CREATE TABLE tiki_trackers (
  trackerId int(12) NOT NULL auto_increment,
  name varchar(80) NOT NULL default '',
  description text NOT NULL,
  created int(14) NOT NULL default '0',
  lastModif int(14) NOT NULL default '0',
  showCreated char(1) NOT NULL default '',
  showStatus char(1) NOT NULL default '',
  showLastModif char(1) NOT NULL default '',
  useComments char(1) NOT NULL default '',
  useAttachments char(1) NOT NULL default '',
  items int(10) NOT NULL default '0',
  PRIMARY KEY  (trackerId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_untranslated'
--

CREATE TABLE tiki_untranslated (
  id int(14) NOT NULL auto_increment,
  source tinyblob NOT NULL,
  lang char(2) NOT NULL default '',
  PRIMARY KEY  (source(255),lang),
  UNIQUE KEY id (id),
  KEY id_2 (id)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_user_answers'
--

CREATE TABLE tiki_user_answers (
  userResultId int(10) NOT NULL default '0',
  quizId int(10) NOT NULL default '0',
  questionId int(10) NOT NULL default '0',
  optionId int(10) NOT NULL default '0',
  PRIMARY KEY  (userResultId,quizId,questionId,optionId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_user_assigned_modules'
--

CREATE TABLE tiki_user_assigned_modules (
  name varchar(200) NOT NULL default '',
  position char(1) NOT NULL default '',
  ord int(4) NOT NULL default '0',
  type char(1) NOT NULL default '',
  title varchar(40) NOT NULL default '',
  cache_time int(14) NOT NULL default '0',
  rows int(4) NOT NULL default '0',
  groups text NOT NULL,
  user varchar(200) NOT NULL default '',
  PRIMARY KEY  (name,user)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_user_bookmarks_folders'
--

CREATE TABLE tiki_user_bookmarks_folders (
  folderId int(12) NOT NULL auto_increment,
  parentId int(12) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  name varchar(30) NOT NULL default '',
  PRIMARY KEY  (user,folderId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_user_bookmarks_urls'
--

CREATE TABLE tiki_user_bookmarks_urls (
  urlId int(12) NOT NULL auto_increment,
  name varchar(30) NOT NULL default '',
  url varchar(250) NOT NULL default '',
  data longblob,
  lastUpdated int(14) NOT NULL default '0',
  folderId int(12) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  PRIMARY KEY  (urlId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_user_mail_accounts'
--

CREATE TABLE tiki_user_mail_accounts (
  accountId int(12) NOT NULL auto_increment,
  user varchar(200) NOT NULL default '',
  account varchar(50) NOT NULL default '',
  pop varchar(255) NOT NULL default '',
  current char(1) NOT NULL default '',
  port int(4) NOT NULL default '0',
  username varchar(100) NOT NULL default '',
  pass varchar(100) NOT NULL default '',
  msgs int(4) NOT NULL default '0',
  smtp varchar(255) NOT NULL default '',
  useAuth char(1) NOT NULL default '',
  smtpPort int(4) NOT NULL default '0',
  PRIMARY KEY  (accountId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_user_menus'
--

CREATE TABLE tiki_user_menus (
  user varchar(200) NOT NULL default '',
  menuId int(12) NOT NULL auto_increment,
  url varchar(250) NOT NULL default '',
  name varchar(40) NOT NULL default '',
  position int(4) NOT NULL default '0',
  mode char(1) NOT NULL default '',
  PRIMARY KEY  (menuId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_user_modules'
--

CREATE TABLE tiki_user_modules (
  name varchar(200) NOT NULL default '',
  title varchar(40) NOT NULL default '',
  data longblob,
  PRIMARY KEY  (name)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_user_notes'
--

CREATE TABLE tiki_user_notes (
  user varchar(200) NOT NULL default '',
  noteId int(12) NOT NULL auto_increment,
  created int(14) NOT NULL default '0',
  name varchar(255) NOT NULL default '',
  lastModif int(14) NOT NULL default '0',
  data text NOT NULL,
  size int(14) NOT NULL default '0',
  parse_mode varchar(20) NOT NULL default '',
  PRIMARY KEY  (noteId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_user_postings'
--

CREATE TABLE tiki_user_postings (
  user varchar(200) NOT NULL default '',
  posts int(12) NOT NULL default '0',
  last int(14) NOT NULL default '0',
  first int(14) NOT NULL default '0',
  level int(8) NOT NULL default '0',
  PRIMARY KEY  (user)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_user_preferences'
--

CREATE TABLE tiki_user_preferences (
  user varchar(200) NOT NULL default '',
  prefName varchar(40) NOT NULL default '',
  value varchar(250) NOT NULL default '',
  PRIMARY KEY  (user,prefName)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_user_quizzes'
--

CREATE TABLE tiki_user_quizzes (
  user varchar(100) NOT NULL default '',
  quizId int(10) NOT NULL default '0',
  timestamp int(14) NOT NULL default '0',
  timeTaken int(14) NOT NULL default '0',
  points int(12) NOT NULL default '0',
  maxPoints int(12) NOT NULL default '0',
  resultId int(10) NOT NULL default '0',
  userResultId int(10) NOT NULL auto_increment,
  PRIMARY KEY  (userResultId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_user_taken_quizzes'
--

CREATE TABLE tiki_user_taken_quizzes (
  user varchar(200) NOT NULL default '',
  quizId varchar(255) NOT NULL default '',
  PRIMARY KEY  (user,quizId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_user_tasks'
--

CREATE TABLE tiki_user_tasks (
  user varchar(200) NOT NULL default '',
  taskId int(14) NOT NULL auto_increment,
  title varchar(250) NOT NULL default '',
  description text NOT NULL,
  date int(14) NOT NULL default '0',
  status char(1) NOT NULL default '',
  priority int(2) NOT NULL default '0',
  completed int(14) NOT NULL default '0',
  percentage int(4) NOT NULL default '0',
  PRIMARY KEY  (taskId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_user_votings'
--

CREATE TABLE tiki_user_votings (
  user varchar(200) NOT NULL default '',
  id varchar(255) NOT NULL default '',
  PRIMARY KEY  (user,id)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_user_watches'
--

CREATE TABLE tiki_user_watches (
  user varchar(200) NOT NULL default '',
  event varchar(40) NOT NULL default '',
  object varchar(200) NOT NULL default '',
  hash varchar(32) NOT NULL default '',
  title varchar(250) NOT NULL default '',
  type varchar(200) NOT NULL default '',
  url varchar(250) NOT NULL default '',
  email varchar(200) NOT NULL default '',
  PRIMARY KEY  (user,event,object)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_userfiles'
--

CREATE TABLE tiki_userfiles (
  user varchar(200) NOT NULL default '',
  fileId int(12) NOT NULL auto_increment,
  name varchar(200) NOT NULL default '',
  filename varchar(200) NOT NULL default '',
  filetype varchar(200) NOT NULL default '',
  filesize varchar(200) NOT NULL default '',
  data longblob,
  hits int(8) NOT NULL default '0',
  isFile char(1) NOT NULL default '',
  path varchar(255) NOT NULL default '',
  created int(14) NOT NULL default '0',
  PRIMARY KEY  (fileId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_userpoints'
--

CREATE TABLE tiki_userpoints (
  user varchar(200) NOT NULL default '',
  points decimal(8,2) NOT NULL default '0.00',
  voted int(8) NOT NULL default '0'
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_users'
--

CREATE TABLE tiki_users (
  user varchar(200) NOT NULL default '',
  password varchar(40) NOT NULL default '',
  email varchar(200) NOT NULL default '',
  lastLogin int(14) NOT NULL default '0',
  PRIMARY KEY  (user)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_webmail_contacts'
--

CREATE TABLE tiki_webmail_contacts (
  contactId int(12) NOT NULL auto_increment,
  firstName varchar(80) NOT NULL default '',
  lastName varchar(80) NOT NULL default '',
  email varchar(250) NOT NULL default '',
  nickname varchar(200) NOT NULL default '',
  user varchar(200) NOT NULL default '',
  PRIMARY KEY  (contactId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_webmail_messages'
--

CREATE TABLE tiki_webmail_messages (
  accountId int(12) NOT NULL default '0',
  mailId varchar(255) NOT NULL default '',
  user varchar(200) NOT NULL default '',
  isRead char(1) NOT NULL default '',
  isReplied char(1) NOT NULL default '',
  isFlagged char(1) NOT NULL default '',
  PRIMARY KEY  (accountId,mailId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_wiki_attachments'
--

CREATE TABLE tiki_wiki_attachments (
  attId int(12) NOT NULL auto_increment,
  page varchar(40) NOT NULL default '',
  filename varchar(80) NOT NULL default '',
  filetype varchar(80) NOT NULL default '',
  filesize int(14) NOT NULL default '0',
  user varchar(200) NOT NULL default '',
  data longblob,
  path varchar(255) NOT NULL default '',
  downloads int(10) NOT NULL default '0',
  created int(14) NOT NULL default '0',
  comment varchar(250) NOT NULL default '',
  PRIMARY KEY  (attId)
) TYPE=MyISAM;

--
-- Table structure for table 'tiki_zones'
--

CREATE TABLE tiki_zones (
  zone varchar(40) NOT NULL default '',
  PRIMARY KEY  (zone)
) TYPE=MyISAM;

--
-- Table structure for table 'users_grouppermissions'
--

CREATE TABLE users_grouppermissions (
  groupName varchar(30) NOT NULL default '',
  permName varchar(30) NOT NULL default '',
  value char(1) NOT NULL default '',
  PRIMARY KEY  (groupName,permName)
) TYPE=MyISAM;

--
-- Table structure for table 'users_groups'
--

CREATE TABLE users_groups (
  groupName varchar(30) NOT NULL default '',
  groupDesc varchar(255) NOT NULL default '',
  PRIMARY KEY  (groupName)
) TYPE=MyISAM;

--
-- Table structure for table 'users_objectpermissions'
--

CREATE TABLE users_objectpermissions (
  groupName varchar(30) NOT NULL default '',
  permName varchar(30) NOT NULL default '',
  objectType varchar(20) NOT NULL default '',
  objectId varchar(32) NOT NULL default '',
  PRIMARY KEY  (objectId,groupName,permName)
) TYPE=MyISAM;

--
-- Table structure for table 'users_permissions'
--

CREATE TABLE users_permissions (
  permName varchar(30) NOT NULL default '',
  permDesc varchar(250) NOT NULL default '',
  type varchar(20) NOT NULL default '',
  level varchar(80) NOT NULL default '',
  PRIMARY KEY  (permName)
) TYPE=MyISAM;

--
-- Table structure for table 'users_usergroups'
--

CREATE TABLE users_usergroups (
  userId int(8) NOT NULL default '0',
  groupName varchar(30) NOT NULL default '',
  PRIMARY KEY  (userId,groupName)
) TYPE=MyISAM;

--
-- Table structure for table 'users_users'
--

CREATE TABLE users_users (
  userId int(8) NOT NULL auto_increment,
  email varchar(200) NOT NULL default '',
  login varchar(40) NOT NULL default '',
  password varchar(30) NOT NULL default '',
  provpass varchar(30) NOT NULL default '',
  realname varchar(80) NOT NULL default '',
  homePage varchar(200) NOT NULL default '',
  lastLogin int(14) NOT NULL default '0',
  country varchar(80) NOT NULL default '',
  currentLogin int(14) NOT NULL default '0',
  registrationDate int(14) NOT NULL default '0',
  challenge varchar(32) NOT NULL default '',
  hash varchar(32) NOT NULL default '',
  pass_due int(14) NOT NULL default '0',
  created int(14) NOT NULL default '0',
  avatarName varchar(80) NOT NULL default '',
  avatarSize int(14) NOT NULL default '0',
  avatarFileType varchar(250) NOT NULL default '',
  avatarData longblob,
  avatarLibName varchar(200) NOT NULL default '',
  avatarType char(1) NOT NULL default '',
  PRIMARY KEY  (userId)
) TYPE=MyISAM;

