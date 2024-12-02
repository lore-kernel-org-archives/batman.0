Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBFFD10DA0
	for <batman@archiver.kernel.org>; Mon,  2 Dec 2024 06:00:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BDBF383F3D
	for <batman@archiver.kernel.org>; Mon,  2 Dec 2024 07:00:50 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1733119250;
 b=xa1TG00SVFEUX3YbczMPCsj4N7SB18wnWN0qjpCIBrhrkA4g65Ofk4FdYYtBXJpHjKih5
 YhvE6SgvhcT1gGxsx1QGQ89MShY6h+vO1gbNvdPd3w21/NWz6F8B22uV1NQJ/hmetpVvDiD
 jgc3vHmAWw4MkDViEmCdmf0zgQHSZCk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1733119250; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=s7Z04Ybjat572B7Cy42nVYWCJWK3XONqN5uoho3fGGI=;
 b=Rh+lJYo2nyFHQ3m96x8+n+IuUSIpmQAAynBso72XBqPj+GX3QU+JP63gwtTR+wLfzAWx3
 9M03tGZ+xZX00bIgA1e2hUSjEKSZbHONErywjtMWJnvC8EBZvvVBIQG1JTW3raBc7+lu6Ef
 op9rHhQ41uDKKALHtfNNRlINCnOMCFo=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5FFE880855
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  2 Dec 2024 07:00:25 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1733119225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s7Z04Ybjat572B7Cy42nVYWCJWK3XONqN5uoho3fGGI=;
	b=lGNe3rTZYfLrnxlw9diy8DyL5YM0qnbXUFiLordS5ZcYwVsb/dOys5rUvbFNk8gp+39+uh
	lcnEKGlwJdgeXUt1kMF57lnyAeWktv1U9ONW3mYh48zXJdKTHTBAyKWMUxhQEvaUfo/mVE
	JWxMKDW2VVVwq/95+yNwoZErjbslZOw=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1733119225; a=rsa-sha256;
	cv=none;
	b=Eg/6xH5M1bodwQFHnSCrsmdnQ6hRs5XRYD9kvCNVKjQFRlr2qLQUBynFfhxPEa0sbtwbPt
	HZDDoKEfkNaBFVyhhIBx16kjehYJI5z9ngi303M4HNZyL4UESTU391v557LMO+EHG0VbMi
	+uQQWX72wNy4DxEDmvelOrx+VOtLcB4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 116.203.183.178 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4BB015412C6;
	Mon,  2 Dec 2024 07:00:24 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH RFC] batctl: add vlan_dyn_max command
Date: Mon,  2 Dec 2024 07:00:19 +0100
Message-ID: <20241202060019.633-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: WAQGWZUQIB5TRPB5C6WFWATLAHX6J7FZ
X-Message-ID-Hash: WAQGWZUQIB5TRPB5C6WFWATLAHX6J7FZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WAQGWZUQIB5TRPB5C6WFWATLAHX6J7FZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This adds a vlan_dyn_max command to get and set the maximum number of
allowed learned VLANs from bridged-in clients in batman-adv.

Still TODO: Documentation in README and manpage.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
Posting this as a quick RFC for now as it probably doesn't make sense to
expose/advertise this setting yet as long as there are still issues with
a setting >0 while BLA is enabled?
---
 Makefile       |   1 +
 batman_adv.h   |   6 +++
 netlink.c      |   3 ++
 vlan_dyn_max.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 110 insertions(+)
 create mode 100644 vlan_dyn_max.c

diff --git a/Makefile b/Makefile
index 92f84e5bf012..5f6a703acc36 100755
--- a/Makefile
+++ b/Makefile
@@ -86,6 +86,7 @@ $(eval $(call add_command,translate,y))
 $(eval $(call add_command,translocal,y))
 $(eval $(call add_command,transtable_global_json,y))
 $(eval $(call add_command,transtable_local_json,y))
+$(eval $(call add_command,vlan_dyn_max,y))
 $(eval $(call add_command,vlan_json,y))
 
 MANPAGE = man/batctl.8
diff --git a/batman_adv.h b/batman_adv.h
index 9498ccb09d67..d93f5b0fbdd6 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -481,6 +481,12 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_MULTICAST_FANOUT,
 
+	/**
+	 * @BATADV_ATTR_VLAN_DYN_MAX: defines the maximum number of allowed
+	 * learned VLANs from bridged-in clients.
+	 */
+	BATADV_ATTR_VLAN_DYN_MAX,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/netlink.c b/netlink.c
index e92fa8003d3b..9cd5eca507db 100644
--- a/netlink.c
+++ b/netlink.c
@@ -231,6 +231,9 @@ struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_MULTICAST_FANOUT] = {
 		.type = NLA_U32,
 	},
+	[BATADV_ATTR_VLAN_DYN_MAX] = {
+		.type = NLA_U16,
+	},
 };
 
 int netlink_create(struct state *state)
diff --git a/vlan_dyn_max.c b/vlan_dyn_max.c
new file mode 100644
index 000000000000..4cc45360a90f
--- /dev/null
+++ b/vlan_dyn_max.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Linus Lüssing <linus.luessing@c0d3.blue>
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ */
+
+#include <errno.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <string.h>
+
+#include "main.h"
+#include "sys.h"
+
+static struct vlan_dyn_max_data {
+	uint16_t vlan_dyn_max;
+} vlan_dyn_max;
+
+static int parse_vlan_dyn_max(struct state *state, int argc, char *argv[])
+{
+	struct settings_data *settings = state->cmd->arg;
+	struct vlan_dyn_max_data *data = settings->data;
+	char *endptr;
+
+	if (argc != 2) {
+		fprintf(stderr, "Error - incorrect number of arguments (expected 1)\n");
+		return -EINVAL;
+	}
+
+	data->vlan_dyn_max = strtoul(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int print_vlan_dyn_max(struct nl_msg *msg, void *arg)
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
+	if (!attrs[BATADV_ATTR_VLAN_DYN_MAX])
+		return NL_OK;
+
+	printf("%u\n", nla_get_u16(attrs[BATADV_ATTR_VLAN_DYN_MAX]));
+
+	*result = 0;
+	return NL_STOP;
+}
+
+static int get_vlan_dyn_max(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH,
+				  NULL, print_vlan_dyn_max);
+}
+
+static int set_attrs_vlan_dyn_max(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct vlan_dyn_max_data *data = settings->data;
+
+	nla_put_u16(msg, BATADV_ATTR_VLAN_DYN_MAX, data->vlan_dyn_max);
+
+	return 0;
+}
+
+static int set_vlan_dyn_max(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH,
+				  set_attrs_vlan_dyn_max, NULL);
+}
+
+static struct settings_data batctl_settings_vlan_dyn_max = {
+	.data = &vlan_dyn_max,
+	.parse = parse_vlan_dyn_max,
+	.netlink_get = get_vlan_dyn_max,
+	.netlink_set = set_vlan_dyn_max,
+};
+
+COMMAND_NAMED(SUBCOMMAND_MIF, vlan_dyn_max, "vdm", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_settings_vlan_dyn_max,
+	      "[0..4096]        \tdisplay or modify vlan_dyn_max setting");
-- 
2.45.2

