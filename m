Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 13:48:20 +0100
Message-Id: <1392122903-805-21-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFC 20/23] batman-adv: B.A.T.M.A.N. V - implement
	bat_neigh_free() API
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_v.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/bat_v.c b/bat_v.c
index 5681d19..3e4575d 100644
--- a/bat_v.c
+++ b/bat_v.c
@@ -63,6 +63,12 @@ static void batadv_v_ogm_emit(struct batadv_forw_packet *forw_packet)
 {
 }
 
+static void batadv_v_neigh_free(struct batadv_neigh_node *neigh)
+{
+	batadv_elp_neigh_node_free_ref(neigh->bat_v.elp_neigh);
+	neigh->bat_v.elp_neigh = NULL;
+}
+
 static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 	.name = "BATMAN_V",
 	.bat_iface_enable = batadv_v_iface_enable,
@@ -71,6 +77,7 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 	.bat_primary_iface_set = batadv_v_primary_iface_set,
 	.bat_ogm_emit = batadv_v_ogm_emit,
 	.bat_ogm_schedule = batadv_v_ogm_schedule,
+	.bat_neigh_free = batadv_v_neigh_free,
 };
 
 int batadv_v_mesh_init(struct batadv_priv *bat_priv)
-- 
1.8.5.3

