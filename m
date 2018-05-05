Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 5 May 2018 17:46:29 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20180505154629.GA22195@otheros>
References: <20180505153020.29636-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180505153020.29636-1-linus.luessing@c0d3.blue>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix TT sync flags for
 intermediate TT responses
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


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sat, May 05, 2018 at 05:30:20PM +0200, Linus Lüssing wrote:
> I was able to reproduce the issue with intermediate TT responses in a
> four node test setup and this patch fixes this issue by ensuring to
> use the per originator instead of the summarized, OR'd ones.

Reproduction in VMs was a little bit tricky though. I used the
attached patch to:

A) Disable TT changes attached to OGMs
B) Enforce TT full table responses
C) Allow injecting a 'W' flag onto multicast TT entries on
   selected nodes

With this patch applied I used the following steps to reproduce
the issue:

1) Prepare a four nodes setup with a line topology:
   1 - 2 - 3 - 4
2) Enable IPv6
3) Start (patched) batman-adv
4) Node 4: Set multicast_mode to 2
5) Node 4: Set bat0 down & up
   -> check that 'W' flag is present in global TT for node 4
6) Node 3: Set bat0 down & up
7) Node 1: Check that 'W' flag is now present on
           multicast entries for both node 3 and 4

With the fix applied step 7 shows no more 'W' flags for node 3.

Regards, Linus

--IS0zKkzwUGydFO0o
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="tt-response-flags-debug.patch"

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index f2eef43b..cb79a1b8 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -687,7 +687,7 @@ static BATADV_ATTR(gw_sel_class, 0644, batadv_show_gw_sel_class,
 static BATADV_ATTR(gw_bandwidth, 0644, batadv_show_gw_bwidth,
 		   batadv_store_gw_bwidth);
 #ifdef CONFIG_BATMAN_ADV_MCAST
-BATADV_ATTR_SIF_BOOL(multicast_mode, 0644, NULL);
+BATADV_ATTR_SIF_UINT(multicast_mode, multicast_mode, 0644, 0, 2, NULL);
 #endif
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 BATADV_ATTR_SIF_UINT(log_level, log_level, 0644, 0, BATADV_DBG_ALL, NULL);
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index f141c14e..4218597e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -820,6 +820,15 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 
 	ret = true;
 out:
+	if (is_multicast_ether_addr(addr)) {
+		if (atomic_read(&bat_priv->multicast_mode) > 1) {
+			tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
+			printk("~~~ %s: Forcing wifi flag on multicast entry\n", __func__);
+		} else {
+			printk("~~~ %s: Not forcing wifi flag on multicast entry\n", __func__);
+		}
+	}
+
 	if (in_hardif)
 		batadv_hardif_put(in_hardif);
 	if (in_dev)
@@ -1170,6 +1179,15 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 	if (!hdr)
 		return -ENOBUFS;
 
+	if (is_multicast_ether_addr(common->addr)) {
+		if (atomic_read(&bat_priv->multicast_mode) > 1) {
+			printk("~~~ %s: WIFI flag is %sset\n", __func__,
+				common->flags & BATADV_TT_CLIENT_WIFI ? "" : "not ");
+			printk("~~~ %s: flags: %u, WIFI: %u, NOPURGE: %u\n", __func__,
+				common->flags, BATADV_TT_CLIENT_WIFI, BATADV_TT_CLIENT_NOPURGE);
+		}
+	}
+
 	if (nla_put(msg, BATADV_ATTR_TT_ADDRESS, ETH_ALEN, common->addr) ||
 	    nla_put_u32(msg, BATADV_ATTR_TT_CRC32, crc) ||
 	    nla_put_u16(msg, BATADV_ATTR_TT_VID, common->vid) ||
@@ -3161,8 +3179,8 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 		tt_vlan++;
 	}
 
-	if (full_table)
-		tvlv_tt_data->flags |= BATADV_TT_FULL_TABLE;
+//	if (full_table)
+	tvlv_tt_data->flags |= BATADV_TT_FULL_TABLE;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv, "Sending TT_REQUEST to %pM [%c]\n",
 		   dst_orig_node->orig, full_table ? 'F' : '.');
@@ -3284,6 +3302,8 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 		if (!tt_len)
 			goto out;
 
+		printk("~~~ %s: generating full table TT response for %pM, req by %pM\n", __func__, req_dst, req_src);
+
 		/* fill the rest of the tvlv with the real TT entries */
 		batadv_tt_tvlv_generate(bat_priv, bat_priv->tt.global_hash,
 					tt_change, tt_len,
@@ -3413,6 +3433,8 @@ static bool batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 		if (!tt_len || !tvlv_len)
 			goto out;
 
+		printk("~~~ %s: generating full table TT response for me, req by %pM\n", __func__, req_src);
+
 		/* fill the rest of the tvlv with the real TT entries */
 		batadv_tt_tvlv_generate(bat_priv, bat_priv->tt.local_hash,
 					tt_change, tt_len,
@@ -4230,7 +4252,8 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 	num_entries = batadv_tt_entries(tvlv_value_len);
 
 	batadv_tt_update_orig(bat_priv, orig, tt_vlan, num_vlan, tt_change,
-			      num_entries, tt_data->ttvn);
+			      0, tt_data->ttvn);
+//			      num_entries, tt_data->ttvn);
 }
 
 /**

--IS0zKkzwUGydFO0o--
