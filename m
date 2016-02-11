Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 11 Feb 2016 23:52:05 +0100
Message-ID: <2360276.GhZ0sleNGR@sven-edge>
In-Reply-To: <1674394.xTpvsLY2Zu@sven-edge>
References: <1674394.xTpvsLY2Zu@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart18422364.WjyFkKVKmC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] mac80211 compat layer for OpenWrt
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

--nextPart18422364.WjyFkKVKmC
Content-Type: multipart/mixed; boundary="nextPart1949817.qKuBKHtrpB"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart1949817.qKuBKHtrpB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 11 February 2016 23:25:56 Sven Eckelmann wrote:
[...]
> I've also attached the patch to build the current state of B.A.T.M.A.N. V on
> OpenWrt.

Btw. the previously proposed way to select the routing algorithm at runtime in 
OpenWrt requires an additional patch. The setting in /etc/config/network would 
look something like:

    config interface 'batnet'
            option mtu '1532'
            option proto 'batadv'
            option mesh 'bat0'
            option routing_algo 'BATMAN_IV'

Kind regards,
	Sven
=2D-nextPart1949817.qKuBKHtrpB
Content-Disposition: attachment; filename="0003-openwrt-feed-batman-adv-Allow-to-select-routing-algo.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0003-openwrt-feed-batman-adv-Allow-to-select-routing-algo.patch"

From: Sven Eckelmann <sven@open-mesh.com>
Date: Tue, 19 Jan 2016 12:40:10 +0100
Subject: [PATCH] openwrt-feed-batman-adv: Allow to select routing algorithm

The network config section for proto batadv now allows to select the
routing algorithm via the option routing_algo. This allows to chose between
BATMAN_IV and BATMAN_V when BATMAN_V is released. This option is only
useful when a new batman-adv device is created and not when only a device
is added to an already existing batman-adv device.

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>

Forwarded: https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-January/014225.html
=2D--
 batman-adv/files/lib/netifd/proto/batadv.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/batman-adv/files/lib/netifd/proto/batadv.sh b/batman-adv/files/lib/netifd/proto/batadv.sh
index 632a209..1e0c9d0 100644
=2D-- a/batman-adv/files/lib/netifd/proto/batadv.sh
+++ b/batman-adv/files/lib/netifd/proto/batadv.sh
@@ -6,14 +6,18 @@ init_proto "$@"
 
 proto_batadv_init_config() {
 	proto_config_add_string "mesh"
+	proto_config_add_string "routing_algo"
 }
 
 proto_batadv_setup() {
 	local config="$1"
 	local iface="$2"
 
=2D	local mesh
=2D	json_get_vars mesh
+	local mesh routing_algo
+	json_get_vars mesh routing_algo
+
+	[ -n "$routing_algo" ] || routing_algo="BATMAN_IV"
+	echo "$routing_algo" > "/sys/module/batman_adv/parameters/routing_algo"
 
 	echo "$mesh" > "/sys/class/net/$iface/batman_adv/mesh_iface"
 	proto_init_update "$iface" 1

=2D-nextPart1949817.qKuBKHtrpB--
This is a multi-part message in MIME format.

--nextPart1949817.qKuBKHtrpB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 11 February 2016 23:25:56 Sven Eckelmann wrote:
[...]
> I've also attached the patch to build the current state of B.A.T.M.A.N. V on
> OpenWrt.

Btw. the previously proposed way to select the routing algorithm at runtime in 
OpenWrt requires an additional patch. The setting in /etc/config/network would 
look something like:

    config interface 'batnet'
            option mtu '1532'
            option proto 'batadv'
            option mesh 'bat0'
            option routing_algo 'BATMAN_IV'

Kind regards,
	Sven
--nextPart1949817.qKuBKHtrpB
Content-Disposition: attachment; filename="0003-openwrt-feed-batman-adv-Allow-to-select-routing-algo.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0003-openwrt-feed-batman-adv-Allow-to-select-routing-algo.patch"

From: Sven Eckelmann <sven@open-mesh.com>
Date: Tue, 19 Jan 2016 12:40:10 +0100
Subject: [PATCH] openwrt-feed-batman-adv: Allow to select routing algorithm

The network config section for proto batadv now allows to select the
routing algorithm via the option routing_algo. This allows to chose between
BATMAN_IV and BATMAN_V when BATMAN_V is released. This option is only
useful when a new batman-adv device is created and not when only a device
is added to an already existing batman-adv device.

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>

Forwarded: https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-January/014225.html
---
 batman-adv/files/lib/netifd/proto/batadv.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/batman-adv/files/lib/netifd/proto/batadv.sh b/batman-adv/files/lib/netifd/proto/batadv.sh
index 632a209..1e0c9d0 100644
--- a/batman-adv/files/lib/netifd/proto/batadv.sh
+++ b/batman-adv/files/lib/netifd/proto/batadv.sh
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

--nextPart1949817.qKuBKHtrpB--

--nextPart18422364.WjyFkKVKmC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWvRCVAAoJEF2HCgfBJntGOLQQANGZuGJzmmP5rK0RfiKyhdzI
V5a9P+nU/9MK32FSlwtaXqlqBU8ZuCphMVmOYd2YD6c9zBwzOU6LvnUlaUZlpu8c
8sPQ0+EpyB8Evz8ayGWCKVWLPxeOEQ6p18O1u0rBROzwWf9AEyBiG0OvLmEyixea
zu0MFJGneMiArRVb4vPm4wAG6jn28mZQYeK1z7y6sBMx1x9GmeF9n+4Z+NhaFa32
G0gSSH68YtfpM6tHpCP/AqZJET1CWBsHa3iZGIXva3UI++YUbToTfa23/uI5caAc
+lBv/KLOFhtybRlsdA0vpBrBlFTxdCAEpDh71S10VtVWmFF+UftCs2oQnfC425xK
dO8hrkbkhiw5zeKekr2cJcg9Fj6JCrPlWAGu/ehIt0gePi5O7U8efn4J7HZiiPBA
/GOtfo/2oZZtB3wUkbxqdDeKqW1WE2XGzH+y02+4O8RCf0qodC+ckuLSqD/w9djI
dBaWHNx3VgoHdC6t2/qlqSYOXHngwfobqN+FHTUJ6QEpfcJqPJELbyJvrqf3ieTd
Po08BHTJimPMbEMxkv+cbWQJuQVnJbJ1LVZ3jZXeJeGlaFxO7xVY5h9aDQd+4ZIS
HnojhAFHLTLn8P42YTraMV6xhun3wP/3aor/NUbrWcOJB30ButnGWDiZOKp7hDoL
kv1IoHPjYLUe7QjAIhkl
=CGL6
-----END PGP SIGNATURE-----

--nextPart18422364.WjyFkKVKmC--

