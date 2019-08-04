Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 0/2] batman-adv: BATMAN_V: OGMv2 packet aggregation
Date: Sun, 04 Aug 2019 08:20:32 +0200
Message-ID: <2489919.oX8Fi7kJmE@sven-edge>
In-Reply-To: <20190804042855.29327-1-linus.luessing@c0d3.blue>
References: <20190804042855.29327-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3904495.U5pX1ZpQ9S";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart3904495.U5pX1ZpQ9S
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, 4 August 2019 06:28:53 CEST Linus L=FCssing wrote:
> Hi,
>=20
> This small patchset implements the transmission side for the OGMv2
> packet aggregation in BATMAN_V. The receiver part was already
> implemented and seems to work nicely.

Name of failed tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

ecsv/pu
=2D------

 * Comment starting with two asterisk non-empty line
 * bracket_align ./net/batman-adv/bat_v_ogm.c
 * headers
 * kerneldoc ./net/batman-adv/bat_v_ogm.c
 * kerneldoc ./net/batman-adv/types.h
 * smatch linux-4.0 CONFIG_BATMAN_ADV_BLA=3Dy CONFIG_BATMAN_ADV_DAT=3Dy CON=
=46IG_BATMAN_ADV_DEBUGFS=3Dy CONFIG_BATMAN_ADV_DEBUG=3Dn CONFIG_BATMAN_ADV_=
TRACING=3Dy CONFIG_BATMAN_ADV_NC=3Dy CONFIG_BATMAN_ADV_MCAST=3Dn CONFIG_BAT=
MAN_ADV_BATMAN_V=3Dn CONFIG_BATMAN_ADV_SYSFS=3Dn
 * smatch linux-4.1 CONFIG_BATMAN_ADV_BLA=3Dn CONFIG_BATMAN_ADV_DAT=3Dn CON=
=46IG_BATMAN_ADV_DEBUGFS=3Dy CONFIG_BATMAN_ADV_DEBUG=3Dy CONFIG_BATMAN_ADV_=
TRACING=3Dy CONFIG_BATMAN_ADV_NC=3Dn CONFIG_BATMAN_ADV_MCAST=3Dy CONFIG_BAT=
MAN_ADV_BATMAN_V=3Dy CONFIG_BATMAN_ADV_SYSFS=3Dy
 * smatch linux-4.1 CONFIG_BATMAN_ADV_BLA=3Dn CONFIG_BATMAN_ADV_DAT=3Dy CON=
=46IG_BATMAN_ADV_DEBUGFS=3Dy CONFIG_BATMAN_ADV_DEBUG=3Dy CONFIG_BATMAN_ADV_=
TRACING=3Dy CONFIG_BATMAN_ADV_NC=3Dn CONFIG_BATMAN_ADV_MCAST=3Dn CONFIG_BAT=
MAN_ADV_BATMAN_V=3Dn CONFIG_BATMAN_ADV_SYSFS=3Dn
 * smatch linux-4.12 CONFIG_BATMAN_ADV_BLA=3Dy CONFIG_BATMAN_ADV_DAT=3Dy CO=
NFIG_BATMAN_ADV_DEBUGFS=3Dn CONFIG_BATMAN_ADV_DEBUG=3Dy CONFIG_BATMAN_ADV_T=
RACING=3Dy CONFIG_BATMAN_ADV_NC=3Dn CONFIG_BATMAN_ADV_MCAST=3Dn CONFIG_BATM=
AN_ADV_BATMAN_V=3Dy CONFIG_BATMAN_ADV_SYSFS=3Dy
 * smatch linux-4.12 CONFIG_BATMAN_ADV_BLA=3Dy CONFIG_BATMAN_ADV_DAT=3Dy CO=
NFIG_BATMAN_ADV_DEBUGFS=3Dy CONFIG_BATMAN_ADV_DEBUG=3Dn CONFIG_BATMAN_ADV_T=
RACING=3Dy CONFIG_BATMAN_ADV_NC=3Dy CONFIG_BATMAN_ADV_MCAST=3Dy CONFIG_BATM=
AN_ADV_BATMAN_V=3Dy CONFIG_BATMAN_ADV_SYSFS=3Dy
 * smatch linux-4.13 CONFIG_BATMAN_ADV_BLA=3Dn CONFIG_BATMAN_ADV_DAT=3Dn CO=
