Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 1/1] batman-adv: fix uninit-value in
 batadv_netlink_get_ifindex()
Date: Wed, 21 Aug 2019 15:30:15 +0200
Message-Id: <20190821133015.12778-2-sw@simonwunderlich.de>
In-Reply-To: <20190821133015.12778-1-sw@simonwunderlich.de>
References: <20190821133015.12778-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Eric Dumazet <edumazet@google.com>

batadv_netlink_get_ifindex() needs to make sure user passed
a correct u32 attribute.

syzbot reported :
BUG: KMSAN: uninit-value in batadv_netlink_dump_hardif+0x70d/0x880 net/batman-adv/netlink.c:968
CPU: 1 PID: 11705 Comm: syz-executor888 Not tainted 5.1.0+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x191/0x1f0 lib/dump_stack.c:113
 kmsan_report+0x130/0x2a0 mm/kmsan/kmsan.c:622
 __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:310
 batadv_netlink_dump_hardif+0x70d/0x880 net/batman-adv/netlink.c:968
 genl_lock_dumpit+0xc6/0x130 net/netlink/genetlink.c:482
 netlink_dump+0xa84/0x1ab0 net/netlink/af_netlink.c:2253
 __netlink_dump_start+0xa3a/0xb30 net/netlink/af_netlink.c:2361
 genl_family_rcv_msg net/netlink/genetlink.c:550 [inline]
 genl_rcv_msg+0xfc1/0x1a40 net/netlink/genetlink.c:627
 netlink_rcv_skb+0x431/0x620 net/netlink/af_netlink.c:2486
 genl_rcv+0x63/0x80 net/netlink/genetlink.c:638
 netlink_unicast_kernel net/netlink/af_netlink.c:1311 [inline]
 netlink_unicast+0xf3e/0x1020 net/netlink/af_netlink.c:1337
 netlink_sendmsg+0x127e/0x12f0 net/netlink/af_netlink.c:1926
 sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg net/socket.c:661 [inline]
 ___sys_sendmsg+0xcc6/0x1200 net/socket.c:2260
 __sys_sendmsg net/socket.c:2298 [inline]
 __do_sys_sendmsg net/socket.c:2307 [inline]
 __se_sys_sendmsg+0x305/0x460 net/socket.c:2305
 __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2305
 do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
 entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x440209

Fixes: b60620cf567b ("batman-adv: netlink: hardif query")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 6f08fd122a8d..7e052d6f759b 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -164,7 +164,7 @@ batadv_netlink_get_ifindex(const struct nlmsghdr *nlh, int attrtype)
 {
 	struct nlattr *attr = nlmsg_find_attr(nlh, GENL_HDRLEN, attrtype);
 
-	return attr ? nla_get_u32(attr) : 0;
+	return (attr && nla_len(attr) == sizeof(u32)) ? nla_get_u32(attr) : 0;
 }
 
 /**
-- 
2.20.1

