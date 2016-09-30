Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Fri, 30 Sep 2016 15:20:23 +0200
Message-ID: <2666783.nl87Kib46y@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3875917.AOJh61V4XN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH v2 0/7] batman-adv: wifi interface detection
	on
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

--nextPart3875917.AOJh61V4XN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Marek created some patches a while ago to automatically detect the wifi
interface under virtual interfaces like VLANs. These patches had some problems
because they failed to correctly set the num_bcasts in these situations and
also had some locking problems.

The following patches try to address these by introducing a cache for the
detected wifi configuration (wifi_flags which make taking the rtnl lock in
critical section unnecessary) and by updating the num_bcast and wifi_flags
when the interface behind iflink changes.

 * added patch "batman-adv: Return non-const ptr in batadv_getlink_net"
 * added patch "batman-adv: Close two alignment holes in batadv_hard_iface"
 * added patch "batman-adv: Cache the type of wifi device for each hardif"
 * added patch "batman-adv: Update wifi flags on upper link change"
 * introduced batadv_get_real_netdevice which can be used inside rtnl
   locked contexts
 * replaced wifi check functions with ones that use the wifi_flags cache
 * use batadv_getlink_net to get the iflink net_namespace
 * force rtnl_lock in batadv_get_real_netdev

Kind regards,
	Sven


Marek Lindner (3):
      batman-adv: refactor wifi interface detection
      batman-adv: additional checks for virtual interfaces on top of WiFi
      batman-adv: retrieve B.A.T.M.A.N. V WiFi neighbor stats from real interface

Sven Eckelmann (4):
      batman-adv: Return non-const ptr in batadv_getlink_net
      batman-adv: Close two alignment holes in batadv_hard_iface
      batman-adv: Cache the type of wifi device for each hardif
      batman-adv: Update wifi flags on upper link change

 net/batman-adv/bat_iv_ogm.c        |   2 +-
 net/batman-adv/bat_v_elp.c         |  41 +++++----
 net/batman-adv/hard-interface.c    | 173 ++++++++++++++++++++++++++++++++++---
 net/batman-adv/hard-interface.h    |   5 +-
 net/batman-adv/translation-table.c |  10 ++-
 net/batman-adv/types.h             |  21 ++++-
 6 files changed, 217 insertions(+), 35 deletions(-)
--nextPart3875917.AOJh61V4XN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJX7maXAAoJEF2HCgfBJntG98sP/1MfOZO5P61njX0ZSPUT548H
MwpFs9Jnnfzr58/l7FaJfavjuYsZo35hQ8cAr5/WeofshE7HhTaH3VOI1H8oxwdx
hRiNkzGDpuOrMww/deCjpCgDDgrGBwQYsiM+HywFN/+J1IuZXvIYz4Av/WT8dHRC
Vj3NWgSNiMtAxZU49akAnzJ2115Mih4Uzr6QGJUA7dsukbJsDs9V4FHWYjncUvBl
icB+y/GtD/ro8EBobTXEnMLbzr/zNb9KUx+2O9UVtg0L1CsP4FFkT5JsHvS8PX1X
oCZC7p+FCnUz90itwHJWlmlE515ie4sCFJqxSPxfz5rAEBYKGw9VQDzjVYsVVIx9
xtqHHMmSzwcXZCoZIvyq29vS/+N0jR8NjgCc/O+1qCrjGlvLYKd7uBgxhiXkmvaW
ibzoN1xCA6ARrR4/PhmMFcSVqTjjDoCSJLhKH6S8ls84ElBnRG4dg8z/MPYJyO8x
j2JKM+SlwXxIrFQDck5BYjiLphtpbQyQuzEqvvtcjOo/irmacmk00l1Wx9N6YjVI
1hFk0ax9T0L8FLyXpG+FWFodj7Jh0Q/Ie7BhBGHkhBQJbX5wMR8RDtO+4PqifseW
SDzdF1kaeacZMwyNz94/MMXBDxr6QQn9n9h1LsYb34NQnKFOGtoTJ0GNs8zOFZbv
kzN1/gqxxhykais8zHeR
=JwA/
-----END PGP SIGNATURE-----

--nextPart3875917.AOJh61V4XN--

