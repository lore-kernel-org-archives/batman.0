Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Fri,  3 Jul 2015 18:29:56 +0200
Message-Id: <1435940999-3829-2-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1435940999-3829-1-git-send-email-linus.luessing@c0d3.blue>
References: <1435940999-3829-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 maint 1/4] batman-adv: Fix broken DAT
	capability check
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

The introduction of set_bit() and clear_bit() calls in batman-adv
wrongly passed bitmasks and not the bit numbers to these functions.
This leads to broken capability checks.

Fixing this by making the capability enum a non-bitmasked one and by
that passing non-masked values to set_bit()/clear_bit().

Fixes: bfd0fbaef270 ("batman-adv: Make DAT capability changes atomic")
Reported-by: Def <def@laposte.net>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 distributed-arp-table.c |    2 +-
 types.h                 |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index b2cc19b..c0c514d 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -422,7 +422,7 @@ static bool batadv_is_orig_node_eligible(struct batadv_dat_candidate *res,
 	int j;
 
 	/* check if orig node candidate is running DAT */
-	if (!(candidate->capabilities & BATADV_ORIG_CAPA_HAS_DAT))
+	if (!(test_bit(BATADV_ORIG_CAPA_HAS_DAT, &candidate->capabilities)))
 		goto out;
 
 	/* Check if this node has already been selected... */
diff --git a/types.h b/types.h
index 65dc6bf..08a6343 100644
--- a/types.h
+++ b/types.h
@@ -299,7 +299,7 @@ struct batadv_orig_node {
  *  (= orig node announces a tvlv of type BATADV_TVLV_MCAST)
  */
 enum batadv_orig_capabilities {
-	BATADV_ORIG_CAPA_HAS_DAT = BIT(0),
+	BATADV_ORIG_CAPA_HAS_DAT,
 	BATADV_ORIG_CAPA_HAS_NC = BIT(1),
 	BATADV_ORIG_CAPA_HAS_TT = BIT(2),
 	BATADV_ORIG_CAPA_HAS_MCAST = BIT(3),
-- 
1.7.10.4

