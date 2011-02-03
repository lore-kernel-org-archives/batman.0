Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Thu,  3 Feb 2011 15:43:21 +0100
Message-Id: <1296744201-11542-3-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1296668238-19323-1-git-send-email-linus.luessing@ascom.ch>
References: <1296668238-19323-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Increase orig_node refcount
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
 gateway_client.c |    1 +
 unicast.c        |    1 -
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index ee71335..15ea268 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -57,6 +57,7 @@ void *gw_get_selected(struct bat_priv *bat_priv)
 
 	orig_node = rcu_dereference(curr_gateway_tmp->orig_node);
 	if (orig_node) {
+		kref_get(&orig_node->refcount);
 		rcu_read_unlock();
 		return NULL;
 	}
diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index 8816102..b42e40e 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -310,7 +310,6 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 			goto trans_search;
 		}
 
-		kref_get(&orig_node->refcount);
 		rcu_read_unlock();
 		goto find_router;
 	}
-- 
1.7.2.3

