Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Thu, 10 May 2018 23:29:46 +0800
Message-Id: <20180510152946.7802-1-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix argument name in kernel-doc
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
Cc: Antonio Quartulli <a@unstable.cc>

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 11520de9..55d8e4c1 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -808,7 +808,7 @@ static int batadv_tp_wait_available(struct batadv_tp_vars *tp_vars, size_t plen)
 
 /**
  * batadv_tp_send() - main sending thread of a tp meter session
- * @arg: address of the related tp_vars
+ * @work: address of the related tp_vars
  *
  * Return: nothing, this function never returns
  */
-- 
2.17.0

