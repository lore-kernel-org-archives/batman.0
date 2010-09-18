Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 18 Sep 2010 21:01:21 +0200
Message-Id: <1284836482-23431-12-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284836482-23431-1-git-send-email-sven.eckelmann@gmx.de>
References: <1284836482-23431-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 11/12] Staging: batman-adv: Track references
	of batman_if in set_primary_if
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

set_primary_if exchanges the current primary interfaces with a new one.
This is a new reference and thus we have to count it and decrease the
count of the old primary interface.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/hard-interface.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index eef5631..a9d6f1d 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -111,9 +111,17 @@ static void set_primary_if(struct bat_priv *bat_priv,
 {
 	struct batman_packet *batman_packet;
 	struct vis_packet *vis_packet;
+	struct batman_if *old_if;
 
+	if (batman_if)
+		hardif_hold(batman_if);
+
+	old_if = bat_priv->primary_if;
 	bat_priv->primary_if = batman_if;
 
+	if (old_if)
+		hardif_put(old_if);
+
 	if (!bat_priv->primary_if)
 		return;
 
-- 
1.7.2.3

