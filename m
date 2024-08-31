Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BEFCD13DF
	for <batman@archiver.kernel.org>; Sat, 31 Aug 2024 19:46:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5231383EB8
	for <batman@archiver.kernel.org>; Sat, 31 Aug 2024 21:46:43 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1725133603;
 b=2qUSxGSYXJsezj/ul8oqBXU67urBEgVNDRrB6J7hmRmoj3Ao3UOoHJ5ru0R02VsOSn5PD
 SocTKK6tPDakwCVcdul53dRNzL3tVCi0U7LAmQDxSwbQydXn+MpzIYI2ZzEUQ+XKUwlB8Wv
 T9TW3uEhMNeVl+/9qr/H/NUW1Roty3c=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1725133603; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=zk6IQ5FGPrJ8ltNpn+7NZtmdYMHTPqcIKPkjiHUF5Z8=;
 b=CovWfngUOxpTgLqE2FXJs1ZUXTE/eAiuelZ2qcxuxTs1X4tVMNIqIOObj7UkPqvvCjEr6
 1tNSK6Nm3l5wupYnyARLyOpfmY0iT0i5e2mzaad2ZoQiO8EeEeo/p7AD4q0ornTky7dppOj
 rZ/kq5sZhJf2ejOMNfV1ZnyYwkp043U=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6184283D29
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 Aug 2024 21:45:44 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1725133544; a=rsa-sha256;
	cv=none;
	b=XN1BlH6QnGxAgUojTIe5cZ5kcp5o1h8Cg69oNAvq0zJXU/d0TpYcJlWcDtAYRQRqgJXxtc
	UG5dtMKQgnazI5s/LBHERuJ05Ylw8dEiOVP3/pdG2d2UhCwze7442d49tll6kkwpmFf1zz
	JorAKW79O3r/Jyuj3CA4cw/cFg+vOic=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 116.203.183.178 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1725133544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zk6IQ5FGPrJ8ltNpn+7NZtmdYMHTPqcIKPkjiHUF5Z8=;
	b=tiKIKLpeS+NiipgMOn+an2hn/YI+j3lTzdHKTJcs/Nahoqq+rnZCK03uTjX6QZq+GTAkYu
	V3AFqqSV0Nx3TY6BwDxDMUteNcY07LYH/ZFSz/beYs0IagdJzSAnUJPOqhlYL9oyxWlqg4
	oalGf2c2EPVZHBLOjqgKpKc7ytYZQYU=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C4D773F1BC;
	Sat, 31 Aug 2024 21:45:43 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH] batctl: add switch for setting multicast_mld_rtr_only
Date: Sat, 31 Aug 2024 21:45:40 +0200
Message-ID: <20240831194540.1952-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: 6A3MXL7ZFTV4X2JNQQ6LFTXWAHD6O7HN
X-Message-ID-Hash: 6A3MXL7ZFTV4X2JNQQ6LFTXWAHD6O7HN
X-MailFrom: linus.luessing@c0d3.blue
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6A3MXL7ZFTV4X2JNQQ6LFTXWAHD6O7HN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This patch adds an option for the new multicast_mld_rtr_only setting in
batman-adv.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 Makefile                 |  1 +
 README.rst               | 10 +++++
 batman_adv.h             |  9 +++++
 event.c                  |  4 ++
 man/batctl.8             | 18 +++++++++
 multicast_mld_rtr_only.c | 83 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 125 insertions(+)
 create mode 100644 multicast_mld_rtr_only.c

diff --git a/Makefile b/Makefile
index c1212c444971..9e6f535c7816 100755
--- a/Makefile
+++ b/Makefile
@@ -66,6 +66,7 @@ $(eval $(call add_command,mesh_json,y))
 $(eval $(call add_command,multicast_fanout,y))
 $(eval $(call add_command,multicast_forceflood,y))
 $(eval $(call add_command,multicast_mode,y))
+$(eval $(call add_command,multicast_mld_rtr_only,y))
 $(eval $(call add_command,neighbors,y))
 $(eval $(call add_command,neighbors_json,y))
 $(eval $(call add_command,network_coding,y))
diff --git a/README.rst b/README.rst
index 3495fba02e0e..63b16b0f66af 100644
--- a/README.rst
+++ b/README.rst
@@ -669,6 +669,16 @@ Usage::
   batctl multicast_forceflood|mff [0|1]
 
 
+batctl multicast_mld_rtr_only
+-----------------------------
+
+display or modify the multicast MLD router only setting
+
+Usage::
+
+  batctl multicast_mld_rtr_only|mro [0|1]
+
+
 batctl network_coding
 ---------------------
 
diff --git a/batman_adv.h b/batman_adv.h
index 35dc016c9bb4..11cd170036ff 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -481,6 +481,15 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_MULTICAST_FANOUT,
 
