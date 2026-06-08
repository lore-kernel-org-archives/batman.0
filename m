Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0F8CD6E79
	for <batman-adv@archiver.kernel.org>; Mon,  8 Jun 2026 18:23:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A217383F28
	for <batman-adv@archiver.kernel.org>; Mon, 08 Jun 2026 20:23:03 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780942983;
 b=mlzBxalojCmEG6Qbq2ZmGLslCejssWHbrtApX7G5kCJ2kuuAaLd2ZQA0ECSnNLsoiN+2E
 QmlEyGJeAfgMFn1u8Oy5sj9MKVesRxR76Vhn85TXhwjvFuASdpEU7QgdP97dAUhSNCT2tVS
 yjvy+4xxGPecQD+l4wNOHFHb1v4X3kE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780942983; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=NPtu36b5tIki7NGaKbAd3aUpljvp7CzumLQdE3jBCvk=;
 b=VQtJ3zD4DeZC4KPzJsnx1lvLnZUqUe2RWGaAi80PR5JuDtFxDfVqs50mW5nK+dN8uhwtY
 1iOuTwga1ysrL8jq4a8a71wfzdj7LJ3hr++CEK1Xuiq8w88j1PUChdQcpOlO0GZ+C2ZcCJv
 Rz3JDMalm4QBHpfRdPdZ7F5fjVtFCt4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D6A7783E82
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 08 Jun 2026 20:22:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780942973;
	b=bRBV4v+k+0ryuPVy7rWCkRypgO1/NkYjozs9a35n7vq3K4mpvZey/bFLxzwUi9asfoJyUa
	HTxE1MRRV4Ek+SV7+eNfXk55HHCC96B3uErSxsRo+/mMiA3AixKt6y9v7cEie2VJj8pulH
	ItIcGMg2+uj6B+6EWLM8BSkoiEMkrRs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=GuxSjT+7;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780942973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=NPtu36b5tIki7NGaKbAd3aUpljvp7CzumLQdE3jBCvk=;
	b=Sqre3mXif5Ng8NDwFP1IpXEiWqb524IlkaRPWgLyZiMK+vHyQbDsTJjcmyZNWGtOc7PjXN
	zSchZP2OanZmkyTBqG2+qdGWPkzIpn1ZhwXzbYNm/P1dXf9US5ag3O+6cIHhKTjbdJJMUV
	2XOvfk1VNjDyONQ/lA/JR2w/cxg2eAM=
Received: by dvalin.narfation.org (Postfix) id 682061FEF0;
	Mon, 08 Jun 2026 18:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780942971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NPtu36b5tIki7NGaKbAd3aUpljvp7CzumLQdE3jBCvk=;
	b=GuxSjT+787pMqVRZ6YZAzTnumGaCUuIikeFFYyNGX2uVC6fjIzbxvg2/LKj5BvYjx7z8nh
	SW5IJaNXtC4plPZidF0TvnxM3tLJKmJdWm9nOEF+oowYp2JXYWK5xT5xvMDrsIMOZsj8aY
	azkF36GFD5JCvI0xmwzF+g7XlAxI1dM=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 08 Jun 2026 20:22:44 +0200
Subject: [PATCH] batctl: use reverse xmas tree declaration order
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-reverse-xmas-v1-1-8860cdae43ac@narfation.org>
X-B4-Tracking: v=1; b=H4sIAHMIJ2oC/yXMywqAIBCF4VeJWSeYlFSvEi3MppqgC06FIL17V
 ssPzvkDMDpChjoJ4PAipm2NyNIE7GTWEQX10aCk0lLLUsQROkbhF8PCKlOZzBa57DXEy+5wIP/
 lmvY3n92M9ngbcN8P4jR0uHAAAAA=
X-Change-ID: 20260608-reverse-xmas-c2a9a1c540d6
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=25592; i=sven@narfation.org;
 h=from:subject:message-id; bh=rs9Wr341hWDob/aDRTytsJ8eFBcb+STovdFBnXzN4Hk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnqHCU/IxarTLW8fdDC8ZD01T1Zy1fI/3lvHt4uqq7ic
 f2umYJARykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAif1kZGR5ovn42s/I76/2/
 a0uO7u5Kn3Tv+qK2M06aPccrgtI+r+Vn+CvON2vWDzUlZ8mnH6W9Vm/e5H47mKNOwoj/1a1ldod
 lspgA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: MGCC2N7ZFQ25LLIX7MIVXJC3SQUBICCF
