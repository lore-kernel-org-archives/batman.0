Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 18 Apr 2012 09:35:13 +0200
Message-Id: <1334734513-30357-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: use uint32_t instead of unsigned
	long to avoid cast
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

Reported-by: David Miller <davem@davemloft.net>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

This patch is for *next*. It solves a problem pointed out by David S. Miller.
This patch will be squashed with the one which introduced the issue and will be
sent out in the next pull request.

Cheers,


 bat_iv_ogm.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 994369d..ab2085c 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -58,12 +58,12 @@ out:
 static int bat_iv_ogm_iface_enable(struct hard_iface *hard_iface)
 {
 	struct batman_ogm_packet *batman_ogm_packet;
-	unsigned long random_seqno;
+	uint32_t random_seqno;
 	int res = -1;
 
 	/* randomize initial seqno to avoid collision */
-	get_random_bytes(&random_seqno, sizeof(unsigned long));
-	atomic_set(&hard_iface->seqno, (uint32_t)random_seqno);
+	get_random_bytes(&random_seqno, sizeof(random_seqno));
+	atomic_set(&hard_iface->seqno, random_seqno);
 
 	hard_iface->packet_len = BATMAN_OGM_HLEN;
 	hard_iface->packet_buff = kmalloc(hard_iface->packet_len, GFP_ATOMIC);
-- 
1.7.9.4

