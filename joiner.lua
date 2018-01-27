-- Starting Joiner.lua By @Edward_Jason Or @MaQzAfzar Powered By @ExtraTab
config_sudo = {85386955,411253032} -- Put Here Sudoers ID ...
CliBotID = 395724392 -- Put Here Your Bot ID ...
local MaQzAfzar = {}
local function getParseMode(parse_mode)
if parse_mode then
local mode = parse_mode:lower()
if mode == 'markdown' or mode == 'md' then
P = {ID = "TextParseModeMarkdown"}
elseif mode == 'html' then
P = {ID = "TextParseModeHTML"}
end
end
return
end
local function getMessage(chat_id, message_id,cb)
tdcli_function ({ID = "GetMessage",chat_id_ = chat_id,message_id_ = message_id}, cb, nil)
end
MaQzAfzar.getMessage = getMessage
local function addChatMember(chat_id, user_id, forward_limit)
tdcli_function ({ID = "AddChatMember",chat_id_ = chat_id,user_id_ = user_id,forward_limit_ = forward_limit},dl_cb,nil)
end
MaQzAfzar.addChatMember = addChatMember
local function forwardMessages(chat_id, from_chat_id, message_ids, disable_notification)
tdcli_function ({ID = "ForwardMessages",chat_id_ = chat_id,from_chat_id_ = from_chat_id,message_ids_ = message_ids,disable_notification_ = disable_notification,from_background_ = 1}, dl_cb, nil)
end
MaQzAfzar.forwardMessages = forwardMessages
local function changeChatMemberStatus(chat_id, user_id, status)
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = chat_id,user_id_ = user_id,status_ = {ID = "ChatMemberStatus" .. status}}, dl_cb, nil)
end
MaQzAfzar.changeChatMemberStatus = changeChatMemberStatus
local function viewMessages(chat_id, message_ids)
tdcli_function ({ID = "ViewMessages",chat_id_ = chat_id,message_ids_ = message_ids}, dl_cb, nil)
end
MaQzAfzar.viewMessages = viewMessages
local function importContacts(phone_number, first_name, last_name, user_id)
tdcli_function ({ID = "ImportContacts",contacts_ = {[0] = {phone_number_ = tostring(phone_number),first_name_ = tostring(first_name),last_name_ = tostring(last_name),user_id_ = user_id}}}, dl_cb, nil)
end
MaQzAfzar.importContacts = importContacts
local function importChatInviteLink(invite_link)
tdcli_function ({ID = "ImportChatInviteLink",invite_link_ = invite_link}, dl_cb, nil)
end
MaQzAfzar.importChatInviteLink = importChatInviteLink
local function sendChatAction(chat_id, action, progress)
tdcli_function ({ID = "SendChatAction",chat_id_ = chat_id,action_ = {ID = "SendMessage" .. action .. "Action",progress_ = progress or nil}}, dl_cb, nil)
end
MaQzAfzar.sendChatAction = sendChatAction
local function openChat(chat_id)
tdcli_function ({ID = "OpenChat",chat_id_ = chat_id}, dl_cb, nil)
end
MaQzAfzar.openChat = openChat
local function sendText(chat_id, reply_to_message_id, disable_notification, text, disable_web_page_preview, parse_mode,msg)
local TextParseMode = getParseMode(parse_mode)
local entities = {}
if msg and text:match('<user>') and text:match('<user>') then
local x = string.len(text:match('(.*)<user>'))
local offset = x
local y = string.len(text:match('<user>(.*)</user>'))
local length = y
text = text:gsub('<user>','')
text = text:gsub('</user>','')
table.insert(entities,{ID="MessageEntityMentionName", offset_=0, length_=2, user_id_=234458457})
end
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = disable_notification,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = disable_web_page_preview,clear_draft_ = 0,entities_ = entities,parse_mode_ = TextParseMode}}, dl_cb, nil)
end
MaQzAfzar.sendText = sendText
redis = dofile('./libraries/redis.lua')
json = dofile('./libraries/JSON.lua')
URL = require "socket.url"
serpent = dofile("./libraries/serpent.lua")
http = require "socket.http"
https = require "ssl.https"
function dl_cb(arg, data)
end;function is_sudo(msg)
local var = false
for v,user in pairs(config_sudo) do
if user == msg.sender_user_id_ then
var = true
end
end
return var
end
function showedit(msg,data)
if msg then
viewMessages(msg.chat_id_, {[0] = msg.id_})
if msg.send_state_.ID == "MessageIsSuccessfullySent" then
return false 
end
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match('-100(%d+)') then
print("[ Super Group ]")
chat_type = 'super'
elseif id:match('^(%d+)') then
print("[ Private ]")
chat_type = 'user'
else
print("[ Group ]")
chat_type = 'group'
end
end
local MSG = msg.content_.text_
if MSG and MSG:match('[QWERTYUIOPASDFGHJKLZXCVBNM]') then
MSG = MSG
end
if msg.content_.ID == "MessageText" then
print("{ TG Texting Notification }")
message_type = 'MSG'
end
if msg.content_.ID == "MessageChatAddMembers" then
print("{ TG Adding Notification }")
message_type = 'user'
end
if msg.content_.ID == "MessageChatJoinByLink" then
print("{ TG Join Notification }")
message_type = 'Joins'
end
if msg.content_.ID == "MessageDocument" then
print("{ File Or Document }")
message_type = 'Document'
end
if msg.content_.ID == "MessageSticker" then 
print("{ Sticker }")
message_type = 'Sticker'
end
if msg.content_.ID == "MessageAudio" then
print("{ Audio }")
message_type = 'Audio'
end
if msg.content_.ID == "MessageVoice" then
print("{ Voice }")
message_type = 'Voice'
end
if msg.content_.ID == "MessageVideo" then
print("{ Video }")
message_type = 'Video'
end
if msg.content_.ID == "MessageAnimation" then
print("{ Gif }")
message_type = 'Gif'
end
if msg.content_.ID == "MessageLocation" then
print("{ Location }")
message_type = 'Location'
end
if msg.content_.ID == "MessageContact" then
print("{ Contact }")
message_type = 'Contact'
end
if not msg.reply_markup_ and msg.via_bot_user_id_ ~= 0 then
print("{ MarkDown }")
message_type = 'Markreed'
end
if msg.content_.ID == "MessagePhoto" then
print("{ Photo }")
message_type = 'Photo'
end
function check_markdown(MSG)
str = MSG
if str:match('_') then
output = str:gsub('_',[[\_]])
elseif str:match('*') then
output = str:gsub('*','\\*')
elseif str:match('`') then
output = str:gsub('`','\\`')
else
output = str
end
return output
end
if MSG then
if is_sudo(msg) then
print("[ Sudoer Msg ]")
else
print("[ Member Msg ]")
end
end
if msg.chat_id_ then
openChat(msg.chat_id_, dl_cb, nil)
print("[ Chat Opened ! ]")
end
if not redis:get("AutoOpenChat:"..CliBotID) or redis:ttl("AutoOpenChat:"..CliBotID) == -2 then
local open = redis:smembers("SuperGroup:"..CliBotID)
for k,v in pairs(open) do
openChat(v)
redis:setex("AutoOpenChat:"..CliBotID, 6, true)
end
end
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match('-100(%d+)') then
if not redis:sismember("SuperGroup:"..CliBotID,msg.chat_id_) then
redis:sadd("SuperGroup:"..CliBotID,msg.chat_id_)
print("[ SGP Add To List ]")
end
elseif id:match('^-(%d+)') then
if not redis:sismember("Group:"..CliBotID,msg.chat_id_) then
redis:sadd("Group:"..CliBotID,msg.chat_id_)
print("[ New GP Add To List ]")
end
elseif id:match('') then
if not redis:sismember("User:"..CliBotID,msg.chat_id_) then
redis:sadd("User:"..CliBotID,msg.chat_id_)
print("[ New USER Add To List ]")
end
else
if not redis:sismember("SuperGroup:"..CliBotID,msg.chat_id_) then
redis:sadd("SuperGroup:"..CliBotID,msg.chat_id_)
print("[ New SGP Add To List ]")
end
end
end
local SGPTEXT = {"SGP","SuperGP","SuperGroup","SuperChat","Super","سوپر گروه","سوپر","سوپر چت","سوپر گپ"}
local GPTEXT = {"GP","GrouP","Group","Chat","Not SGP","گروه","معمولی","چت","گپ"}
local UTEXT = {"کاربر","یوزر","User","Pv","PV","پیوی","پی وی","خصوصی","شخصی"}
local LINKTEXT = {"Link","LiNk","RecievedLink","Not Joined Link","LinK","لینک","لینک های دریافتی","لینک دریافت شده","لینک های گروه"}
local JOINEDTEXT = {"JoinedLink","Join Link","Link Join","joined","join","جوین شده","باطل","جوین ها","لینک های باطل"}
local SGP = (redis:scard('SuperGroup:'..CliBotID) or 0)
local GP = (redis:scard('Group:'..CliBotID) or 0)
local U = (redis:scard('User:'..CliBotID) or 0)
local LINK = (redis:scard('Links:'..CliBotID) or 0)
local JOINEDLINK = (redis:scard('JoinedLinks:'..CliBotID) or 0)
if MSG == 'stats' and is_sudo(msg) then
sendChatAction(msg.chat_id_, "Typing")
sendText(msg.chat_id_, 0,1,'• وضعیت \n• '..SGPTEXT[math.random(#SGPTEXT)]..' : '..SGP..'\n• '..GPTEXT[math.random(#GPTEXT)]..' : '..GP..'\n• '..UTEXT[math.random(#SGPTEXT)]..' : '..U..'\n• '..LINKTEXT[math.random(#LINKTEXT)]..' : '..LINK..'\n• '..JOINEDTEXT[math.random(#JOINEDTEXT)]..' : '..JOINEDLINK..'\n• [at]ExtraTab',1,'md')
end
if MSG == 'about' and is_sudo(msg) then
sendChatAction(msg.chat_id_, "Typing")
sendText(msg.chat_id_, 0,1,'• Developer : @Edward_Jason\n• Channel : @ExtraTab',1,'md') -- لطفا ویرایش نشود :( به احترام سازنده !
end
if MSG == 'reset' and is_sudo(msg) then
redis:del("SuperGroup:"..CliBotID)
redis:del("Group:"..CliBotID)
redis:del("User:"..CliBotID)
sendText(msg.chat_id_, msg.id_,1,'• ریست شد !',1,'md')
print("[ Stats Reseted ]")
end
local JoinLink = redis:get('JoinLink:'..CliBotID) or 'no'
if MSG == 'join on' and is_sudo(msg) then
if JoinLink == 'no' then
redis:del('JoinLink:'..CliBotID,'no')
redis:set('JoinLink:'..CliBotID,'yes')
sendChatAction(msg.chat_id_, "Typing")
sendText(msg.chat_id_, msg.id_,1,'• جوین فعال شد !',1,'md')
print("[ Join : Enabled ]")
else
sendChatAction(msg.chat_id_, "Typing")
sendText(msg.chat_id_, msg.id_,1,'• جوین فعال بود !',1,'md')
print("[ Join : Was Enabled ]")
end;end;if MSG == 'join off' and is_sudo(msg) then
if JoinLink == 'yes' then
redis:set('JoinLink:'..CliBotID,'no')
redis:del('JoinLink:'..CliBotID,'yes')
sendChatAction(msg.chat_id_, "Typing")
sendText(msg.chat_id_, msg.id_,1,'• جوین غیر فعال شد!',1,'md')
print("[ Join : Disabled ]")
else
sendChatAction(msg.chat_id_, "Typing")
sendText(msg.chat_id_, msg.id_,1,'• جوین غیر فعال بود !',1,'md')
print("[ Join : Was Disabled ]")
end
end
if MSG == 'join stats' and is_sudo(msg) then
local Stats = (redis:get('JoinLink:'..CliBotID) or 'no')
if Stats == 'yes' then
sendChatAction(msg.chat_id_, "Typing")
sendText(msg.chat_id_, msg.id_,1,'• فعال !',1,'md')
print("[ Join Stats : Enabled ]")
else
sendChatAction(msg.chat_id_, "Typing")
sendText(msg.chat_id_, msg.id_,1,'• غیرفعال !',1,'md')
print("[ Join Stats : Disabled ]")
end
end
if MSG and MSG:match('^addtoall (%d+)') and is_sudo(msg) then
local AddAllUser = MSG:match('addtoall (%d+)')
local AddAllLimit = redis:ttl('AddAllLimit'..CliBotID) or -2
if not AddAllLimit or AddAllLimit == -2 then
local Group = redis:smembers('SuperGroup:'..CliBotID) or 0
for k,SGPs in pairs(Group) do
sendChatAction(SGPs, "Typing")
addChatMember(SGPs, AddAllUser,5)
end
sendChatAction(msg.chat_id_, "Typing")
sendText(msg.chat_id_, 0,1,'• در حال اد آل کردن ... !',1,'md')
print("[ Add All User : Is Adding]")
redis:setex('AddAllLimit:'..CliBotID,3600,true)
else
sendChatAction(msg.chat_id_, "Typing")
sendText(msg.chat_id_, 0,1,'• از آخرین اد آل کردن شما کمی نگذشته است ...\n• کمی بعد امتحان کنید ... !',1,'md')
print("[ Add All User : Is Adding]")
end
end
if MSG == 'addcontact' and is_sudo(msg) then
redis:set('AddContact:'..CliBotID,'yes')
sendChatAction(msg.chat_id_, "Typing")
sendText(msg.chat_id_, 0,1,'• لطفا مخاطبین را جهت ذخیره ارسال کنید ... !',1,'md')
end
if MSG == 'reload' and is_sudo(msg) then
dofile('./joiner.lua')
sendChatAction(msg.chat_id_, "Typing")
sendText(msg.chat_id_, msg.id_,1,'• بارگزاری شد !',1,'md')
print("[ Reloaded ! ]")
end
--------------------
local JoinLink = (redis:get('JoinLink:'..CliBotID) or 'no')
if is_sudo(msg) then
if MSG and MSG:match("https://telegram.me/joinchat/%S+") or MSG and MSG:match("https://t.me/joinchat/%S+") or MSG and MSG:match("https://t.me/joinchat/%S+") or MSG and MSG:match("https://telegram.dog/joinchat/%S+") then
local MSG = MSG:gsub("t.me","telegram.me")
for link in MSG:gmatch("(https://telegram.me/joinchat/%S+)") do
print("[ Link : Msg ]")
if not redis:sismember('JoinedLinks:'..CliBotID,link) then
if not redis:sismember('Links:'..CliBotID,link) then
redis:sadd('Links:'..CliBotID,link)
print("[ Link : Added To links Automaticly ! ]")
end
end
end
end
end
--------------------
local addcontact = redis:get('AddContact:'..CliBotID) or 'not'
if addcontact == 'yes' and MSG == 'done' and is_sudo(msg) then
redis:del('AddContact:'..CliBotID,'yes')
sendChatAction(msg.chat_id_, "Typing")
sendText(msg.chat_id_, 0,1,'• مخاطبین مورد نظر با موفقیت ذخیره شدند ... !',1,'md')
end
if addcontact == 'yes' and message_type == 'Contact' then
importContacts(msg.content_.contact_.phone_number_, (msg.content_.contact_.first_name_ or '--'), '#EDWARDJASON[@EXTRATAB]', msg.content_.contact_.user_id_)
sendChatAction(msg.chat_id_, "Typing")
sendText(msg.chat_id_, 0,1,'• با موفقیت ذخیره شد !\n• برای پایان دادن به این پروسه done را ارسال کنید ... !',1,'md')
end
-------------------
if chat_type == 'user' then
local TELEGRAM = 777000
if msg.sender_user_id_ == tonumber(TELEGRAM) then
function fwdTGmsg(a,b,c)
for k,v in pairs(config_sudo) do
forwardMessages(v, msg.chat_id_, {[0] = b.id_}, 1)
end
end
end
getMessage(msg.chat_id_, msg.id_,fwdTGmsg)
end
-------------------
local Joining = (redis:get('JoinLink:'..CliBotID) or 'no')
if Joining == 'yes' then
if tonumber(redis:scard("SuperGroup:"..CliBotID)) >= 490 then
redis:set('JoinLink:'..CliBotID,'no')
redis:del('JoinLink:'..CliBotID,'yes')
for k,v in pairs(config_sudo) do
sendChatAction(v, "Typing")
sendText(v, 0,1,'• به دلیل بالا رفتن بسیار امار ربات جوین در گروه ها غیرفعال شد :) !',1,'md')
end
end
end
------------------
local SGPamount = {100,200,300,400,450}
local LeaveTime = {3600,7200}
local LeaveLimit = redis:ttl('LeaveLimit:'..CliBotID) or -2
if not LeaveLimit or LeaveLimit == -2 then
elseif tonumber(SGP) >= tonumber(SGPamount[math.random(#SGPamount)]) then
changeChatMemberStatus(msg.chat_id_, msg.chat_id_, "Left")
for k,v in pairs(config_sudo) do
sendChatAction(v, "Typing")
sendText(v, 0,1,'• تبچی به طور خودکار از گروهی با آیدی : '..msg.chat_id_..' لفت داد !',1,'md')
end
redis:srem('SuperGroup'..CliBotID,msg.chat_id_)
redis:setex('LeaveLimit:'..CliBotID,LeaveTime[math.random(#LeaveTime)],true)
print("[ Bot : Left Automaticly ]")
end
---------------
local ResetLimit = redis:ttl('ResetLimit:'..CliBotID)
local ResetLimitRandTime = {3600,7200}
if not ResetLimit or ResetLimit == -2 then
redis:del("SuperGroup:"..CliBotID)
redis:del("Group:"..CliBotID)
redis:del("User:"..CliBotID)
print("[ Stats : Reseted Automaticly ]")
for k,v in pairs(config_sudo) do
sendChatAction(v, "Typing")
sendText(v, 0,1,'• جوینر به صورت خودکار امار را بازنگری کرد !',1,'md')
end
redis:setex('ResetLimit:'..CliBotID,ResetLimitRandTime[math.random(#ResetLimitRandTime)],true)
end
---------------
local Limit = (redis:ttl('Limit:'..CliBotID) or -2)
local linkamount = redis:scard('Links:'..CliBotID)
local Status = (redis:get('JoinLink:'..CliBotID) or 'no')
local randomtime = {100,105,110,115,120,125,130,135,140,145,150,155,160,165,170,175,180,185,190,195,200}
if Status == 'yes' then
if not linkamount then
return
else
if not Limit or Limit == -2 then
local random = redis:smembers('Links:'..CliBotID) or 0
local link = random[math.random(#random)]
importChatInviteLink(link)
redis:sadd('JoinedLinks:'..CliBotID,link)
redis:srem('Links:'..CliBotID,link)
print("+ Joined Link +")
redis:setex('Limit:'..CliBotID,randomtime[math.random(#randomtime)],true)
end
end
end
----------------
end
end
function tdcli_update_callback(data)
if (data.ID == "UpdateNewMessage") then
showedit(data.message_,data)
elseif (data.ID == "UpdateMessageEdited") then
data = data
local function edit(extra,result,success)
showedit(result,data)
end
tdcli_function ({ ID = "GetMessage", chat_id_ = data.chat_id_,message_id_ = data.message_id_}, edit, nil)
elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then
tdcli_function ({ ID="GetChats",offset_order_="9223372036854775807", offset_chat_id_=0,limit_=20}, dl_cb, nil)
end
end
-- By @MaQzAfzar And @Edward_Jason Developed By @ExtraTab Team Believe Us :) Plz Don't Empty This Paragraph لطفا این قسمت را پاک نکنید برای احترام به زحمات برنامه نویس نوشته شده توسط [@MaQzAfzar] تیم توسعه دهنده [@ExtraTab]