X-Message-ID-Hash: MGCC2N7ZFQ25LLIX7MIVXJC3SQUBICCF
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MGCC2N7ZFQ25LLIX7MIVXJC3SQUBICCF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

In the kernel, network related code is supposed (according to the
"Networking subsystem (netdev)" documentation) to use the "reverse xmas
tree" style of variable declarations. To keep it consistent between the
userspace and kernelspace code, also use the same for userspace.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 aggregation.c           |  6 ++++--
 ap_isolation.c          |  6 ++++--
 bisect_iv.c             |  6 ++++--
 bonding.c               |  6 ++++--
 bridge_loop_avoidance.c |  6 ++++--
 dat_cache.c             |  4 +++-
 distributed_arp_table.c |  6 ++++--
 elp_interval.c          |  6 ++++--
 fragmentation.c         |  6 ++++--
 functions.c             | 12 ++++++------
 gateways.c              |  2 +-
 genl.c                  |  2 +-
 gw_mode.c               |  8 ++++----
 hop_penalty.c           | 12 ++++++++----
 icmp_helper.c           |  5 +++--
 interface.c             |  2 +-
 isolation_mark.c        |  9 ++++++---
 list.h                  |  4 ++--
 main.c                  | 10 +++++-----
 multicast_fanout.c      |  9 ++++++---
 multicast_forceflood.c  |  6 ++++--
 multicast_mode.c        |  6 ++++--
 neighbors.c             |  3 ++-
 orig_interval.c         |  6 ++++--
 sys.c                   | 14 ++++++++------
 tcpdump.c               |  8 ++++----
 throughput_override.c   |  9 ++++++---
 throughputmeter.c       |  4 ++--
 transglobal.c           |  6 +++++-
 29 files changed, 117 insertions(+), 72 deletions(-)

