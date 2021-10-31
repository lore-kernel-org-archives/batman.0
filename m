Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH] batman-adv: allow netlink usage in unprivileged containers
Date: Sun, 31 Oct 2021 22:06:42 +0100
Message-Id: <20211031210642.2388-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Tycho Andersen <tycho.andersen@canonical.com>

Currently, creating a batman-adv interface in an unprivileged LXD
container and attaching secondary interfaces to it with "ip" or "batctl"
works fine. However all batctl debug and configuration commands
fail:

  root@container:~# batctl originators
  Error received: Operation not permitted
  root@container:~# batctl orig_interval
  1000
  root@container:~# batctl orig_interval 2000
  root@container:~# batctl orig_interval
  1000

To fix this change the generic netlink permissions from GENL_ADMIN_PERM
to GENL_UNS_ADMIN_PERM. This way a batman-adv interface is fully
maintainable as root from within a user namespace, from an unprivileged
container.

All except one batman-adv netlink setting are per interface and do not
leak information or change settings from the host system and are
therefore save to retrieve or modify as root from within an unprivileged
container.

"batctl routing_algo" / BATADV_CMD_GET_ROUTING_ALGOS is the only
exception: It provides the batman-adv kernel module wide default routing
algorithm. However it is read-only from netlink and an unprivileged
container is still not allowed to modify
/sys/module/batman_adv/parameters/routing_algo. Instead it is advised to
use the newly introduced "batctl if create routing_algo RA_NAME" /
IFLA_BATADV_ALGO_NAME to set the routing algorithm on interface
creation, which already works fine in an unprivileged container.

Cc: Tycho Andersen <tycho.andersen@canonical.com>
Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
---
Cc'ing Tycho Andersen as he introduced the GENL_UNS_ADMIN_PERM in the=20
following commit:

4a92602aa1cd ("openvswitch: allow management from inside user namespaces"=
)

 net/batman-adv/netlink.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 29276284..00875e1d 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -1368,21 +1368,21 @@ static const struct genl_small_ops batadv_netlink=
_ops[] =3D {
 	{
 		.cmd =3D BATADV_CMD_TP_METER,
 		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags =3D GENL_ADMIN_PERM,
+		.flags =3D GENL_UNS_ADMIN_PERM,
 		.doit =3D batadv_netlink_tp_meter_start,
 		.internal_flags =3D BATADV_FLAG_NEED_MESH,
 	},
 	{
 		.cmd =3D BATADV_CMD_TP_METER_CANCEL,
 		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags =3D GENL_ADMIN_PERM,
+		.flags =3D GENL_UNS_ADMIN_PERM,
 		.doit =3D batadv_netlink_tp_meter_cancel,
 		.internal_flags =3D BATADV_FLAG_NEED_MESH,
 	},
 	{
 		.cmd =3D BATADV_CMD_GET_ROUTING_ALGOS,
 		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags =3D GENL_ADMIN_PERM,
+		.flags =3D GENL_UNS_ADMIN_PERM,
 		.dumpit =3D batadv_algo_dump,
 	},
 	{
@@ -1397,68 +1397,68 @@ static const struct genl_small_ops batadv_netlink=
_ops[] =3D {
 	{
 		.cmd =3D BATADV_CMD_GET_TRANSTABLE_LOCAL,
 		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags =3D GENL_ADMIN_PERM,
+		.flags =3D GENL_UNS_ADMIN_PERM,
 		.dumpit =3D batadv_tt_local_dump,
 	},
 	{
 		.cmd =3D BATADV_CMD_GET_TRANSTABLE_GLOBAL,
 		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags =3D GENL_ADMIN_PERM,
+		.flags =3D GENL_UNS_ADMIN_PERM,
 		.dumpit =3D batadv_tt_global_dump,
 	},
 	{
 		.cmd =3D BATADV_CMD_GET_ORIGINATORS,
 		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags =3D GENL_ADMIN_PERM,
+		.flags =3D GENL_UNS_ADMIN_PERM,
 		.dumpit =3D batadv_orig_dump,
 	},
 	{
 		.cmd =3D BATADV_CMD_GET_NEIGHBORS,
 		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags =3D GENL_ADMIN_PERM,
+		.flags =3D GENL_UNS_ADMIN_PERM,
 		.dumpit =3D batadv_hardif_neigh_dump,
 	},
 	{
 		.cmd =3D BATADV_CMD_GET_GATEWAYS,
 		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags =3D GENL_ADMIN_PERM,
+		.flags =3D GENL_UNS_ADMIN_PERM,
 		.dumpit =3D batadv_gw_dump,
 	},
 	{
 		.cmd =3D BATADV_CMD_GET_BLA_CLAIM,
 		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags =3D GENL_ADMIN_PERM,
+		.flags =3D GENL_UNS_ADMIN_PERM,
 		.dumpit =3D batadv_bla_claim_dump,
 	},
 	{
 		.cmd =3D BATADV_CMD_GET_BLA_BACKBONE,
 		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags =3D GENL_ADMIN_PERM,
+		.flags =3D GENL_UNS_ADMIN_PERM,
 		.dumpit =3D batadv_bla_backbone_dump,
 	},
 	{
 		.cmd =3D BATADV_CMD_GET_DAT_CACHE,
 		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags =3D GENL_ADMIN_PERM,
+		.flags =3D GENL_UNS_ADMIN_PERM,
 		.dumpit =3D batadv_dat_cache_dump,
 	},
 	{
 		.cmd =3D BATADV_CMD_GET_MCAST_FLAGS,
 		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags =3D GENL_ADMIN_PERM,
+		.flags =3D GENL_UNS_ADMIN_PERM,
 		.dumpit =3D batadv_mcast_flags_dump,
 	},
 	{
 		.cmd =3D BATADV_CMD_SET_MESH,
 		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags =3D GENL_ADMIN_PERM,
+		.flags =3D GENL_UNS_ADMIN_PERM,
 		.doit =3D batadv_netlink_set_mesh,
 		.internal_flags =3D BATADV_FLAG_NEED_MESH,
 	},
 	{
 		.cmd =3D BATADV_CMD_SET_HARDIF,
 		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags =3D GENL_ADMIN_PERM,
+		.flags =3D GENL_UNS_ADMIN_PERM,
 		.doit =3D batadv_netlink_set_hardif,
 		.internal_flags =3D BATADV_FLAG_NEED_MESH |
 				  BATADV_FLAG_NEED_HARDIF,
@@ -1474,7 +1474,7 @@ static const struct genl_small_ops batadv_netlink_o=
ps[] =3D {
 	{
 		.cmd =3D BATADV_CMD_SET_VLAN,
 		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags =3D GENL_ADMIN_PERM,
+		.flags =3D GENL_UNS_ADMIN_PERM,
 		.doit =3D batadv_netlink_set_vlan,
 		.internal_flags =3D BATADV_FLAG_NEED_MESH |
 				  BATADV_FLAG_NEED_VLAN,
--=20
2.31.0
