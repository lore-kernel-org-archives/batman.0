Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 17 Mar 2013 05:44:58 +0100
Message-Id: <1363495498-17830-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1363495498-17830-1-git-send-email-linus.luessing@web.de>
References: <trinity-97d57b03-203f-4915-9bec-fcae5d01e618-1363490537768@3capp-webde-bs08>
 <1363495498-17830-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix general protection fault
	in batadv_tt_global_del_orig()
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

On shutdown a race condition where we access a just freed global TT hash
might occure. batadv_orig_node_free_rcu() callbacks might have been
scheduled (especially during the shutdown procedure) and unfortunately
batadv_tt_global_table_free() does not wait for them to finish first
before freeing the global TT hash.

This potentially results in a general protection fault in
batadv_tt_global_del_orig(), called via a batadv_orig_node_free_rcu()
callback, which tries to access the just freed global TT hash.

This patch tries to fix this by waiting for any just scheduled
batadv_orig_node_free_rcu() to finish via an extra rcu_barrier() call
before freeing the global TT hash. And by moving the TT freeing call to
the end of the batman cleanup routines.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>

diff --git a/main.c b/main.c
index 62b1f89..8663d97 100644
--- a/main.c
+++ b/main.c
@@ -166,12 +166,13 @@ void batadv_mesh_free(struct net_device *soft_iface)
 	batadv_originator_free(bat_priv);
 	batadv_nc_free(bat_priv);
 
-	batadv_tt_free(bat_priv);
-
 	batadv_bla_free(bat_priv);
 
 	batadv_dat_free(bat_priv);
 
+	/* Don't call any batadv_orig_node_free_ref() after me */
+	batadv_tt_free(bat_priv);
+
 	free_percpu(bat_priv->bat_counters);
 
 	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
diff --git a/translation-table.c b/translation-table.c
index ee91cc1..279f0fd 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1315,6 +1315,10 @@ static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 		spin_unlock_bh(list_lock);
 	}
 
+	/* Wait for any batadv_orig_node_free_rcu() to finish,
+	 * they access the to be freed global TT hash */
+	rcu_barrier();
+
 	batadv_hash_destroy(hash);
 
 	bat_priv->tt.global_hash = NULL;
-- 
1.7.10.4

