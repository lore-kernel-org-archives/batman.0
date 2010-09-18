Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 18 Sep 2010 17:23:00 +0200
Message-Id: <1284823381-26943-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201009181721.44244.sven.eckelmann@gmx.de>
References: <201009181721.44244.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Track references of
	batman_if in set_primary_if
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

set_primary_if exchanges the current primary interfaces with a new one.
This is a new reference and thus we have to count it and decrease the
count of the old primary interface.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
I would like to keep that order of hold -> exchange -> put for later
changes (rcu or something like that for primary_if and curr_gw).

 batman-adv/hard-interface.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index f519b4b..942a44a 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -113,9 +113,17 @@ static void set_primary_if(struct bat_priv *bat_priv,
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

