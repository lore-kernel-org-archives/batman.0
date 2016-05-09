Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 09 May 2016 20:50:58 +0200
Message-ID: <1495261.OkJHpVOaGk@bentobox>
In-Reply-To: <1680132.z76VCK1c2R@bentobox>
References: <1462817239-18104-1-git-send-email-andrew@lunn.ch>
 <1680132.z76VCK1c2R@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2025851.eOe5rBGXAt";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 00/12] netns and netlink support
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, Andrew Lunn <andrew@lunn.ch>

--nextPart2025851.eOe5rBGXAt
Content-Type: multipart/mixed; boundary="nextPart1707506.UTlYUNyO3a"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart1707506.UTlYUNyO3a
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 09 May 2016 20:29:21 Sven Eckelmann wrote:
> On Monday 09 May 2016 20:07:07 Andrew Lunn wrote:
> > This patchset completes netns support, by disabling debugfs entries
> > when not in the default name space, and correctly handling interface
> > stack loops when the parent is in a different name space.
> > 
> > It additionally adds netlink support for most of the information found
> > in debugfs, and is netns awaire.
> 
> Attached is a tarball with the v4 version rebased on the two initial patches
> from the tp_meter patchset. The patches include many TODOs in the kernel-doc
> which should be replaced with actual docs.
> 
> The batctl patch was not yet rebased.

Just tried it and it is not really a big thing to rebase batctl. I have again
taken the initial two patches of the tp_meter patchset.

I hope this helps to reduce the conflicts (even when not resolving it
completely) between the tp_meter and the netlink patchset.

Kind regards,
	Sven
=2D-nextPart1707506.UTlYUNyO3a
Content-Disposition: attachment; filename="andrew_netlink-ecsv_netlink-batctl.diff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="andrew_netlink-ecsv_netlink-batctl.diff"

diff --git a/Makefile b/Makefile
index 60795f7..3fa21f4 100755
=2D-- a/Makefile
+++ b/Makefile
@@ -24,7 +24,20 @@ export CONFIG_BATCTL_BISECT=n
 
 # batctl build
 BINARY_NAME = batctl
=2DOBJ = main.o bat-hosts.o functions.o sys.o debug.o ping.o traceroute.o tcpdump.o  hash.o debugfs.o ioctl.o list-batman.o translate.o netlink.o
+OBJ += bat-hosts.o
+OBJ += debugfs.o
+OBJ += debug.o
+OBJ += functions.o
+OBJ += hash.o
+OBJ += ioctl.o
+OBJ += list-batman.o
+OBJ += main.o
+OBJ += netlink.o
+OBJ += ping.o
+OBJ += sys.o
+OBJ += tcpdump.o
+OBJ += traceroute.o
+OBJ += translate.o
 OBJ_BISECT = bisect_iv.o
 MANPAGE = man/batctl.8
 
diff --git a/batman_adv.h b/batman_adv.h
index 6a97a2c..4c8e526 100644
=2D-- a/batman_adv.h
+++ b/batman_adv.h
@@ -56,7 +56,44 @@ enum batadv_tt_client_flags {
 	BATADV_TT_CLIENT_TEMP	 = (1 << 11),
 };
 