+	/**
+	 * @BATADV_ATTR_MULTICAST_MLD_RTR_ONLY_ENABLED: defines how IGMP/MLD
+	 * reports are forwarded in the mesh. If set to non-zero then IGMP/MLD
+	 * reports are only forwarded to detected multicast routers. If set to
+	 * zero then they are flooded instead.
+	 * Warning: The former is experimental and potentially unsafe!
+	 */
+	BATADV_ATTR_MULTICAST_MLD_RTR_ONLY_ENABLED,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/event.c b/event.c
index 274f99fcb65a..14700ea57ae0 100644
--- a/event.c
+++ b/event.c
@@ -283,6 +283,10 @@ static void event_parse_set_mesh(struct nlattr **attrs)
 		printf("* multicast_forceflood %s\n",
 		       u8_to_boolstr(attrs[BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED]));
 
+	if (attrs[BATADV_ATTR_MULTICAST_MLD_RTR_ONLY_ENABLED])
+		printf("* multicast_forceflood %s\n",
+		       u8_to_boolstr(attrs[BATADV_ATTR_MULTICAST_MLD_RTR_ONLY_ENABLED]));
+
 	if (attrs[BATADV_ATTR_NETWORK_CODING_ENABLED])
 		printf("* network_coding %s\n",
 		       u8_to_boolstr(attrs[BATADV_ATTR_NETWORK_CODING_ENABLED]));
diff --git a/man/batctl.8 b/man/batctl.8
index b5be0b801708..9d830907ac7f 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -341,6 +341,24 @@ disable multicast forceflood. This setting defines whether multicast optimizatio
 flooding of multicast packets. If set to non-zero then all nodes in the mesh are going to use classic flooding for any
 multicast packet with no optimizations.
 .TP
+[\fBmeshif\fP \fInetdev\fP] \fBmulticast_mld_rtr_only\fP|\fBmro\fP [\fI0\fP|\fI1\fP]
+If no parameter is given the current multicast MLD router only setting is displayed. Otherwise the parameter is used to
+set the IGMP/MLD report forwarding behaviour. If enabled then MLD reports are forwarded to detected multicast routers only.
+If disabled then they are flooded instead.
+
+.br
+.br
+Warning: Enabling this is experimental and potentially unsafe!
+
+.br
+.br
+If the IGMP/MLD querier is configured directly on the bridge on top of
+bat0. But there is no multicast router on or behind this node. Then this
+bridge will be unable to detect multicast listeners on/behind other
+nodes which have the MLD-RTR-ONLY setting enabled. (A workaround for this
+can then in turn be to set multicast_router=2 on the bat0 bridge port
+on the node with the IGMP/MLD querier.)
+.TP
 [\fBmeshif\fP \fInetdev\fP] \fBnetwork_coding\fP|\fBnc\fP [\fI0\fP|\fI1\fP]
 If no parameter is given the current network coding mode setting is displayed. Otherwise the parameter is used to enable or
 disable network coding.
diff --git a/multicast_mld_rtr_only.c b/multicast_mld_rtr_only.c
new file mode 100644
index 000000000000..599f96fb2375
--- /dev/null
+++ b/multicast_mld_rtr_only.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Linus Lüssing <linus.luessing@c0d3.blue>
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ */
+
+#include "main.h"
+
+#include <errno.h>
+#include <linux/genetlink.h>
+#include <netlink/genl/genl.h>
+
+#include "batman_adv.h"
+#include "netlink.h"
+#include "sys.h"
+
+static struct simple_boolean_data multicast_mld_rtr_only;
+
+static int print_multicast_mld_rtr_only(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX + 1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct genlmsghdr *ghdr;
+	int *result = arg;
+
+	if (!genlmsg_valid_hdr(nlh, 0))
+		return NL_OK;
+
+	ghdr = nlmsg_data(nlh);
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		return NL_OK;
+	}
+
+	if (!attrs[BATADV_ATTR_MULTICAST_MLD_RTR_ONLY_ENABLED])
+		return NL_OK;
+
+	printf("%s\n", nla_get_u8(attrs[BATADV_ATTR_MULTICAST_MLD_RTR_ONLY_ENABLED]) ? "enabled" : "disabled");
+
+	*result = 0;
+	return NL_STOP;
+}
+
+static int get_multicast_mld_rtr_only(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH,
+				  NULL, print_multicast_mld_rtr_only);
+}
+
+static int set_attrs_multicast_mld_rtr_only(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct simple_boolean_data *data = settings->data;
+
+	if (data->val)
+		printf("Warning: MLD-RTR-ONLY is experimental and has known, broken scenarios\n");
+
+	nla_put_u8(msg, BATADV_ATTR_MULTICAST_MLD_RTR_ONLY_ENABLED, data->val);
+
+	return 0;
+}
+
+static int set_multicast_mld_rtr_only(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH,
+				  set_attrs_multicast_mld_rtr_only, NULL);
+}
+
+static struct settings_data batctl_settings_multicast_mld_rtr_only = {
+	.data = &multicast_mld_rtr_only,
+	.parse = parse_simple_boolean,
+	.netlink_get = get_multicast_mld_rtr_only,
+	.netlink_set = set_multicast_mld_rtr_only,
+};
+
+COMMAND_NAMED(SUBCOMMAND_MIF, multicast_mld_rtr_only, "mro", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_settings_multicast_mld_rtr_only,
+	      "[0|1]             \tdisplay or modify multicast_mld_rtr_only setting");
-- 
2.45.2

