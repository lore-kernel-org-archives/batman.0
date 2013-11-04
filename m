Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon,  4 Nov 2013 20:59:40 +0100
Message-Id: <1383595181-2061-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: deselect current GW on
	client mode switch off
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

When switching from gw_mode client to either off or server
the current selected gateway has to be deselected.
In this way when client mode is enabled again a gateway
re-election is forced and a GW_ADD event is consequently
sent.

The current behaviour instead is to keep the current gateway
leading to no GW_ADD event when gw_mode client is selected
for a second time

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---

Patch 2/2:
- rename gw_deselect to gw_reselect in gw_client.h

Cheers,


 gateway_client.c | 4 ++++
 sysfs.c          | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/gateway_client.c b/gateway_client.c
index 2449afa..2903bdb 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -207,6 +207,10 @@ void batadv_gw_check_client_stop(struct batadv_priv *bat_priv)
 	if (!curr_gw)
 		return;
 
+	/* deselect the current gateway so that next time that client mode is
+	 * enabled a proper GW_ADD event can be sent */
+	batadv_gw_select(bat_priv, NULL);
+
 	/* if batman-adv is switching the gw client mode off and a gateway was
 	 * already selected, send a DEL uevent
 	 */
diff --git a/sysfs.c b/sysfs.c
index 6335433..d1765fd 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -408,6 +408,15 @@ static ssize_t batadv_store_gw_mode(struct kobject *kobj,
 	batadv_info(net_dev, "Changing gw mode from: %s to: %s\n",
 		    curr_gw_mode_str, buff);
 
+	/* invoking batadv_gw_deselect() is not enough to really de-select the
+	 * current GW. It will only instruct the gateway code to perform a
+	 * re-election the next time that this is needed.
+	 *
+	 * When gw client mode is being switched off the current GW must be
+	 * de-selected explicitly otherwise no GW_ADD uevent is thrown on
+	 * client mode reactivation. This is operation is performed in
+	 * batadv_gw_check_client_stop().
+	 */
 	batadv_gw_deselect(bat_priv);
 	/* always call batadv_gw_check_client_stop() before changing the gateway
 	 * state
-- 
1.8.4.2

