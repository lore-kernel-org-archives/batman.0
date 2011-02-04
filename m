Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Fri,  4 Feb 2011 16:21:36 +0100
Message-Id: <1296832896-30081-8-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <201102031802.52134.lindner_marek@yahoo.de>
References: <201102031802.52134.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 7/7] batman-adv: Increase orig_node refcount
	before releasing rcu read lock
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

When unicast_send_skb() is increasing the orig_node's refcount another
thread might have been freeing this orig_node already. We need to
increase the refcount in the rcu read lock protected area to avoid that.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 gateway_client.c |    3 +++
 unicast.c        |    1 -
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index 4624515..b3cda22 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -55,6 +55,9 @@ void *gw_get_selected(struct bat_priv *bat_priv)
 	}
 
 	orig_node = curr_gateway_tmp->orig_node;
+	if (orig_node)
+		kref_get(&orig_node->refcount);
+
 	rcu_read_unlock();
 
 	return orig_node;
diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index 580b547..f4f5115 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -298,7 +298,6 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 		if (!orig_node)
 			goto trans_search;
 
-		kref_get(&orig_node->refcount);
 		goto find_router;
 	} else {
 		rcu_read_lock();
-- 
1.7.2.3

