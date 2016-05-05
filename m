Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Thu,  5 May 2016 12:35:18 +0200
Message-Id: <1462444519-26509-1-git-send-email-sven.eckelmann@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Remove unused work_struct
	forward declaration
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

The only function declaration using the "struct work_struct" was removed
and thus this forward declaration should also be removed.

Fixes: 0d8468553c3c ("batman-adv: remove ogm_emit and ogm_schedule API calls")
Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
Problem was found by https://lists.open-mesh.org/pipermail/linux-merge/2016-May/003146.html

 net/batman-adv/send.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index f6fda19..7cecb75 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -26,7 +26,6 @@
 #include "packet.h"
 
 struct sk_buff;
-struct work_struct;
 
 void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet);
 int batadv_send_skb_to_orig(struct sk_buff *skb,
-- 
2.8.1

