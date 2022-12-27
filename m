Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v3 5/5] batman-adv: mcast: shrink tracker packet after
 scrubbing
Date: Tue, 27 Dec 2022 11:46:30 +0100
Message-ID: <3853699.MHq7AAxBmi@sven-l14>
In-Reply-To: <20221226204237.10403-6-linus.luessing@c0d3.blue>
References: <20221226204237.10403-1-linus.luessing@c0d3.blue>
 <20221226204237.10403-6-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2083663.taCxCBeP46";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>

 
--nextPart2083663.taCxCBeP46
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 27 Dec 2022 11:46:30 +0100
Message-ID: <3853699.MHq7AAxBmi@sven-l14>
In-Reply-To: <20221226204237.10403-6-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Monday, 26 December 2022 21:42:37 CET Linus L=FCssing wrote:
> Remove all zero MAC address entries (00:00:00:00:00:00) from a multicast
> packet's tracker TVLV before transmitting it and update all headers
> accordingly. This way, instead of keeping the multicast packet at a
> constant size throughout its journey through the mesh, it will become
> more lightweight, smaller with every interested receiver on the way and
> on each splitting intersection. Which can save some valuable bandwidth.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  net/batman-adv/multicast_forw.c | 212 ++++++++++++++++++++++++++++++++
>  1 file changed, 212 insertions(+)

ecsv/pu: checkpatch ./net/batman-adv/multicast_forw.c
=2D----------------------------------------------------

    CHECK: Macro argument reuse 'num_dests' - possible side-effects?
    #35: FILE: ./net/batman-adv/multicast_forw.c:35:
    +#define batadv_mcast_forw_tracker_for_each_dest(dest, num_dests) \
    +   for (; num_dests; num_dests--, (dest) +=3D ETH_ALEN)
   =20
    CHECK: Macro argument reuse 'num_dests' - possible side-effects?
    #38: FILE: ./net/batman-adv/multicast_forw.c:38:
    +#define batadv_mcast_forw_tracker_for_each_dest_rev(dest, num_dests) \
    +   for (; num_dests; num_dests--, (dest) -=3D ETH_ALEN)
   =20
    total: 0 errors, 0 warnings, 2 checks, 997 lines checked

ecsv/pu: headers
=2D---------------

    diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
    index 0f0d79c8..4393c3a2 100644
    --- a/net/batman-adv/multicast.h
    +++ b/net/batman-adv/multicast.h
    @@ -11,6 +11,7 @@
    =20
     #include <linux/netlink.h>
     #include <linux/skbuff.h>
    +#include <linux/types.h>
    =20
     /**
      * enum batadv_forw_mode - the way a packet should be forwarded as

ecsv/pu: kerneldoc ./net/batman-adv/multicast_forw.c
=2D---------------------------------------------------

    ./net/batman-adv/multicast_forw.c:86: warning: Function parameter or me=
mber 'bat_priv' not described in 'batadv_mcast_forw_push_dest'
    ./net/batman-adv/multicast_forw.c:401: warning: Function parameter or m=
ember 'bat_priv' not described in 'batadv_mcast_forw_push_tvlvs'
    ./net/batman-adv/multicast_forw.c:553: warning: Function parameter or m=
ember 'num_dests_remove' not described in 'batadv_mcast_forw_shrink_align_o=
ffset'
    ./net/batman-adv/multicast_forw.c:553: warning: Excess function paramet=
er 'num_dests_reduce' description in 'batadv_mcast_forw_shrink_align_offset'
    ./net/batman-adv/multicast_forw.c:657: warning: Function parameter or m=
ember 'num_dests_reduce' not described in 'batadv_mcast_forw_shrink_update_=
headers'
    ./net/batman-adv/multicast_forw.c:657: warning: Excess function paramet=
er 'num_dest_reduce' description in 'batadv_mcast_forw_shrink_update_header=
s'


> +static int batadv_mcast_forw_shrink_align_offset(unsigned int num_dests_=
old,
> +						 unsigned int num_dests_remove)
> +{
> +	int ret =3D sizeof(((struct batadv_tvlv_mcast_tracker *)0)->align);


sizeof_field from linux/stddef.h. Available there since v4.16. So you need =
to have a compat code commit which introduces it for older kernels.

Kind regards,
	Sven

--nextPart2083663.taCxCBeP46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmOqzQYACgkQXYcKB8Em
e0ZULBAAm9cTHt6WAke2wW2fK60ZsXpQBsTZLXvEuszFjkEWihxLwVXqYu5nXLYX
MdbXAyO9DXepbCrmZI7aJufKLZ7vx4buQJvcFS2y0cDJlJq+aM9mX7xzGl+ele4j
YcGccqpRwqlRLDbzcgifOQWghtPbU8AoSVYcyyz3qhnC4b/n01s7delLzhcK+00v
NbefpdWobPeY8fDrTmLHHpLV1uNjNVC/Ku72wlRlr2o4GwMNupcQP4dnE6spC9FJ
wsKiziTXise5S4643hnjGTo9ubxBaQZsFLe8m1shcxh1kLk8sa00RnVAyX1RzsXL
qo+ODJg2yylaIu4b7DS/5bHpjXORIuWD2VZq4kyUMZSwM4ZHfOyErTVEwwrtvPPJ
fsdgJIL1T9ay7165UT2fPYMEyF9l0H0NLHSaaADXzkH0UnEVTMhCkfcOmdc4tT4S
o6k7VpczDfB9j43S1TGmlp5iZfkKBzvDAhYAu20NEDoe4uG8Of5J4mdKuwMvhBq9
M0aDNnXIBEJ1dcpj0j46qZ9EM0AMdEO+u0IxMnG9lPP3pZcutfHyJHIDdLf63IaI
F3byAOwXeouS/wd9Q1KRdxqNPRv0GZYJxF62umSx6vkS59Bg6XxQU396NovkeCDp
M5wiXbMFa3l6ls5eDIpBUxyzLgu335o6UR8kwjoA1Duv4D4I380=
=JK59
-----END PGP SIGNATURE-----

--nextPart2083663.taCxCBeP46--


