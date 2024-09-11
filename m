Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD96EE020B
	for <batman@archiver.kernel.org>; Wed, 11 Sep 2024 05:19:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 76E4B83F6A
	for <batman@archiver.kernel.org>; Wed, 11 Sep 2024 07:18:59 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1726031939;
 b=f3uqVnqprdn5ITc/PHi2tp4vQSwqv+J2i9V8nlP7ekubiAXVThWj6SpQ7T6VeE853v092
 MevKp/hOwyXnNCRPDEWlY9RD4835d3vUpjyEhH5AKw/8bPaKhV9w9oZbThksl+LrN6AvkKj
 UHcuswGznexOqS+pHu2mZpHmhIxurb4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1726031939; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PTr/1/qRS+hcVmsG5wyxGjVb3QYK1khd4vPIN5eQ1+A=;
 b=XoC/m82HMqmy0pCn4LTnC2AwuZVEHmJFMwHPfo6TEBQm8jXhcGmy/ZQO35wAFrSzee52F
 gECbVOXkEbs5rHguePY8hy6Z5jdrC/HTW7D2ZoldphMxCMhhXQkLrXBzdFCTd9GncAo37xR
 Sn5KUCJOBOQuSJ/k6Gx7drRU/Aju+OE=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CDABC801B9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 11 Sep 2024 07:18:19 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1726031899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PTr/1/qRS+hcVmsG5wyxGjVb3QYK1khd4vPIN5eQ1+A=;
	b=YCy3DLhTNcpAl32ywVkl1pgFWijFMtPUdoE5bnI6UJtgWrKPciB4k1sbBWct8Vhl047JaG
	h0D2VlCnukbTZEYVOPmKUpm2KKZJOdMhAhmPyvt0MILnn46CUCtu7awfeVR9ndtVCXyBik
	TNzVGvs8K2LBz9PULvXZ9MPqMAZF6Ug=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 116.203.183.178 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1726031899; a=rsa-sha256;
	cv=none;
	b=3mVmv2imCY/5TkfxzNIFaKmWRCi4vvxJWWX9SheAzwyp1IMcumUlJpM+GTL1yeIO+Ew9gX
	qyRscr1xEwcL8M9A+V64bLL/8mJXOGGIBgZkb6bliAMTBtMr08Kq8vBS8cFKuSsK6BOJ4S
	noy2aydc042Tw4nqJkyNjGMZrrcjmy0=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9AEE73F4E1;
	Wed, 11 Sep 2024 07:18:18 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH v2] batctl: add dat_dht command
Date: Wed, 11 Sep 2024 07:18:13 +0200
Message-ID: <20240911051813.23550-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: RUHGHIRAMOR55EUL4D5BPODQGYAG3MLK
X-Message-ID-Hash: RUHGHIRAMOR55EUL4D5BPODQGYAG3MLK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RUHGHIRAMOR55EUL4D5BPODQGYAG3MLK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This adds a dat_dht command to query the DHT part of DAT
in batman-adv.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---

Changelog v2:
- rebased to current main branch:
  -> removed now obsolete debugfs code

 Makefile        |   2 +
 README.rst      |  27 +++++++++-
 batadv_packet.h |   4 +-
 batman_adv.h    |   5 ++
 dat_cache.c     |   2 +-
 dat_dht.c       | 131 ++++++++++++++++++++++++++++++++++++++++++++++++
 dat_dht_json.c  |  20 ++++++++
 man/batctl.8    |   6 +++
 8 files changed, 194 insertions(+), 3 deletions(-)
 create mode 100644 dat_dht.c
 create mode 100644 dat_dht_json.c

diff --git a/Makefile b/Makefile
index c1212c444971..92f84e5bf012 100755
--- a/Makefile
+++ b/Makefile
@@ -47,6 +47,8 @@ $(eval $(call add_command,bridge_loop_avoidance,y))
 $(eval $(call add_command,claimtable,y))
 $(eval $(call add_command,dat_cache,y))
 $(eval $(call add_command,dat_cache_json,y))
+$(eval $(call add_command,dat_dht,y))
+$(eval $(call add_command,dat_dht_json,y))
 $(eval $(call add_command,distributed_arp_table,y))
 $(eval $(call add_command,elp_interval,y))
 $(eval $(call add_command,event,y))
diff --git a/README.rst b/README.rst
index 3495fba02e0e..dc1852068e0d 100644
--- a/README.rst
+++ b/README.rst
@@ -278,7 +278,32 @@ Usage::
 
 Example::
 
