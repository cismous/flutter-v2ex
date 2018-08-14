const String HOST = 'https://jiasule.v2ex.com/';
const String API_PATH = 'api/';

const String API_HOST = HOST + API_PATH;

/// 获取网站信息
/// @GET
/// {
///   "title" : "V2EX",
///   "slogan" : "way to explore",
///   "description" : "创意工作者们的社区",
///   "domain" : "www.v2ex.com"
/// }
const String API_SITE_INFO = API_HOST + 'site/info.json';

/// 获取网站状态
/// @GET
/// {
///   "topic_max" : 126172,
///   "member_max" : 71033
/// }
const String API_SITE_STATUS = API_HOST + 'site/stats.json';

/// 获取最新主题
/// @GET
const String API_TOPICS_LATEST = API_HOST + 'topics/latest.json';

/// 获取热议主题
/// @GET
const String API_TOPICS_HOT = API_HOST + 'topics/hot.json';

/// 获取主题详细信息
/// @GET
/// @param id 话题id
const String API_TOPIC_DETAILS = API_HOST + 'topics/show.json';

/// 获取主题回贴
/// @GET
/// @param topic_id
/// @param page
/// @param page_size
const String API_TOPIC_REPLY = API_HOST + 'replies/show.json';

/// 获取用户信息
/// @GET
/// @param username
const String API_MEMBER = API_HOST + 'members/show.json';
