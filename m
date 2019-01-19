Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 19 Jan 2019 16:56:25 +0100
Message-Id: <20190119155626.6414-19-sven@narfation.org>
In-Reply-To: <20190119155626.6414-1-sven@narfation.org>
References: <20190119155626.6414-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v4 18/19] batman-adv: Add throughput_override
 hardif genl configuration
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
Cc: Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org, Sven Eckelmann <sven@narfation.org>, Antonio Quartulli <a@unstable.cc>

The B.A.T.M.A.N. V implementation tries to estimate the link throughput of
an interface to an originator using different automatic methods. It is
still possible to overwrite it the link throughput for all reachable
originators via this interface.

The BATADV_CMD_SET_HARDIF/BATADV_CMD_GET_HARDIF commands allow to set/get
the configuration of this feature using the u32
BATADV_ATTR_THROUGHPUT_OVERRIDE attribute. The used unit is in 100 Kbit/s.
If the value is set to 0 then batman-adv will try to estimate the
throughput by itself.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Antonio Quartulli <a@unstable.cc>
---
 include/uapi/linux/batman_adv.h |  8 ++++++++
 net/batman-adv/netlink.c        | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index a2abbf7d..9031e8a1 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -482,6 +482,14 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_ELP_INTERVAL,
 
+	/**
+	 * @BATADV_ATTR_THROUGHPUT_OVERRIDE: defines the throughput value to be
+	 *  used by B.A.T.M.A.N. V when estimating the link throughput using
+	 *  this interface. If the value is set to 0 then batman-adv will try to
+	 *  estimate the throughput by itself.
+	 */
+	BATADV_ATTR_THROUGHPUT_OVERRIDE,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 48d33ae4..34ff51ac 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -160,6 +160,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_NETWORK_CODING_ENABLED]	= { .type = NLA_U8 },
 	[BATADV_ATTR_ORIG_INTERVAL]		= { .type = NLA_U32 },
 	[BATADV_ATTR_ELP_INTERVAL]		= { .type = NLA_U32 },
+	[BATADV_ATTR_THROUGHPUT_OVERRIDE]	= { .type = NLA_U32 },
 };
 
 /**
@@ -830,6 +831,10 @@ static int batadv_netlink_hardif_put(struct sk_buff *msg,
 	if (nla_put_u32(msg, BATADV_ATTR_ELP_INTERVAL,
 			atomic_read(&hard_iface->bat_v.elp_interval)))
 		goto nla_put_failure;
+
+	if (nla_put_u32(msg, BATADV_ATTR_THROUGHPUT_OVERRIDE,
+			atomic_read(&hard_iface->bat_v.throughput_override)))
+		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_BATMAN_V */
 
 	genlmsg_end(msg, hdr);
@@ -925,6 +930,13 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
 
 		atomic_set(&hard_iface->bat_v.elp_interval, nla_get_u32(attr));
 	}
+
+	if (info->attrs[BATADV_ATTR_THROUGHPUT_OVERRIDE]) {
+		attr = info->attrs[BATADV_ATTR_THROUGHPUT_OVERRIDE];
+
+		atomic_set(&hard_iface->bat_v.throughput_override,
+			   nla_get_u32(attr));
+	}
 #endif /* CONFIG_BATMAN_ADV_BATMAN_V */
 
 	batadv_netlink_notify_hardif(bat_priv, hard_iface);
-- 
2.20.1

