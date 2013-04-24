Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 24 Apr 2013 16:37:52 +0200
Message-Id: <1366814272-21120-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1366814272-21120-1-git-send-email-ordex@autistici.org>
References: <1366814272-21120-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH respin 2/2] batman-adv: move
	BATADV_TT_CLIENT_TEMP to higher bit
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
Cc: Antonio Quartulli <ordex@autistici.org>

Client flags from bit 0 to 7 are sent over the wire.
BATADV_TT_CLIENT_TEMP is not sent therefore it has occupy
an higher bit so to avoid wasting positions used by flags
sent within packets

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 packet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packet.h b/packet.h
index f21f9fa..aee6b96 100644
--- a/packet.h
+++ b/packet.h
@@ -106,10 +106,10 @@ enum batadv_tt_client_flags {
 	BATADV_TT_CLIENT_DEL     = BIT(0),
 	BATADV_TT_CLIENT_ROAM    = BIT(1),
 	BATADV_TT_CLIENT_WIFI    = BIT(2),
-	BATADV_TT_CLIENT_TEMP	 = BIT(3),
 	BATADV_TT_CLIENT_NOPURGE = BIT(8),
 	BATADV_TT_CLIENT_NEW     = BIT(9),
 	BATADV_TT_CLIENT_PENDING = BIT(10),
+	BATADV_TT_CLIENT_TEMP	 = BIT(11),
 };
 
 /* claim frame types for the bridge loop avoidance */
-- 
1.8.1.5

