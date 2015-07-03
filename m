Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Fri,  3 Jul 2015 18:29:58 +0200
Message-Id: <1435940999-3829-4-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1435940999-3829-1-git-send-email-linus.luessing@c0d3.blue>
References: <1435940999-3829-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 maint 3/4] batman-adv: Fix broken TT
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

Fixes: a51fa16ecf3f ("batman-adv: Make TT capability changes atomic")
Reported-by: Def <def@laposte.net>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 translation-table.c |    3 ++-
 types.h             |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index b6c0f52..d73b103 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -3323,7 +3323,8 @@ static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 	bool has_tt_init;
 
 	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)tt_buff;
-	has_tt_init = orig_node->capa_initialized & BATADV_ORIG_CAPA_HAS_TT;
+	has_tt_init = test_bit(BATADV_ORIG_CAPA_HAS_TT,
+			       &orig_node->capa_initialized);
 
 	/* orig table not initialised AND first diff is in the OGM OR the ttvn
 	 * increased by one -> we can apply the attached changes
diff --git a/types.h b/types.h
index cb7ccb1..6f4486c 100644
--- a/types.h
+++ b/types.h
@@ -301,7 +301,7 @@ struct batadv_orig_node {
 enum batadv_orig_capabilities {
 	BATADV_ORIG_CAPA_HAS_DAT,
 	BATADV_ORIG_CAPA_HAS_NC,
-	BATADV_ORIG_CAPA_HAS_TT = BIT(2),
+	BATADV_ORIG_CAPA_HAS_TT,
 	BATADV_ORIG_CAPA_HAS_MCAST = BIT(3),
 };
 
-- 
1.7.10.4