NFIG_BATMAN_ADV_DEBUGFS=3Dy CONFIG_BATMAN_ADV_DEBUG=3Dn CONFIG_BATMAN_ADV_T=
RACING=3Dy CONFIG_BATMAN_ADV_NC=3Dn CONFIG_BATMAN_ADV_MCAST=3Dn CONFIG_BATM=
AN_ADV_BATMAN_V=3Dy CONFIG_BATMAN_ADV_SYSFS=3Dn
 * smatch linux-4.14 CONFIG_BATMAN_ADV_BLA=3Dy CONFIG_BATMAN_ADV_DAT=3Dy CO=
NFIG_BATMAN_ADV_DEBUGFS=3Dy CONFIG_BATMAN_ADV_DEBUG=3Dn CONFIG_BATMAN_ADV_T=
RACING=3Dy CONFIG_BATMAN_ADV_NC=3Dy CONFIG_BATMAN_ADV_MCAST=3Dn CONFIG_BATM=
AN_ADV_BATMAN_V=3Dy CONFIG_BATMAN_ADV_SYSFS=3Dn
 * smatch linux-4.14.133 CONFIG_BATMAN_ADV_BLA=3Dy CONFIG_BATMAN_ADV_DAT=3D=
n CONFIG_BATMAN_ADV_DEBUGFS=3Dy CONFIG_BATMAN_ADV_DEBUG=3Dy CONFIG_BATMAN_A=
DV_TRACING=3Dn CONFIG_BATMAN_ADV_NC=3Dy CONFIG_BATMAN_ADV_MCAST=3Dn CONFIG_=
BATMAN_ADV_BATMAN_V=3Dn CONFIG_BATMAN_ADV_SYSFS=3Dy
 * smatch linux-4.17 CONFIG_BATMAN_ADV_BLA=3Dn CONFIG_BATMAN_ADV_DAT=3Dy CO=
NFIG_BATMAN_ADV_DEBUGFS=3Dy CONFIG_BATMAN_ADV_DEBUG=3Dn CONFIG_BATMAN_ADV_T=
RACING=3Dy CONFIG_BATMAN_ADV_NC=3Dn CONFIG_BATMAN_ADV_MCAST=3Dn CONFIG_BATM=
AN_ADV_BATMAN_V=3Dy CONFIG_BATMAN_ADV_SYSFS=3Dn
 * smatch linux-4.19 CONFIG_BATMAN_ADV_BLA=3Dn CONFIG_BATMAN_ADV_DAT=3Dy CO=
NFIG_BATMAN_ADV_DEBUGFS=3Dy CONFIG_BATMAN_ADV_DEBUG=3Dn CONFIG_BATMAN_ADV_T=
RACING=3Dn CONFIG_BATMAN_ADV_NC=3Dn CONFIG_BATMAN_ADV_MCAST=3Dy CONFIG_BATM=
AN_ADV_BATMAN_V=3Dn CONFIG_BATMAN_ADV_SYSFS=3Dn
 * smatch linux-4.19.58 CONFIG_BATMAN_ADV_BLA=3Dn CONFIG_BATMAN_ADV_DAT=3Dy=
 CONFIG_BATMAN_ADV_DEBUGFS=3Dn CONFIG_BATMAN_ADV_DEBUG=3Dn CONFIG_BATMAN_AD=
V_TRACING=3Dy CONFIG_BATMAN_ADV_NC=3Dy CONFIG_BATMAN_ADV_MCAST=3Dn CONFIG_B=
ATMAN_ADV_BATMAN_V=3Dy CONFIG_BATMAN_ADV_SYSFS=3Dn
 * smatch linux-4.20 CONFIG_BATMAN_ADV_BLA=3Dn CONFIG_BATMAN_ADV_DAT=3Dn CO=
