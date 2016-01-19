Return-Path: <sven@open-mesh.com>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Tue, 19 Jan 2016 12:47:07 +0100
Message-Id: <1453204027-10948-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH] openwrt-feed-batman-adv: Allow to select
	routing algorithm
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
Cc: Sven Eckelmann <sven@open-mesh.com>

The network config section for proto batadv now allows to select the
routing algorithm via the option routing_algo. This allows to chose between
BATMAN_IV and BATMAN_V when BATMAN_V is released. This option is only
useful when a new batman-adv device is created and not when only a device
is added to an already existing batman-adv device.

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
 batman-adv-devel/files/lib/netifd/proto/batadv.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/batman-adv-devel/files/lib/netifd/proto/batadv.sh b/batman-adv-devel/files/lib/netifd/proto/batadv.sh
index 632a209..1e0c9d0 100644
--- a/batman-adv-devel/files/lib/netifd/proto/batadv.sh
+++ b/batman-adv-devel/files/lib/netifd/proto/batadv.sh
@@ -6,14 +6,18 @@ init_proto "$@"
 
 proto_batadv_init_config() {
 	proto_config_add_string "mesh"
+	proto_config_add_string "routing_algo"
 }
 
 proto_batadv_setup() {
 	local config="$1"
 	local iface="$2"
 
-	local mesh
-	json_get_vars mesh
+	local mesh routing_algo
+	json_get_vars mesh routing_algo
+
+	[ -n "$routing_algo" ] || routing_algo="BATMAN_IV"
+	echo "$routing_algo" > "/sys/module/batman_adv/parameters/routing_algo"
 
 	echo "$mesh" > "/sys/class/net/$iface/batman_adv/mesh_iface"
 	proto_init_update "$iface" 1
-- 
2.7.0.rc3