diff --git a/aggregation.c b/aggregation.c
index 245b0d3..b80c3de 100644
--- a/aggregation.c
+++ b/aggregation.c
@@ -32,10 +32,12 @@ static int get_aggregated_ogms(struct state *state)
 
 static int set_attrs_aggregated_ogms(struct nl_msg *msg, void *arg)
 {
+	struct simple_boolean_data *data;
+	struct settings_data *settings;
 	struct state *state = arg;
-	struct settings_data *settings = state->cmd->arg;
-	struct simple_boolean_data *data = settings->data;
 
+	settings = state->cmd->arg;
+	data = settings->data;
 	nla_put_u8(msg, BATADV_ATTR_AGGREGATED_OGMS_ENABLED, data->val);
 
 	return 0;
diff --git a/ap_isolation.c b/ap_isolation.c
index a9a5d24..470d29d 100644
--- a/ap_isolation.c
+++ b/ap_isolation.c
@@ -47,10 +47,12 @@ static int get_ap_isolation(struct state *state)
 
 static int set_attrs_ap_isolation(struct nl_msg *msg, void *arg)
 {
+	struct simple_boolean_data *data;
+	struct settings_data *settings;
 	struct state *state = arg;
-	struct settings_data *settings = state->cmd->arg;
-	struct simple_boolean_data *data = settings->data;
 
+	settings = state->cmd->arg;
+	data = settings->data;
 	nla_put_u8(msg, BATADV_ATTR_AP_ISOLATION_ENABLED, data->val);
 
 	if (state->selector == SP_VLAN)
diff --git a/bisect_iv.c b/bisect_iv.c
index 6c7de24..d4d507a 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -1147,7 +1147,8 @@ static int seqno_trace_fix_leaf(struct seqno_trace_neigh *seqno_trace_mom,
 {
 	struct seqno_trace_neigh *seqno_trace_neigh;
 	struct seqno_trace_neigh **data_ptr;
-	int i, j = 0;
+	int j = 0;
+	int i;
 
 	data_ptr = calloc(seqno_trace_old_mom->num_neighbors - 1, sizeof(*data_ptr));
 	if (!data_ptr)
@@ -1174,7 +1175,8 @@ static int seqno_trace_check_leaves(struct seqno_trace *seqno_trace,
 				    struct seqno_trace_neigh *seqno_trace_neigh_new)
 {
 	struct seqno_trace_neigh *seqno_trace_neigh_tmp;
-	int i, res;
+	int res;
+	int i;
 
 	for (i = 0; i < seqno_trace->seqno_trace_neigh.num_neighbors; i++) {
 		seqno_trace_neigh_tmp = seqno_trace->seqno_trace_neigh.seqno_trace_neigh[i];
diff --git a/bonding.c b/bonding.c
index 947f22b..bcf68e3 100644
--- a/bonding.c
+++ b/bonding.c
@@ -31,10 +31,12 @@ static int get_bonding(struct state *state)
 
 static int set_attrs_bonding(struct nl_msg *msg, void *arg)
 {
+	struct simple_boolean_data *data;
+	struct settings_data *settings;
 	struct state *state = arg;
-	struct settings_data *settings = state->cmd->arg;
-	struct simple_boolean_data *data = settings->data;
 
+	settings = state->cmd->arg;
+	data = settings->data;
 	nla_put_u8(msg, BATADV_ATTR_BONDING_ENABLED, data->val);
 
 	return 0;
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 6e883bc..af317dd 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -32,10 +32,12 @@ static int get_bridge_loop_avoidance(struct state *state)
 
 static int set_attrs_bridge_loop_avoidance(struct nl_msg *msg, void *arg)
 {
+	struct simple_boolean_data *data;
+	struct settings_data *settings;
 	struct state *state = arg;
-	struct settings_data *settings = state->cmd->arg;
-	struct simple_boolean_data *data = settings->data;
 
+	settings = state->cmd->arg;
+	data = settings->data;
 	nla_put_u8(msg, BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED, data->val);
 
 	return 0;
diff --git a/dat_cache.c b/dat_cache.c
index 4c72360..2dee27a 100644
--- a/dat_cache.c
+++ b/dat_cache.c
@@ -33,13 +33,15 @@ static const int dat_cache_mandatory[] = {
 
 static int dat_cache_callback(struct nl_msg *msg, void *arg)
 {
-	int last_seen_msecs, last_seen_secs, last_seen_mins;
 	struct nlattr *attrs[BATADV_ATTR_MAX + 1];
 	struct nlmsghdr *nlh = nlmsg_hdr(msg);
 	struct print_opts *opts = arg;
 	struct bat_host *bat_host;
 	struct genlmsghdr *ghdr;
 	struct in_addr in_addr;
+	int last_seen_msecs;
+	int last_seen_mins;
+	int last_seen_secs;
 	uint8_t *hwaddr;
 	int16_t vid;
 	char *addr;
diff --git a/distributed_arp_table.c b/distributed_arp_table.c
index 43e9fbc..c9731f2 100644
--- a/distributed_arp_table.c
+++ b/distributed_arp_table.c
@@ -32,10 +32,12 @@ static int get_distributed_arp_table(struct state *state)
 
 static int set_attrs_distributed_arp_table(struct nl_msg *msg, void *arg)
 {
+	struct simple_boolean_data *data;
+	struct settings_data *settings;
 	struct state *state = arg;
-	struct settings_data *settings = state->cmd->arg;
-	struct simple_boolean_data *data = settings->data;
 
+	settings = state->cmd->arg;
+	data = settings->data;
 	nla_put_u8(msg, BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED, data->val);
 
 	return 0;
diff --git a/elp_interval.c b/elp_interval.c
index b294eaf..7dcfa5f 100644
--- a/elp_interval.c
+++ b/elp_interval.c
@@ -81,10 +81,12 @@ static int get_elp_interval(struct state *state)
 
 static int set_attrs_elp_interval(struct nl_msg *msg, void *arg)
 {
+	struct settings_data *settings;
+	struct elp_interval_data *data;
 	struct state *state = arg;
-	struct settings_data *settings = state->cmd->arg;
-	struct elp_interval_data *data = settings->data;
 
+	settings = state->cmd->arg;
+	data = settings->data;
 	nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX, state->hif);
 	nla_put_u32(msg, BATADV_ATTR_ELP_INTERVAL, data->elp_interval);
 
diff --git a/fragmentation.c b/fragmentation.c
index 2f3d3b9..c0f84d9 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -32,10 +32,12 @@ static int get_fragmentation(struct state *state)
 
 static int set_attrs_fragmentation(struct nl_msg *msg, void *arg)
 {
+	struct simple_boolean_data *data;
+	struct settings_data *settings;
 	struct state *state = arg;
-	struct settings_data *settings = state->cmd->arg;
-	struct simple_boolean_data *data = settings->data;
 
+	settings = state->cmd->arg;
+	data = settings->data;
 	nla_put_u8(msg, BATADV_ATTR_FRAGMENTATION_ENABLED, data->val);
 
 	return 0;
diff --git a/functions.c b/functions.c
index 771b065..5e1cb40 100644
--- a/functions.c
+++ b/functions.c
@@ -135,8 +135,8 @@ static bool ether_addr_valid(const uint8_t *addr)
 int read_file(const char *full_path, int read_opt)
 {
 	int res = EXIT_FAILURE;
-	size_t len = 0;
 	FILE *fp = NULL;
+	size_t len = 0;
 
 	fp = fopen(full_path, "r");
 	if (!fp) {
@@ -580,11 +580,6 @@ struct rtnl_link_iface_data {
 
 static int query_rtnl_link_single_parse(struct nl_msg *msg, void *arg)
 {
-	static struct nla_policy link_policy[IFLA_MAX + 1] = {
-		[IFLA_LINKINFO] = { .type = NLA_NESTED },
-		[IFLA_MASTER] = { .type = NLA_U32 },
-		[IFLA_LINK] = { .type = NLA_U32 },
-	};
 	static struct nla_policy link_info_policy[IFLA_INFO_MAX + 1] = {
 		[IFLA_INFO_KIND] = { .type = NLA_STRING },
 		[IFLA_INFO_DATA] = { .type = NLA_NESTED },
@@ -592,6 +587,11 @@ static int query_rtnl_link_single_parse(struct nl_msg *msg, void *arg)
 	static struct nla_policy vlan_policy[IFLA_VLAN_MAX + 1] = {
 		[IFLA_VLAN_ID] = { .type = NLA_U16 },
 	};
+	static struct nla_policy link_policy[IFLA_MAX + 1] = {
+		[IFLA_LINKINFO] = { .type = NLA_NESTED },
+		[IFLA_MASTER] = { .type = NLA_U32 },
+		[IFLA_LINK] = { .type = NLA_U32 },
+	};
 
 	struct rtnl_link_iface_data *link_data = arg;
 	struct nlattr *li[IFLA_INFO_MAX + 1];
diff --git a/gateways.c b/gateways.c
index b0cc938..19d8373 100644
--- a/gateways.c
+++ b/gateways.c
@@ -39,8 +39,8 @@ static int gateways_callback(struct nl_msg *msg, void *arg)
 	struct print_opts *opts = arg;
 	struct bat_host *bat_host;
 	struct genlmsghdr *ghdr;
-	const char *primary_if;
 	uint32_t bandwidth_down;
+	const char *primary_if;
 	uint32_t bandwidth_up;
 	uint32_t throughput;
 	uint8_t *router;
diff --git a/genl.c b/genl.c
index d2e54c1..8a218b8 100644
--- a/genl.c
+++ b/genl.c
@@ -45,9 +45,9 @@ struct mcast_handler_args {
 
 static int mcast_family_handler(struct nl_msg *msg, void *arg)
 {
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
 	struct mcast_handler_args *grp = arg;
 	struct nlattr *tb[CTRL_ATTR_MAX + 1];
-	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
 	struct nlattr *mcgrp;
 	int rem_mcgrp;
 
diff --git a/gw_mode.c b/gw_mode.c
index 996ca08..767a7f8 100644
--- a/gw_mode.c
+++ b/gw_mode.c
@@ -154,9 +154,7 @@ static int parse_gw(struct state *state, int argc, char *argv[])
 
 static int print_gw(struct nl_msg *msg, void *arg)
 {
-	static const int mandatory[] = {
-		BATADV_ATTR_GW_MODE,
-	};
+	struct nlattr *attrs[BATADV_ATTR_MAX + 1];
 	static const int mandatory_client[] = {
 		BATADV_ATTR_ALGO_NAME,
 		BATADV_ATTR_GW_SEL_CLASS,
@@ -165,8 +163,10 @@ static int print_gw(struct nl_msg *msg, void *arg)
 		BATADV_ATTR_GW_BANDWIDTH_DOWN,
 		BATADV_ATTR_GW_BANDWIDTH_UP,
 	};
-	struct nlattr *attrs[BATADV_ATTR_MAX + 1];
 	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	static const int mandatory[] = {
+		BATADV_ATTR_GW_MODE,
+	};
 	struct genlmsghdr *ghdr;
 	int *result = arg;
 	const char *algo;
diff --git a/hop_penalty.c b/hop_penalty.c
index 11f30ae..f22d36c 100644
--- a/hop_penalty.c
+++ b/hop_penalty.c
@@ -88,10 +88,12 @@ static int get_hop_penalty_if(struct state *state)
 
 static int set_attrs_hop_penalty(struct nl_msg *msg, void *arg)
 {
+	struct settings_data *settings;
+	struct hop_penalty_data *data;
 	struct state *state = arg;
-	struct settings_data *settings = state->cmd->arg;
-	struct hop_penalty_data *data = settings->data;
 
+	settings = state->cmd->arg;
+	data = settings->data;
 	nla_put_u8(msg, BATADV_ATTR_HOP_PENALTY, data->hop_penalty);
 
 	return 0;
@@ -105,10 +107,12 @@ static int set_hop_penalty(struct state *state)
 
 static int set_attrs_hop_penalty_if(struct nl_msg *msg, void *arg)
 {
+	struct settings_data *settings;
+	struct hop_penalty_data *data;
 	struct state *state = arg;
-	struct settings_data *settings = state->cmd->arg;
-	struct hop_penalty_data *data = settings->data;
 
+	settings = state->cmd->arg;
+	data = settings->data;
 	nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX, state->hif);
 	nla_put_u8(msg, BATADV_ATTR_HOP_PENALTY, data->hop_penalty);
 
diff --git a/icmp_helper.c b/icmp_helper.c
index 459ea63..8b4fad7 100644
--- a/icmp_helper.c
+++ b/icmp_helper.c
@@ -83,7 +83,6 @@ void icmp_interface_destroy(struct icmp_interface *iface)
 
 static int icmp_interface_filter(int sock, int uid)
 {
-	struct sock_fprog filter;
 	struct sock_filter accept_icmp[] = {
 		/* load ethernet proto */
 		BPF_STMT(BPF_LD + BPF_H + BPF_ABS,
@@ -146,6 +145,7 @@ static int icmp_interface_filter(int sock, int uid)
 		BPF_STMT(BPF_RET + BPF_K,
 			 0),
 	};
+	struct sock_fprog filter;
 
 	memset(&filter, 0, sizeof(filter));
 	filter.len = sizeof(accept_icmp) / sizeof(*accept_icmp);
@@ -303,7 +303,8 @@ static void icmp_interface_unmark(void)
 
 static void icmp_interface_sweep(void)
 {
-	struct icmp_interface *iface, *safe;
+	struct icmp_interface *iface;
+	struct icmp_interface *safe;
 
 	list_for_each_entry_safe(iface, safe, &interface_list, list) {
 		if (iface->mark)
diff --git a/interface.c b/interface.c
index dc77ad4..7d3897c 100644
--- a/interface.c
+++ b/interface.c
@@ -182,8 +182,8 @@ static int count_interfaces_rtnl_parse(struct nl_msg *msg, void *arg)
 	struct count_interfaces_rtnl_arg *count_arg = arg;
 	struct nlattr *attrs[IFLA_MAX + 1];
 	struct ifinfomsg *ifm;
-	int ret;
 	int master;
+	int ret;
 
 	ifm = nlmsg_data(nlmsg_hdr(msg));
 	ret = nlmsg_parse(nlmsg_hdr(msg), sizeof(*ifm), attrs, IFLA_MAX,
diff --git a/isolation_mark.c b/isolation_mark.c
index 10ba243..cef4de0 100644
--- a/isolation_mark.c
+++ b/isolation_mark.c
@@ -22,7 +22,7 @@ static struct isolation_mark_data {
 static int parse_isolation_mark(struct state *state, int argc, char *argv[])
 {
 	struct settings_data *settings = state->cmd->arg;
-	struct isolation_mark_data *data = settings->data;
+	struct isolation_mark_data *data;
 	char *mask_ptr;
 	char buff[256];
 	uint32_t mark;
@@ -59,6 +59,7 @@ static int parse_isolation_mark(struct state *state, int argc, char *argv[])
 	if (!endptr || *endptr != '\0')
 		goto inval_format;
 
+	data = settings->data;
 	data->isolation_mask = mask;
 	/* erase bits not covered by the mask */
 	data->isolation_mark = mark & mask;
@@ -110,10 +111,12 @@ static int get_isolation_mark(struct state *state)
 
 static int set_attrs_isolation_mark(struct nl_msg *msg, void *arg)
 {
+	struct isolation_mark_data *data;
+	struct settings_data *settings;
 	struct state *state = arg;
-	struct settings_data *settings = state->cmd->arg;
-	struct isolation_mark_data *data = settings->data;
 
+	settings = state->cmd->arg;
+	data = settings->data;
 	nla_put_u32(msg, BATADV_ATTR_ISOLATION_MARK, data->isolation_mark);
 	nla_put_u32(msg, BATADV_ATTR_ISOLATION_MASK, data->isolation_mask);
 
diff --git a/list.h b/list.h
index a8bd44b..12d3ee0 100644
--- a/list.h
+++ b/list.h
@@ -247,8 +247,8 @@ static inline void list_splice(struct list_head *list,
 static inline void list_splice_tail(struct list_head *list,
 				    struct list_head *head)
 {
-	struct list_head *head_last = head->prev;
 	struct list_head *list_first = list->next;
+	struct list_head *head_last = head->prev;
 	struct list_head *list_last = list->prev;
 
 	if (list_empty(list))
@@ -628,8 +628,8 @@ static inline void hlist_add_behind(struct hlist_node *new_node,
  */
 static inline void hlist_del(struct hlist_node *node)
 {
-	struct hlist_node *next = node->next;
 	struct hlist_node **pprev = node->pprev;
+	struct hlist_node *next = node->next;
 
 	if (pprev)
 		*pprev = next;
diff --git a/main.c b/main.c
index 921b3af..da4cbb6 100644
--- a/main.c
+++ b/main.c
@@ -57,18 +57,18 @@ static void print_usage(void)
 		"meshif <netdev> ",
 		NULL,
 	};
+	static const char * const hardif_prefixes[] = {
+		"hardif <netdev> ",
+		NULL,
+	};
 	static const char * const vlan_prefixes[] = {
 		"vlan <vdev> ",
 		"meshif <netdev> vid <vid> ",
 		NULL,
 	};
-	static const char * const hardif_prefixes[] = {
-		"hardif <netdev> ",
-		NULL,
-	};
-	const struct command **p;
 	const char * const *prefixes;
 	const char * const *prefix;
+	const struct command **p;
 	char buf[64];
 	size_t i;
 
diff --git a/multicast_fanout.c b/multicast_fanout.c
index 7b8b595..97d5e0a 100644
--- a/multicast_fanout.c
+++ b/multicast_fanout.c
@@ -21,7 +21,7 @@ static struct multicast_fanout_data {
 static int parse_multicast_fanout(struct state *state, int argc, char *argv[])
 {
 	struct settings_data *settings = state->cmd->arg;
-	struct multicast_fanout_data *data = settings->data;
+	struct multicast_fanout_data *data;
 	char *endptr;
 
 	if (argc != 2) {
@@ -29,6 +29,7 @@ static int parse_multicast_fanout(struct state *state, int argc, char *argv[])
 		return -EINVAL;
 	}
 
+	data = settings->data;
 	data->multicast_fanout = strtoul(argv[1], &endptr, 0);
 	if (!endptr || *endptr != '\0') {
 		fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
@@ -72,10 +73,12 @@ static int get_multicast_fanout(struct state *state)
 
 static int set_attrs_multicast_fanout(struct nl_msg *msg, void *arg)
 {
+	struct multicast_fanout_data *data;
+	struct settings_data *settings;
 	struct state *state = arg;
-	struct settings_data *settings = state->cmd->arg;
-	struct multicast_fanout_data *data = settings->data;
 
+	settings = state->cmd->arg;
+	data = settings->data;
 	nla_put_u32(msg, BATADV_ATTR_MULTICAST_FANOUT, data->multicast_fanout);
 
 	return 0;
diff --git a/multicast_forceflood.c b/multicast_forceflood.c
index 20e1792..0fc1e87 100644
--- a/multicast_forceflood.c
+++ b/multicast_forceflood.c
@@ -53,10 +53,12 @@ static int get_multicast_forceflood(struct state *state)
 
 static int set_attrs_multicast_forceflood(struct nl_msg *msg, void *arg)
 {
+	struct simple_boolean_data *data;
+	struct settings_data *settings;
 	struct state *state = arg;
-	struct settings_data *settings = state->cmd->arg;
-	struct simple_boolean_data *data = settings->data;
 
+	settings = state->cmd->arg;
+	data = settings->data;
 	nla_put_u8(msg, BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED, data->val);
 
 	return 0;
diff --git a/multicast_mode.c b/multicast_mode.c
index a21ccd5..a960a38 100644
--- a/multicast_mode.c
+++ b/multicast_mode.c
@@ -53,10 +53,12 @@ static int get_multicast_mode(struct state *state)
 
 static int set_attrs_multicast_mode(struct nl_msg *msg, void *arg)
 {
+	struct simple_boolean_data *data;
+	struct settings_data *settings;
 	struct state *state = arg;
-	struct settings_data *settings = state->cmd->arg;
-	struct simple_boolean_data *data = settings->data;
 
+	settings = state->cmd->arg;
+	data = settings->data;
 	nla_put_u8(msg, BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED, !data->val);
 
 	return 0;
diff --git a/neighbors.c b/neighbors.c
index bed903d..8e35cb3 100644
--- a/neighbors.c
+++ b/neighbors.c
@@ -33,13 +33,14 @@ static int neighbors_callback(struct nl_msg *msg, void *arg)
 {
 	struct nlattr *attrs[BATADV_ATTR_MAX + 1];
 	struct nlmsghdr *nlh = nlmsg_hdr(msg);
-	int last_seen_msecs, last_seen_secs;
 	struct print_opts *opts = arg;
 	unsigned int throughput_mbits;
 	unsigned int throughput_kbits;
 	char ifname_buf[IF_NAMESIZE];
 	struct bat_host *bat_host;
 	struct genlmsghdr *ghdr;
+	int last_seen_msecs;
+	int last_seen_secs;
 	uint32_t ifindex;
 	uint8_t *neigh;
 	char *ifname;
diff --git a/orig_interval.c b/orig_interval.c
index 4e13016..970c752 100644
--- a/orig_interval.c
+++ b/orig_interval.c
@@ -72,10 +72,12 @@ static int get_orig_interval(struct state *state)
 
 static int set_attrs_orig_interval(struct nl_msg *msg, void *arg)
 {
+	struct orig_interval_data *data;
+	struct settings_data *settings;
 	struct state *state = arg;
-	struct settings_data *settings = state->cmd->arg;
-	struct orig_interval_data *data = settings->data;
 
+	settings = state->cmd->arg;
+	data = settings->data;
 	nla_put_u32(msg, BATADV_ATTR_ORIG_INTERVAL, data->orig_interval);
 
 	return 0;
diff --git a/sys.c b/sys.c
index 0b38677..35a026e 100644
--- a/sys.c
+++ b/sys.c
@@ -27,7 +27,7 @@
 int parse_simple_boolean(struct state *state, int argc, char *argv[])
 {
 	struct settings_data *settings = state->cmd->arg;
-	struct simple_boolean_data *data = settings->data;
+	struct simple_boolean_data *data;
 	int ret;
 
 	if (argc != 2) {
@@ -35,6 +35,7 @@ int parse_simple_boolean(struct state *state, int argc, char *argv[])
 		return -EINVAL;
 	}
 
+	data = settings->data;
 	ret = parse_bool(argv[1], &data->val);
 	if (ret < 0) {
 		fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
@@ -154,15 +155,15 @@ static void settings_usage(struct state *state)
 		"meshif <netdev> ",
 		NULL,
 	};
+	static const char * const hardif_prefixes[] = {
+		"hardif <netdev> ",
+		NULL,
+	};
 	static const char * const vlan_prefixes[] = {
 		"vlan <vdev> ",
 		"meshif <netdev> vid <vid> ",
 		NULL,
 	};
-	static const char * const hardif_prefixes[] = {
-		"hardif <netdev> ",
-		NULL,
-	};
 	const char *linestart = "Usage:";
 	const char * const *prefixes;
 	const char * const *prefix;
@@ -229,7 +230,8 @@ static int sys_write_setting(struct state *state)
 int handle_sys_setting(struct state *state, int argc, char **argv)
 {
 	struct settings_data *settings = state->cmd->arg;
-	int optchar, res = EXIT_FAILURE;
+	int res = EXIT_FAILURE;
+	int optchar;
 
 	while ((optchar = getopt(argc, argv, "h")) != -1) {
 		switch (optchar) {
diff --git a/tcpdump.c b/tcpdump.c
index c89b5a7..eb7524e 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -114,7 +114,8 @@ static void batctl_tvlv_parse_gw_v1(void *buff, ssize_t buff_len,
 				    int read_opt __maybe_unused)
 {
 	struct batadv_tvlv_gateway_data *tvlv = buff;
-	uint32_t down, up;
+	uint32_t down;
+	uint32_t up;
 
 	if (buff_len != sizeof(*tvlv)) {
 		fprintf(stderr,
@@ -590,9 +591,9 @@ static void dump_ipv6(unsigned char *packet_buff, ssize_t buff_len,
 		      int time_printed)
 {
 	struct nd_neighbor_solicit *nd_neigh_sol;
+	static const char ip_string[] = "IP6";
 	struct nd_neighbor_advert *nd_advert;
 	char nd_nas_target[INET6_ADDRSTRLEN];
-	static const char ip_string[] = "IP6";
 	char ipsrc[INET6_ADDRSTRLEN];
 	char ipdst[INET6_ADDRSTRLEN];
 	struct icmp6_hdr *icmphdr;
@@ -833,8 +834,8 @@ static void dump_vlan(unsigned char *packet_buff, ssize_t buff_len, int read_opt
 static void dump_batman_iv_ogm(unsigned char *packet_buff, ssize_t buff_len,
 			       int read_opt, int time_printed)
 {
-	struct ether_header *ether_header;
 	struct batadv_ogm_packet *batman_ogm_packet;
+	struct ether_header *ether_header;
 	ssize_t check_len;
 	ssize_t tvlv_len;
 
@@ -944,7 +945,6 @@ static void dump_batman_icmp(unsigned char *packet_buff, ssize_t buff_len,
 {
 	struct batadv_icmp_packet *icmp_packet;
 	struct batadv_icmp_tp_packet *tp;
-
 	char *name;
 
 	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct batadv_icmp_packet), "BAT ICMP");
diff --git a/throughput_override.c b/throughput_override.c
index 6c316ff..e548b1f 100644
--- a/throughput_override.c
+++ b/throughput_override.c
@@ -22,7 +22,7 @@ static struct throughput_override_data {
 static int parse_throughput_override(struct state *state, int argc, char *argv[])
 {
 	struct settings_data *settings = state->cmd->arg;
-	struct throughput_override_data *data = settings->data;
+	struct throughput_override_data *data;
 	bool ret;
 
 	if (argc != 2) {
@@ -30,6 +30,7 @@ static int parse_throughput_override(struct state *state, int argc, char *argv[]
 		return -EINVAL;
 	}
 
+	data = settings->data;
 	ret = parse_throughput(argv[1], "throughput override",
 			       &data->throughput_override);
 	if (!ret)
@@ -84,10 +85,12 @@ static int get_throughput_override(struct state *state)
 
 static int set_attrs_throughput_override(struct nl_msg *msg, void *arg)
 {
+	struct throughput_override_data *data;
+	struct settings_data *settings;
 	struct state *state = arg;
-	struct settings_data *settings = state->cmd->arg;
-	struct throughput_override_data *data = settings->data;
 
+	settings = state->cmd->arg;
+	data = settings->data;
 	nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX, state->hif);
 	nla_put_u32(msg, BATADV_ATTR_THROUGHPUT_OVERRIDE, data->throughput_override);
 
diff --git a/throughputmeter.c b/throughputmeter.c
index 4f3dc50..bfd59a5 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -67,9 +67,9 @@ static int tpmeter_nl_print_error(struct sockaddr_nl *nla __maybe_unused,
 
 static int tp_meter_result_callback(struct nl_msg *msg, void *arg)
 {
-	struct tp_result *result = arg;
 	struct nlmsghdr *nlh = nlmsg_hdr(msg);
 	struct nlattr *attrs[NUM_BATADV_ATTR];
+	struct tp_result *result = arg;
 	struct genlmsghdr *ghdr;
 	uint32_t cookie;
 
@@ -242,8 +242,8 @@ static struct nl_sock *tp_prepare_listening_sock(void)
 {
 	struct nl_sock *sock;
 	int family;
-	int ret;
 	int mcid;
+	int ret;
 
 	sock = nl_socket_alloc();
 	if (!sock)
diff --git a/transglobal.c b/transglobal.c
index f87fc65..f749e0d 100644
--- a/transglobal.c
+++ b/transglobal.c
@@ -39,7 +39,6 @@ static int transglobal_callback(struct nl_msg *msg, void *arg)
 	struct print_opts *opts = arg;
 	struct bat_host *bat_host;
 	struct genlmsghdr *ghdr;
-	char c, r, w, i, t;
 	uint8_t last_ttvn;
 	uint32_t crc32;
 	uint32_t flags;
@@ -47,6 +46,11 @@ static int transglobal_callback(struct nl_msg *msg, void *arg)
 	uint8_t *orig;
 	uint8_t ttvn;
 	int16_t vid;
+	char c;
+	char r;
+	char w;
+	char i;
+	char t;
 
 	if (!genlmsg_valid_hdr(nlh, 0)) {
 		fputs("Received invalid data from kernel.\n", stderr);

---
base-commit: 8e67af37f812ac1fa2020033342693d63b6a4756
change-id: 20260608-reverse-xmas-c2a9a1c540d6

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

