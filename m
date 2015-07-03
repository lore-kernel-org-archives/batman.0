Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Fri,  3 Jul 2015 18:29:57 +0200
Message-Id: <1435940999-3829-3-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1435940999-3829-1-git-send-email-linus.luessing@c0d3.blue>
References: <1435940999-3829-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 maint 2/4] batman-adv: Fix broken NC
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

Fixes: 586df9e2537b ("batman-adv: Make NC capability changes atomic")
Reported-by: Def <def@laposte.net>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 network-coding.c |    2 +-
 types.h          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/network-coding.c b/network-coding.c
index 3ce493e..0309c2c 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -871,7 +871,7 @@ void batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
 		goto out;
 
 	/* check if orig node is network coding enabled */
-	if (!(orig_node->capabilities & BATADV_ORIG_CAPA_HAS_NC))
+	if (!(test_bit(BATADV_ORIG_CAPA_HAS_NC, &orig_node->capabilities)))
 		goto out;
 
 	/* accept ogms from 'good' neighbors and single hop neighbors */
diff --git a/types.h b/types.h
index 08a6343..cb7ccb1 100644
--- a/types.h
+++ b/types.h
@@ -300,7 +300,7 @@ struct batadv_orig_node {
  */
 enum batadv_orig_capabilities {
 	BATADV_ORIG_CAPA_HAS_DAT,
-	BATADV_ORIG_CAPA_HAS_NC = BIT(1),
+	BATADV_ORIG_CAPA_HAS_NC,
 	BATADV_ORIG_CAPA_HAS_TT = BIT(2),
 	BATADV_ORIG_CAPA_HAS_MCAST = BIT(3),
 };
-- 
1.7.10.4