=2Denum {
+/**
+ * enum batadv_nl_attrs - batman-adv netlink attributes
+ *
+ * @BATADV_ATTR_UNSPEC: unspecified attribute to catch errors
+ * @BATADV_ATTR_VERSION: batman-adv version string
+ * @BATADV_ATTR_ALGO_NAME: name of routing algorithm
+ * @BATADV_ATTR_MESH_IFINDEX: index of the batman-adv interface
+ * @BATADV_ATTR_MESH_IFNAME: name of the batman-adv interface
+ * @BATADV_ATTR_MESH_ADDRESS: mac address of the batman-adv interface
+ * @BATADV_ATTR_HARD_IFINDEX: index of the non-batman-adv interface
+ * @BATADV_ATTR_HARD_IFNAME: name of the non-batman-adv interface
+ * @BATADV_ATTR_HARD_ADDRESS: mac address of the non-batman-adv interface
+ * @BATADV_ATTR_ACTIVE: TODO
+ * @BATADV_ATTR_ORIG_ADDRESS: TODO
+ * @BATADV_ATTR_TT_ADDRESS: TODO
+ * @BATADV_ATTR_TT_TTVN: TODO
+ * @BATADV_ATTR_TT_LAST_TTVN: TODO
+ * @BATADV_ATTR_TT_CRC32: TODO
+ * @BATADV_ATTR_TT_VID: TODO
+ * @BATADV_ATTR_TT_FLAGS: TODO
+ * @BATADV_ATTR_FLAG_BEST: TODO
+ * @BATADV_ATTR_LAST_SEEN_MSECS: TODO
+ * @BATADV_ATTR_NEIGH_ADDRESS: TODO
+ * @BATADV_ATTR_TQ: TODO
+ * @BATADV_ATTR_THROUGHPUT: TODO
+ * @BATADV_ATTR_BANDWIDTH_UP: TODO
+ * @BATADV_ATTR_BANDWIDTH_DOWN: TODO
+ * @BATADV_ATTR_ROUTER: TODO
+ * @BATADV_ATTR_BLA_OWN: TODO
+ * @BATADV_ATTR_BLA_ADDRESS: TODO
+ * @BATADV_ATTR_BLA_VID: TODO
+ * @BATADV_ATTR_BLA_BACKBONE: TODO
+ * @BATADV_ATTR_BLA_CRC: TODO
+ * @__BATADV_ATTR_AFTER_LAST: internal use
+ * @NUM_BATADV_ATTR: total number of batadv_nl_attrs available
+ * @BATADV_ATTR_MAX: highest attribute number currently defined
+ */
+enum batadv_nl_attrs {
 	BATADV_ATTR_UNSPEC,
 	BATADV_ATTR_VERSION,
 	BATADV_ATTR_ALGO_NAME,
@@ -87,15 +124,32 @@ enum {
 	BATADV_ATTR_BLA_VID,
 	BATADV_ATTR_BLA_BACKBONE,
 	BATADV_ATTR_BLA_CRC,
=2D	__BATADV_ATTR_MAX,
+	/* add attributes above here, update the policy in netlink.c */
+	__BATADV_ATTR_AFTER_LAST,
+	NUM_BATADV_ATTR = __BATADV_ATTR_AFTER_LAST,
+	BATADV_ATTR_MAX = __BATADV_ATTR_AFTER_LAST - 1
 };
 
=2D#define BATADV_ATTR_MAX (__BATADV_ATTR_MAX - 1)
=2D
=2Denum {
+/**
+ * enum batadv_nl_commands - supported batman-adv netlink commands
+ *
+ * @BATADV_CMD_UNSPEC: unspecified command to catch errors
+ * @BATADV_CMD_GET_MESH_INFO: Query basic information about batman-adv device
+ * @BATADV_CMD_GET_ROUTING_ALGOS: TODO
+ * @BATADV_CMD_GET_HARDIFS: TODO
+ * @BATADV_CMD_GET_TRANSTABLE_LOCAL: TODO
+ * @BATADV_CMD_GET_TRANSTABLE_GLOBAL: TODO
+ * @BATADV_CMD_GET_ORIGINATORS: TODO
+ * @BATADV_CMD_GET_NEIGHBORS: TODO
+ * @BATADV_CMD_GET_GATEWAYS: TODO
+ * @BATADV_CMD_GET_BLA_CLAIM: TODO
+ * @__BATADV_CMD_AFTER_LAST: internal use
+ * @BATADV_CMD_MAX: highest used command number
+ */
+enum batadv_nl_commands {
 	BATADV_CMD_UNSPEC,
=2D	BATADV_CMD_GET_ROUTING_ALGOS,
 	BATADV_CMD_GET_MESH_INFO,
+	BATADV_CMD_GET_ROUTING_ALGOS,
 	BATADV_CMD_GET_HARDIFS,
 	BATADV_CMD_GET_TRANSTABLE_LOCAL,
 	BATADV_CMD_GET_TRANSTABLE_GLOBAL,
@@ -103,9 +157,9 @@ enum {
 	BATADV_CMD_GET_NEIGHBORS,
 	BATADV_CMD_GET_GATEWAYS,
 	BATADV_CMD_GET_BLA_CLAIM,
=2D	__BATADV_CMD_MAX,
+	/* add new commands above here */
+	__BATADV_CMD_AFTER_LAST,
+	BATADV_CMD_MAX = __BATADV_CMD_AFTER_LAST - 1
 };
 
=2D#define BATADV_CMD_MAX (__BATADV_CMD_MAX - 1)
=2D
 #endif /* _UAPI_LINUX_BATMAN_ADV_H_ */
diff --git a/netlink.c b/netlink.c
index e09166c..de2fd8a 100644
=2D-- a/netlink.c
+++ b/netlink.c
@@ -1,3 +1,27 @@
+/*
+ * Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
+ *
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#include "netlink.h"
+#include "main.h"
+
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
@@ -23,7 +47,7 @@ struct print_opts {
 	float watch_interval;
 };
 
=2Dstatic struct nla_policy policy[BATADV_ATTR_MAX+1] = {
+static struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_VERSION]		= { .type = NLA_STRING },
 	[BATADV_ATTR_ALGO_NAME]		= { .type = NLA_STRING },
 	[BATADV_ATTR_MESH_IFINDEX]	= { .type = NLA_U32 },
@@ -145,7 +169,7 @@ static int info_callback(struct nl_msg *msg, void *arg)
 		return NL_OK;
 
 	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
=2D		      genlmsg_len(ghdr), policy)) {
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
 		fputs("Received invalid data from kernel.\n", stderr);
 		exit(1);
 	}
@@ -247,7 +271,7 @@ static int routing_algos_callback(struct nl_msg *msg, void *arg __unused)
 		return NL_OK;
 
 	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
=2D		      genlmsg_len(ghdr), policy)) {
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
 		fputs("Received invalid data from kernel.\n", stderr);
 		exit(1);
 	}
@@ -336,7 +360,7 @@ static int originators_callback(struct nl_msg *msg, void *arg)
 		return NL_OK;
 
 	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
=2D		      genlmsg_len(ghdr), policy)) {
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
 		fputs("Received invalid data from kernel.\n", stderr);
 		exit(1);
 	}
@@ -470,7 +494,7 @@ static int neighbors_callback(struct nl_msg *msg, void *arg)
 		return NL_OK;
 
 	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
=2D		      genlmsg_len(ghdr), policy)) {
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
 		fputs("Received invalid data from kernel.\n", stderr);
 		exit(1);
 	}
@@ -561,7 +585,7 @@ static int transglobal_callback(struct nl_msg *msg, void *arg)
 		return NL_OK;
 
 	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
=2D		      genlmsg_len(ghdr), policy)) {
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
 		fputs("Received invalid data from kernel.\n", stderr);
 		exit(1);
 	}
@@ -657,7 +681,7 @@ static int translocal_callback(struct nl_msg *msg, void *arg)
 		return NL_OK;
 
 	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
=2D		      genlmsg_len(ghdr), policy)) {
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
 		fputs("Received invalid data from kernel.\n", stderr);
 		exit(1);
 	}
@@ -757,7 +781,7 @@ static int gateways_callback(struct nl_msg *msg, void *arg)
 		return NL_OK;
 
 	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
=2D		      genlmsg_len(ghdr), policy)) {
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
 		fputs("Received invalid data from kernel.\n", stderr);
 		exit(1);
 	}
@@ -836,7 +860,7 @@ static int bla_claim_callback(struct nl_msg *msg, void *arg)
 		return NL_OK;
 
 	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
=2D		      genlmsg_len(ghdr), policy)) {
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
 		fputs("Received invalid data from kernel.\n", stderr);
 		exit(1);
 	}

=2D-nextPart1707506.UTlYUNyO3a
Content-Disposition: attachment; filename="rebased_split_netlink-batctl.tar.gz"
Content-Transfer-Encoding: base64
Content-Type: application/x-compressed-tar; name="rebased_split_netlink-batctl.tar.gz"

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

=2D-nextPart1707506.UTlYUNyO3a--
This is a multi-part message in MIME format.

--nextPart1707506.UTlYUNyO3a
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 09 May 2016 20:29:21 Sven Eckelmann wrote:
> On Monday 09 May 2016 20:07:07 Andrew Lunn wrote:
> > This patchset completes netns support, by disabling debugfs entries
> > when not in the default name space, and correctly handling interface
> > stack loops when the parent is in a different name space.
> > 
> > It additionally adds netlink support for most of the information found
> > in debugfs, and is netns awaire.
> 
> Attached is a tarball with the v4 version rebased on the two initial patches
> from the tp_meter patchset. The patches include many TODOs in the kernel-doc
> which should be replaced with actual docs.
> 
> The batctl patch was not yet rebased.

Just tried it and it is not really a big thing to rebase batctl. I have again
taken the initial two patches of the tp_meter patchset.

I hope this helps to reduce the conflicts (even when not resolving it
completely) between the tp_meter and the netlink patchset.

Kind regards,
	Sven
--nextPart1707506.UTlYUNyO3a
Content-Disposition: attachment; filename="andrew_netlink-ecsv_netlink-batctl.diff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="andrew_netlink-ecsv_netlink-batctl.diff"

diff --git a/Makefile b/Makefile
index 60795f7..3fa21f4 100755
--- a/Makefile
+++ b/Makefile
@@ -24,7 +24,20 @@ export CONFIG_BATCTL_BISECT=n
 
 # batctl build
 BINARY_NAME = batctl
-OBJ = main.o bat-hosts.o functions.o sys.o debug.o ping.o traceroute.o tcpdump.o  hash.o debugfs.o ioctl.o list-batman.o translate.o netlink.o
+OBJ += bat-hosts.o
+OBJ += debugfs.o
+OBJ += debug.o
+OBJ += functions.o
+OBJ += hash.o
+OBJ += ioctl.o
+OBJ += list-batman.o
+OBJ += main.o
+OBJ += netlink.o
+OBJ += ping.o
+OBJ += sys.o
+OBJ += tcpdump.o
+OBJ += traceroute.o
+OBJ += translate.o
 OBJ_BISECT = bisect_iv.o
 MANPAGE = man/batctl.8
 
diff --git a/batman_adv.h b/batman_adv.h
index 6a97a2c..4c8e526 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -56,7 +56,44 @@ enum batadv_tt_client_flags {
 	BATADV_TT_CLIENT_TEMP	 = (1 << 11),
 };
 
-enum {
+/**
+ * enum batadv_nl_attrs - batman-adv netlink attributes
+ *
+ * @BATADV_ATTR_UNSPEC: unspecified attribute to catch errors
+ * @BATADV_ATTR_VERSION: batman-adv version string
+ * @BATADV_ATTR_ALGO_NAME: name of routing algorithm
+ * @BATADV_ATTR_MESH_IFINDEX: index of the batman-adv interface
+ * @BATADV_ATTR_MESH_IFNAME: name of the batman-adv interface
+ * @BATADV_ATTR_MESH_ADDRESS: mac address of the batman-adv interface
+ * @BATADV_ATTR_HARD_IFINDEX: index of the non-batman-adv interface
+ * @BATADV_ATTR_HARD_IFNAME: name of the non-batman-adv interface
+ * @BATADV_ATTR_HARD_ADDRESS: mac address of the non-batman-adv interface
+ * @BATADV_ATTR_ACTIVE: TODO
+ * @BATADV_ATTR_ORIG_ADDRESS: TODO
+ * @BATADV_ATTR_TT_ADDRESS: TODO
+ * @BATADV_ATTR_TT_TTVN: TODO
+ * @BATADV_ATTR_TT_LAST_TTVN: TODO
+ * @BATADV_ATTR_TT_CRC32: TODO
+ * @BATADV_ATTR_TT_VID: TODO
+ * @BATADV_ATTR_TT_FLAGS: TODO
+ * @BATADV_ATTR_FLAG_BEST: TODO
+ * @BATADV_ATTR_LAST_SEEN_MSECS: TODO
+ * @BATADV_ATTR_NEIGH_ADDRESS: TODO
+ * @BATADV_ATTR_TQ: TODO
+ * @BATADV_ATTR_THROUGHPUT: TODO
+ * @BATADV_ATTR_BANDWIDTH_UP: TODO
+ * @BATADV_ATTR_BANDWIDTH_DOWN: TODO
+ * @BATADV_ATTR_ROUTER: TODO
+ * @BATADV_ATTR_BLA_OWN: TODO
+ * @BATADV_ATTR_BLA_ADDRESS: TODO
+ * @BATADV_ATTR_BLA_VID: TODO
+ * @BATADV_ATTR_BLA_BACKBONE: TODO
+ * @BATADV_ATTR_BLA_CRC: TODO
+ * @__BATADV_ATTR_AFTER_LAST: internal use
+ * @NUM_BATADV_ATTR: total number of batadv_nl_attrs available
+ * @BATADV_ATTR_MAX: highest attribute number currently defined
+ */
+enum batadv_nl_attrs {
 	BATADV_ATTR_UNSPEC,
 	BATADV_ATTR_VERSION,
 	BATADV_ATTR_ALGO_NAME,
@@ -87,15 +124,32 @@ enum {
 	BATADV_ATTR_BLA_VID,
 	BATADV_ATTR_BLA_BACKBONE,
 	BATADV_ATTR_BLA_CRC,
-	__BATADV_ATTR_MAX,
+	/* add attributes above here, update the policy in netlink.c */
+	__BATADV_ATTR_AFTER_LAST,
+	NUM_BATADV_ATTR = __BATADV_ATTR_AFTER_LAST,
+	BATADV_ATTR_MAX = __BATADV_ATTR_AFTER_LAST - 1
 };
 
-#define BATADV_ATTR_MAX (__BATADV_ATTR_MAX - 1)
-
-enum {
+/**
+ * enum batadv_nl_commands - supported batman-adv netlink commands
+ *
+ * @BATADV_CMD_UNSPEC: unspecified command to catch errors
+ * @BATADV_CMD_GET_MESH_INFO: Query basic information about batman-adv device
+ * @BATADV_CMD_GET_ROUTING_ALGOS: TODO
+ * @BATADV_CMD_GET_HARDIFS: TODO
+ * @BATADV_CMD_GET_TRANSTABLE_LOCAL: TODO
+ * @BATADV_CMD_GET_TRANSTABLE_GLOBAL: TODO
+ * @BATADV_CMD_GET_ORIGINATORS: TODO
+ * @BATADV_CMD_GET_NEIGHBORS: TODO
+ * @BATADV_CMD_GET_GATEWAYS: TODO
+ * @BATADV_CMD_GET_BLA_CLAIM: TODO
+ * @__BATADV_CMD_AFTER_LAST: internal use
+ * @BATADV_CMD_MAX: highest used command number
+ */
+enum batadv_nl_commands {
 	BATADV_CMD_UNSPEC,
-	BATADV_CMD_GET_ROUTING_ALGOS,
 	BATADV_CMD_GET_MESH_INFO,
+	BATADV_CMD_GET_ROUTING_ALGOS,
 	BATADV_CMD_GET_HARDIFS,
 	BATADV_CMD_GET_TRANSTABLE_LOCAL,
 	BATADV_CMD_GET_TRANSTABLE_GLOBAL,
@@ -103,9 +157,9 @@ enum {
 	BATADV_CMD_GET_NEIGHBORS,
 	BATADV_CMD_GET_GATEWAYS,
 	BATADV_CMD_GET_BLA_CLAIM,
-	__BATADV_CMD_MAX,
+	/* add new commands above here */
+	__BATADV_CMD_AFTER_LAST,
+	BATADV_CMD_MAX = __BATADV_CMD_AFTER_LAST - 1
 };
 
-#define BATADV_CMD_MAX (__BATADV_CMD_MAX - 1)
-
 #endif /* _UAPI_LINUX_BATMAN_ADV_H_ */
diff --git a/netlink.c b/netlink.c
index e09166c..de2fd8a 100644
--- a/netlink.c
+++ b/netlink.c
@@ -1,3 +1,27 @@
+/*
+ * Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
+ *
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#include "netlink.h"
+#include "main.h"
+
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
@@ -23,7 +47,7 @@ struct print_opts {
 	float watch_interval;
 };
 
-static struct nla_policy policy[BATADV_ATTR_MAX+1] = {
+static struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_VERSION]		= { .type = NLA_STRING },
 	[BATADV_ATTR_ALGO_NAME]		= { .type = NLA_STRING },
 	[BATADV_ATTR_MESH_IFINDEX]	= { .type = NLA_U32 },
@@ -145,7 +169,7 @@ static int info_callback(struct nl_msg *msg, void *arg)
 		return NL_OK;
 
 	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
-		      genlmsg_len(ghdr), policy)) {
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
 		fputs("Received invalid data from kernel.\n", stderr);
 		exit(1);
 	}
@@ -247,7 +271,7 @@ static int routing_algos_callback(struct nl_msg *msg, void *arg __unused)
 		return NL_OK;
 
 	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
-		      genlmsg_len(ghdr), policy)) {
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
 		fputs("Received invalid data from kernel.\n", stderr);
 		exit(1);
 	}
@@ -336,7 +360,7 @@ static int originators_callback(struct nl_msg *msg, void *arg)
 		return NL_OK;
 
 	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
-		      genlmsg_len(ghdr), policy)) {
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
 		fputs("Received invalid data from kernel.\n", stderr);
 		exit(1);
 	}
@@ -470,7 +494,7 @@ static int neighbors_callback(struct nl_msg *msg, void *arg)
 		return NL_OK;
 
 	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
-		      genlmsg_len(ghdr), policy)) {
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
 		fputs("Received invalid data from kernel.\n", stderr);
 		exit(1);
 	}
@@ -561,7 +585,7 @@ static int transglobal_callback(struct nl_msg *msg, void *arg)
 		return NL_OK;
 
 	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
-		      genlmsg_len(ghdr), policy)) {
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
 		fputs("Received invalid data from kernel.\n", stderr);
 		exit(1);
 	}
@@ -657,7 +681,7 @@ static int translocal_callback(struct nl_msg *msg, void *arg)
 		return NL_OK;
 
 	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
-		      genlmsg_len(ghdr), policy)) {
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
 		fputs("Received invalid data from kernel.\n", stderr);
 		exit(1);
 	}
@@ -757,7 +781,7 @@ static int gateways_callback(struct nl_msg *msg, void *arg)
 		return NL_OK;
 
 	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
-		      genlmsg_len(ghdr), policy)) {
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
 		fputs("Received invalid data from kernel.\n", stderr);
 		exit(1);
 	}
@@ -836,7 +860,7 @@ static int bla_claim_callback(struct nl_msg *msg, void *arg)
 		return NL_OK;
 
 	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
-		      genlmsg_len(ghdr), policy)) {
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
 		fputs("Received invalid data from kernel.\n", stderr);
 		exit(1);
 	}

--nextPart1707506.UTlYUNyO3a
Content-Disposition: attachment; filename="rebased_split_netlink-batctl.tar.gz"
Content-Transfer-Encoding: base64
Content-Type: application/x-compressed-tar; name="rebased_split_netlink-batctl.tar.gz"

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

--nextPart1707506.UTlYUNyO3a--

--nextPart2025851.eOe5rBGXAt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXMNwSAAoJEF2HCgfBJntGGgIP/1PE1QN2UaJii7WNmYPKL/CR
facUaBASGku+CgWJPmpONSMVjDE1EsWzhrSLQJ+9nQoXIDsBMlGjDzOnOhp6ghq/
QeuZt9LmOv36ZMKBmXRSCuAho6hg1f7F6njKwO+k86l3eAB5vzKKqQmqIiYu4Ml7
4e3QHc/KaCKn6HCxffCfmfdIOfDliHlUUIZGmwybLpSNX1JqgntqZI+ZqV4KZv6W
t5yQYhIbQTmeOqfNq3di5txYuyldx48gZhwctvPfx+iA0BMNb5zj+c0bYebPodW1
y9/qrtr/ZjMSlaKQGRKVuGy+FwTst9j9C9dA+Y/h8KQ/2LHjzt/fs2ZS/EY7nBYH
9Eo2qx4y4BgPCIC6LBnI4Vp5YYLWRAlNqlz1kP/Fbk4eNWrn75penVQFlrrm1K8E
vUbDYueBFmgxYLbBQ138yUV708kOKX0MGt2xzOAmqHpIs6UE0J8sOzDHA2GebgCY
KKUb6xsyOF625ZISOndrSNESDgfcMzgXH69TTdz4MdS2VgaKMaSpXQoWYqEoyM+A
JorxNgwy7Nn87Lj7bm9lO54YIkVK1qtLUdXIVbhFQAWme4h9Ci7PyBFaBIYw3R5l
U7Lga9ei5Qf/i9jn5z+BOWViW/0xpNgMpYMnMkpR/XsZjOYtodObc+cE91zvCCXH
KQ5D29zVJZswCEHeTcS6
=OxVm
-----END PGP SIGNATURE-----

--nextPart2025851.eOe5rBGXAt--