NFIG_BATMAN_ADV_DEBUGFS=3Dy CONFIG_BATMAN_ADV_DEBUG=3Dn CONFIG_BATMAN_ADV_T=
RACING=3Dy CONFIG_BATMAN_ADV_NC=3Dy CONFIG_BATMAN_ADV_MCAST=3Dy CONFIG_BATM=
AN_ADV_BATMAN_V=3Dy CONFIG_BATMAN_ADV_SYSFS=3Dn
 * smatch linux-4.20 CONFIG_BATMAN_ADV_BLA=3Dy CONFIG_BATMAN_ADV_DAT=3Dn CO=
NFIG_BATMAN_ADV_DEBUGFS=3Dn CONFIG_BATMAN_ADV_DEBUG=3Dn CONFIG_BATMAN_ADV_T=
RACING=3Dn CONFIG_BATMAN_ADV_NC=3Dn CONFIG_BATMAN_ADV_MCAST=3Dy CONFIG_BATM=
AN_ADV_BATMAN_V=3Dy CONFIG_BATMAN_ADV_SYSFS=3Dn
 * smatch linux-4.3 CONFIG_BATMAN_ADV_BLA=3Dy CONFIG_BATMAN_ADV_DAT=3Dn CON=
=46IG_BATMAN_ADV_DEBUGFS=3Dy CONFIG_BATMAN_ADV_DEBUG=3Dy CONFIG_BATMAN_ADV_=
TRACING=3Dn CONFIG_BATMAN_ADV_NC=3Dn CONFIG_BATMAN_ADV_MCAST=3Dn CONFIG_BAT=
MAN_ADV_BATMAN_V=3Dy CONFIG_BATMAN_ADV_SYSFS=3Dn
 * smatch linux-4.4 CONFIG_BATMAN_ADV_BLA=3Dn CONFIG_BATMAN_ADV_DAT=3Dn CON=
=46IG_BATMAN_ADV_DEBUGFS=3Dy CONFIG_BATMAN_ADV_DEBUG=3Dn CONFIG_BATMAN_ADV_=
TRACING=3Dy CONFIG_BATMAN_ADV_NC=3Dn CONFIG_BATMAN_ADV_MCAST=3Dy CONFIG_BAT=
MAN_ADV_BATMAN_V=3Dy CONFIG_BATMAN_ADV_SYSFS=3Dy
 * smatch linux-4.4 CONFIG_BATMAN_ADV_BLA=3Dy CONFIG_BATMAN_ADV_DAT=3Dy CON=
=46IG_BATMAN_ADV_DEBUGFS=3Dy CONFIG_BATMAN_ADV_DEBUG=3Dn CONFIG_BATMAN_ADV_=
TRACING=3Dn CONFIG_BATMAN_ADV_NC=3Dn CONFIG_BATMAN_ADV_MCAST=3Dy CONFIG_BAT=
MAN_ADV_BATMAN_V=3Dy CONFIG_BATMAN_ADV_SYSFS=3Dn
 * smatch linux-4.4.185 CONFIG_BATMAN_ADV_BLA=3Dy CONFIG_BATMAN_ADV_DAT=3Dn=
 CONFIG_BATMAN_ADV_DEBUGFS=3Dy CONFIG_BATMAN_ADV_DEBUG=3Dy CONFIG_BATMAN_AD=
V_TRACING=3Dy CONFIG_BATMAN_ADV_NC=3Dn CONFIG_BATMAN_ADV_MCAST=3Dn CONFIG_B=
ATMAN_ADV_BATMAN_V=3Dy CONFIG_BATMAN_ADV_SYSFS=3Dy
 * smatch linux-4.4.185 CONFIG_BATMAN_ADV_BLA=3Dy CONFIG_BATMAN_ADV_DAT=3Dy=
 CONFIG_BATMAN_ADV_DEBUGFS=3Dy CONFIG_BATMAN_ADV_DEBUG=3Dn CONFIG_BATMAN_AD=
V_TRACING=3Dy CONFIG_BATMAN_ADV_NC=3Dn CONFIG_BATMAN_ADV_MCAST=3Dy CONFIG_B=
ATMAN_ADV_BATMAN_V=3Dn CONFIG_BATMAN_ADV_SYSFS=3Dy
 * smatch linux-4.7 CONFIG_BATMAN_ADV_BLA=3Dn CONFIG_BATMAN_ADV_DAT=3Dy CON=