-  Distributed ARP Table (bat0):
+  Distributed ARP Table Cache (bat0):
+            IPv4             MAC           last-seen
+   *     172.100.0.1 b6:9b:d0:ea:b1:13      0:00
+
+where
+
+IPv4:
+  is the IP address of a client in the mesh network
+MAC:
+  is the MAC address associated to that IP
+last-seen:
+  is the amount of time since last refresh of this entry
+
+
+batctl dat_dht
+=================
+
+display the local D.A.T. DHT
+
+Usage::
+
+  batctl dat_dht|dd
+
+Example::
+
+  Distributed ARP Table DHT (bat0):
             IPv4             MAC           last-seen
    *     172.100.0.1 b6:9b:d0:ea:b1:13      0:00
 
diff --git a/batadv_packet.h b/batadv_packet.h
index 6e25753015df..93df068b00f3 100644
--- a/batadv_packet.h
+++ b/batadv_packet.h
@@ -60,13 +60,15 @@ enum batadv_packettype {
  * @BATADV_P_DATA: user payload
  * @BATADV_P_DAT_DHT_GET: DHT request message
  * @BATADV_P_DAT_DHT_PUT: DHT store message
- * @BATADV_P_DAT_CACHE_REPLY: ARP reply generated by DAT
+ * @BATADV_P_DAT_CACHE_REPLY: deprecated: use BATADV_P_DAT_DHT_REPLY instead
+ * @BATADV_P_DAT_DHT_REPLY: ARP reply generated by DAT
  */
 enum batadv_subtype {
 	BATADV_P_DATA			= 0x01,
 	BATADV_P_DAT_DHT_GET		= 0x02,
 	BATADV_P_DAT_DHT_PUT		= 0x03,
 	BATADV_P_DAT_CACHE_REPLY	= 0x04,
+	BATADV_P_DAT_DHT_REPLY          = 0x04,
 };
 
 /* this file is included by batctl which needs these defines */
diff --git a/batman_adv.h b/batman_adv.h
index 35dc016c9bb4..9498ccb09d67 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -613,6 +613,11 @@ enum batadv_nl_commands {
 	 */
 	BATADV_CMD_SET_VLAN,
 
+	/**
+	 * @BATADV_CMD_GET_DAT_DHT: Query list of DAT DHT entries
+	 */
+	BATADV_CMD_GET_DAT_DHT,
+
 	/* add new commands above here */
 
 	/**
diff --git a/dat_cache.c b/dat_cache.c
index 8d471718e4b3..d34375563aad 100644
--- a/dat_cache.c
+++ b/dat_cache.c
@@ -106,7 +106,7 @@ static int netlink_print_dat_cache(struct state *state, char *orig_iface,
 	char *header;
 	int ret;
 
-	ret = asprintf(&header, "Distributed ARP Table (%s):\n%s\n",
+	ret = asprintf(&header, "Distributed ARP Table Cache (%s):\n%s\n",
 		       state->mesh_iface,
 		       "          IPv4             MAC        VID   last-seen");
 
diff --git a/dat_dht.c b/dat_dht.c
new file mode 100644
index 000000000000..b9619ec00a73
--- /dev/null
+++ b/dat_dht.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner <mareklindner@neomailbox.ch>
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ */
+
+#include <arpa/inet.h>
+#include <netinet/if_ether.h>
+#include <netinet/in.h>
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/ctrl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <sys/socket.h>
+
+#include "batadv_packet.h"
+#include "batman_adv.h"
+#include "bat-hosts.h"
+#include "debug.h"
+#include "functions.h"
+#include "main.h"
+#include "netlink.h"
+
+static const int dat_dht_mandatory[] = {
+	BATADV_ATTR_DAT_CACHE_IP4ADDRESS,
+	BATADV_ATTR_DAT_CACHE_HWADDRESS,
+	BATADV_ATTR_DAT_CACHE_VID,
+	BATADV_ATTR_LAST_SEEN_MSECS,
+};
+
+static int dat_dht_callback(struct nl_msg *msg, void *arg)
+{
+	int last_seen_msecs, last_seen_secs, last_seen_mins;
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	struct genlmsghdr *ghdr;
+	struct in_addr in_addr;
+	uint8_t *hwaddr;
+	int16_t vid;
+	char *addr;
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_DAT_DHT)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, dat_dht_mandatory,
+				    ARRAY_SIZE(dat_dht_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	in_addr.s_addr = nla_get_u32(attrs[BATADV_ATTR_DAT_CACHE_IP4ADDRESS]);
+	addr = inet_ntoa(in_addr);
+	hwaddr = nla_data(attrs[BATADV_ATTR_DAT_CACHE_HWADDRESS]);
+	vid = nla_get_u16(attrs[BATADV_ATTR_DAT_CACHE_VID]);
+
+	last_seen_msecs = nla_get_u32(attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
+	last_seen_mins = last_seen_msecs / 60000;
+	last_seen_msecs = last_seen_msecs % 60000;
+	last_seen_secs = last_seen_msecs / 1000;
+
+	if (opts->read_opt & MULTICAST_ONLY && !(addr[0] & 0x01))
+		return NL_OK;
+
+	if (opts->read_opt & UNICAST_ONLY && (addr[0] & 0x01))
+		return NL_OK;
+
+	printf(" * %15s ", addr);
+
+	bat_host = bat_hosts_find_by_mac((char *)hwaddr);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+		       hwaddr[0], hwaddr[1], hwaddr[2],
+		       hwaddr[3], hwaddr[4], hwaddr[5]);
+	else
+		printf("%17s ", bat_host->name);
+
+	printf("%4i %6i:%02i\n",
+	       BATADV_PRINT_VID(vid), last_seen_mins, last_seen_secs);
+
+	return NL_OK;
+}
+
+static int netlink_print_dat_dht(struct state *state, char *orig_iface,
+				 int read_opts, float orig_timeout,
+				 float watch_interval)
+{
+	char *header;
+	int ret;
+
+	ret = asprintf(&header, "Distributed ARP Table DHT (%s):\n%s\n",
+		       state->mesh_iface,
+		       "          IPv4             MAC        VID   last-seen");
+
+	if (ret < 0)
+		return ret;
+
+	ret = netlink_print_common(state, orig_iface, read_opts,
+				   orig_timeout, watch_interval, header,
+				   BATADV_CMD_GET_DAT_DHT,
+				   dat_dht_callback);
+
+	free(header);
+	return ret;
+}
+
+static struct debug_table_data batctl_debug_table_dat_dht = {
+	.netlink_fn = netlink_print_dat_dht,
+};
+
+COMMAND_NAMED(DEBUGTABLE, dat_dht, "dd", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_table_dat_dht, "");
diff --git a/dat_dht_json.c b/dat_dht_json.c
new file mode 100644
index 000000000000..43eb3c586d74
--- /dev/null
+++ b/dat_dht_json.c
@@ -0,0 +1,20 @@
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
+#include "genl_json.h"
+
+static struct json_query_data batctl_json_query_dat_dht = {
+	.nlm_flags = NLM_F_DUMP,
+	.cmd = BATADV_CMD_GET_DAT_DHT,
+};
+
+COMMAND_NAMED(JSON_MIF, dat_dht_json, "ddj", handle_json_query,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_json_query_dat_dht, "");
diff --git a/man/batctl.8 b/man/batctl.8
index b5be0b801708..417f5412c885 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -388,6 +388,10 @@ The local and global translation tables also support the "\-u" and "\-m" option
 [\fBmeshif\fP \fInetdev\fP] \fBdat_cache\fP|\fBdc\fP [\fB-n\fP] [\fB-H\fP] [\fB-w\fP \fIinterval\fP]
 (compile time option)
 .TP
+.TP
+[\fBmeshif\fP \fInetdev\fP] \fBdat_dht\fP|\fBdd\fP [\fB-n\fP] [\fB-H\fP] [\fB-w\fP \fIinterval\fP]
+(compile time option)
+.TP
 [\fBmeshif\fP \fInetdev\fP] \fBgateways\fP|\fBgwl\fP [\fB-n\fP] [\fB-H\fP] [\fB-w\fP \fIinterval\fP]
 .TP
 [\fBmeshif\fP \fInetdev\fP] \fBmcast_flags\fP|\fBmf\fP [\fB-n\fP] [\fB-H\fP] [\fB-w\fP \fIinterval\fP]
@@ -416,6 +420,8 @@ the freeform debug tables or the native netlink messages.
 .TP
 [\fBmeshif\fP \fInetdev\fP] \fBdat_cache_json\fP|\fBdcj\fP
 .TP
+[\fBmeshif\fP \fInetdev\fP] \fBdat_dht_json\fP|\fBdcj\fP
+.TP
 [\fBmeshif\fP \fInetdev\fP] \fBgateways_json\fP|\fBgwj\fP
 .TP
 \fBhardif\fP \fIhardif\fP \fBhardif_json\fP|\fBhj\fP
-- 
2.45.2

