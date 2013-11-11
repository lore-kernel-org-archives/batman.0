Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon, 11 Nov 2013 07:48:47 +0100
Message-Id: <1384152527-6916-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: compat: fix multicast compat
	code for < 2.6.35
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

A typo resulted into the following build warning:

"In function 'batadv_mcast_mla_softif_get':
 warning: assignment from incompatible pointer type"

This commit fixes it by using the correct name for the according struct.

Introduced by: a3f58139efedb96222dffdda89896c243fdff49e
("batman-adv: Multicast Listener Announcements via Translation Table")

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 compat.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat.h b/compat.h
index 186547b..c83ac2c 100644
--- a/compat.h
+++ b/compat.h
@@ -103,8 +103,8 @@ static inline struct sk_buff *netdev_alloc_skb_ip_align(struct net_device *dev,
 
 #undef  netdev_for_each_mc_addr
 #define netdev_for_each_mc_addr(mclist, dev) \
-	for (mclist = (struct bat_dev_addr_list *)dev->mc_list; mclist; \
-	     mclist = (struct bat_dev_addr_list *)mclist->next)
+	for (mclist = (struct batadv_dev_addr_list *)dev->mc_list; mclist; \
+	     mclist = (struct batadv_dev_addr_list *)mclist->next)
 
 /* Note, that this breaks the usage of the normal 'struct netdev_hw_addr'
  * for kernels < 2.6.35 in batman-adv!
-- 
1.7.10.4