=46IG_BATMAN_ADV_DEBUGFS=3Dy CONFIG_BATMAN_ADV_DEBUG=3Dy CONFIG_BATMAN_ADV_=
TRACING=3Dn CONFIG_BATMAN_ADV_NC=3Dn CONFIG_BATMAN_ADV_MCAST=3Dn CONFIG_BAT=
MAN_ADV_BATMAN_V=3Dy CONFIG_BATMAN_ADV_SYSFS=3Dy
 * smatch linux-4.8 CONFIG_BATMAN_ADV_BLA=3Dy CONFIG_BATMAN_ADV_DAT=3Dy CON=
=46IG_BATMAN_ADV_DEBUGFS=3Dy CONFIG_BATMAN_ADV_DEBUG=3Dy CONFIG_BATMAN_ADV_=
TRACING=3Dy CONFIG_BATMAN_ADV_NC=3Dy CONFIG_BATMAN_ADV_MCAST=3Dn CONFIG_BAT=
MAN_ADV_BATMAN_V=3Dy CONFIG_BATMAN_ADV_SYSFS=3Dy
 * smatch linux-4.9.185 CONFIG_BATMAN_ADV_BLA=3Dy CONFIG_BATMAN_ADV_DAT=3Dy=
 CONFIG_BATMAN_ADV_DEBUGFS=3Dn CONFIG_BATMAN_ADV_DEBUG=3Dy CONFIG_BATMAN_AD=
V_TRACING=3Dy CONFIG_BATMAN_ADV_NC=3Dn CONFIG_BATMAN_ADV_MCAST=3Dn CONFIG_B=
ATMAN_ADV_BATMAN_V=3Dy CONFIG_BATMAN_ADV_SYSFS=3Dn
 * smatch linux-4.9.185 CONFIG_BATMAN_ADV_BLA=3Dy CONFIG_BATMAN_ADV_DAT=3Dy=
 CONFIG_BATMAN_ADV_DEBUGFS=3Dy CONFIG_BATMAN_ADV_DEBUG=3Dy CONFIG_BATMAN_AD=
V_TRACING=3Dy CONFIG_BATMAN_ADV_NC=3Dn CONFIG_BATMAN_ADV_MCAST=3Dn CONFIG_B=
ATMAN_ADV_BATMAN_V=3Dy CONFIG_BATMAN_ADV_SYSFS=3Dy
 * smatch linux-5.1.17 CONFIG_BATMAN_ADV_BLA=3Dy CONFIG_BATMAN_ADV_DAT=3Dy =
CONFIG_BATMAN_ADV_DEBUGFS=3Dn CONFIG_BATMAN_ADV_DEBUG=3Dy CONFIG_BATMAN_ADV=
_TRACING=3Dn CONFIG_BATMAN_ADV_NC=3Dy CONFIG_BATMAN_ADV_MCAST=3Dy CONFIG_BA=
TMAN_ADV_BATMAN_V=3Dn CONFIG_BATMAN_ADV_SYSFS=3Dn


Output of different failed tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

ecsv/pu: Comment starting with two asterisk non-empty line
=2D---------------------------------------------------------

    43:./net/batman-adv/types.h:126:    /** @aggr_len: length of the OGM ag=
gregate (excluding ethernet frame

ecsv/pu: bracket_align ./net/batman-adv/bat_v_ogm.c
=2D--------------------------------------------------

    Found wrong alignment at ./net/batman-adv/bat_v_ogm.c:158, was 28 but e=
xpected 34

ecsv/pu: headers
=2D---------------

    diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
    index 862fb465..6053e6bb 100644
    --- a/net/batman-adv/bat_v_ogm.c
    +++ b/net/batman-adv/bat_v_ogm.c
    @@ -23,6 +23,7 @@
     #include <linux/rcupdate.h>
     #include <linux/skbuff.h>
     #include <linux/slab.h>
    +#include <linux/spinlock.h>
     #include <linux/stddef.h>
     #include <linux/string.h>
     #include <linux/types.h>
    diff --git a/net/batman-adv/bat_v_ogm.h b/net/batman-adv/bat_v_ogm.h
    index 4b122f1a..fbce68d7 100644
    --- a/net/batman-adv/bat_v_ogm.h
    +++ b/net/batman-adv/bat_v_ogm.h
    @@ -11,6 +11,7 @@
    =20
     #include <linux/skbuff.h>
     #include <linux/types.h>
    +#include <linux/workqueue.h>
    =20
     int batadv_v_ogm_init(struct batadv_priv *bat_priv);
     void batadv_v_ogm_free(struct batadv_priv *bat_priv);

ecsv/pu: kerneldoc ./net/batman-adv/bat_v_ogm.c
=2D----------------------------------------------

    ./net/batman-adv/bat_v_ogm.c:171: warning: Function parameter or member=
 'hard_iface' not described in 'batadv_v_ogm_aggr_list_free'
    ./net/batman-adv/bat_v_ogm.c:171: warning: Excess function parameter 'h=
ead' description in 'batadv_v_ogm_aggr_list_free'

ecsv/pu: kerneldoc ./net/batman-adv/types.h
=2D------------------------------------------

    ./net/batman-adv/types.h:142: warning: Function parameter or member 'ag=
gr_len' not described in 'batadv_hard_iface_bat_v'

ecsv/pu: smatch linux-4.12 CONFIG_BATMAN_ADV_BLA=3Dy CONFIG_BATMAN_ADV_DAT=
=3Dy CONFIG_BATMAN_ADV_DEBUGFS=3Dy CONFIG_BATMAN_ADV_DEBUG=3Dn CONFIG_BATMA=
N_ADV_TRACING=3Dy CONFIG_BATMAN_ADV_NC=3Dy CONFIG_BATMAN_ADV_MCAST=3Dy CONF=
IG_BATMAN_ADV_BATMAN_V=3Dy CONFIG_BATMAN_ADV_SYSFS=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.GpBziukSSV/net/batman-adv/bat_v_ogm.c:36=
5 batadv_v_ogm_aggr_work() warn: unused return: bat_priv =3D netdev_priv()


Statistics
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

ecsv/pu
=2D------

=46ailed tests:                28
Started build tests:         24
Tested Linux versions:       17
Tested configs:              24


Kind regards,
	Sven

--nextPart3904495.U5pX1ZpQ9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl1GeTAACgkQXYcKB8Em
e0YLmg//f5SsECtPUlmMruXpIIZL13w77UPsMuvvFJYDRgAlbR24vssrEKatGUq5
0ZGkFMPwORvPlICbwWDlJQZV5ZeYDA9i7ZlMS2A1DoWMzOzx5kp0lodb0PBq/QfF
GyMWaUgcbz/evoQtdwFsGMa2E5NI9fc1n5EuIn+T08pER3yVImqcIN1QaTdz0GVZ
ES2SIkD5IVcHxO8tB91ZfBVZgaUcY5kpG5N6jHwsR7KMZF2urtyboanPjA4LWqJ3
sGHHFwWT5clBUr6chur1gXq8dXdN/l7g5bpfr07PyDLYjh5o2XzCOWyQbqdM0hsR
3SwQ1wZLNJ8TxPb3zy5SghbkSLjeX26lvdgtfT65NOiRvEeQxIVopDrgGxv1hwtF
OhxVulLhd/TG/qTYIKJUdzjCjFvEPqUb52Fqt8x2vusXkHWgmstfrHpngCDX3WDI
UKI+zBHdWghww5bBS2twuLwfXNNRC0KmeJyHXNd78wk+Ars/DaE3lFRT4K/0Yjcd
L5gJUQmJVMyZbtJH2Q3LyMDqPChuZOFo1ikaJyXI8KStMHlZin8K0UZVP7jcgrMR
WI25c7Hkq7XB21I3omS3GbI46ZrI6j2Rt4Az4+cPp2+1h44pfevEnNZiH2MFxZIQ
UUgqTJleb9ezB+efcXyAB7WSVQpz87Pk6AZUjw7NA9Mo3uKyyqs=
=b9X/
-----END PGP SIGNATURE-----

--nextPart3904495.U5pX1ZpQ9S--



