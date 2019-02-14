Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 14 Feb 2019 21:45:22 +0100
Message-ID: <8119162.K4mufomEW5@sven-edge>
In-Reply-To: <20190214125415.6472-1-linus.luessing@c0d3.blue>
References: <20190214125415.6472-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4644300.HXtna1eSI3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: add switch for setting
 multicast_fanout
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
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, David Bauer <mail@david-bauer.net>

--nextPart4644300.HXtna1eSI3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday, 14 February 2019 13.54.15 CET Linus L=FCssing wrote:
> This patch adds an option for the new multicast_fanout setting in
> batman-adv.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  Makefile           |   1 +
>  README.rst         |  10 +++++
>  batman_adv.h       |   7 ++++
>  man/batctl.8       |   5 +++
>  multicast_fanout.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 138 insertions(+)
>  create mode 100644 multicast_fanout.c

change in event.c is missing to parse the mcast "config" group messages wit=
h=20
BATADV_ATTR_MULTICAST_FANOUT.

BATADV_ATTR_MULTICAST_FANOUT was not added to netlink.c's=20
batadv_netlink_policy

> diff --git a/Makefile b/Makefile
> index 4d8b709..15bc3ec 100755
> --- a/Makefile
> +++ b/Makefile
> @@ -69,6 +69,7 @@ $(eval $(call add_command,log,y))
>  $(eval $(call add_command,loglevel,y))
>  $(eval $(call add_command,mcast_flags,y))
>  $(eval $(call add_command,multicast_mode,y))
> +$(eval $(call add_command,multicast_fanout,y))
>  $(eval $(call add_command,nc_nodes,y))
>  $(eval $(call add_command,neighbors,y))
>  $(eval $(call add_command,network_coding,y))

multicast_fanout comes before multicast_mode (alphabetical order)

> diff --git a/README.rst b/README.rst
> index 4c0f544..a3a61ac 100644
> --- a/README.rst
> +++ b/README.rst
> @@ -478,6 +478,16 @@ Usage::
>    batctl multicast_mode|mm [0|1]
> =20
> =20
> +batctl multicast_fanout
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +display or modify the multicast fanout setting
[...]

This is not valid restructuredtext:

    $ rst2html README.rst > /dev/null
    README.rst:482: (WARNING/2) Title underline too short.
   =20
    batctl multicast_fanout
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    README.rst:482: (WARNING/2) Title underline too short.
   =20
    batctl multicast_fanout
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[...]
> +static struct settings_data batctl_settings_multicast_fanout =3D {
> +	.sysfs_name =3D "multicast_fanout",

There should be no sysfs_name for this (see discussion in batman-adv patch).

Kind regards,
	Sven

--nextPart4644300.HXtna1eSI3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlxl02IACgkQXYcKB8Em
e0a0oBAAsi3VXAn6wEjxlDJk1FsItW9BXPLuUmZ3Z/a78W6pD6BoPIhHgvvAsWPq
nnLz0tKXtFN+B1SF/k6mK5AXVwLIfdVQfzBSzFvVH+fkEAgY8z2xs5wYeIwP8x3p
r4tpClytrcWJdwi6kCJpoagO9u35a6+pZW30LKCpU2PAF4jzEbFzun7diX6flifo
madyhu+XeSCmbpVBVHYMDkdqp5Lj0tWaXpT3lu1GKHnAM0tImW0HFSnxCQECn3ob
+Oo4WAvSqgVMUHi+BG51nNqg+OGpWn/qKLT4czpSe/gAWc+fUS3xrA0AoNGf/B/K
wXLmREhiQXwCIqPY7ACIZ/s6CMxJSUKod1fXDR8BCLbXnBHcCtPhXe8cyl0kHoSV
PQz9ZFcZN26FnWHsTm2BRrCW0q5vIBNOytVxY9KZIsh3p5MqtOVMOV6Ojgih1uMR
gE+4wsat9PJyeXCZL0Hhz5MP+aP4Z4wzI0KWZsYqUXZfVdgx8+/tgVRi2GKT5YI8
bPo7J3KufFHucE5d4xD3HWYWhKF1jSTDDzkvBVUPrbxoav+yiU6ldxg1G5lIWyFC
eQ/Bq4WTw1CXt2Dt5iXmUgw7+duXJA7wl2wvpJrREYAfR2eLlMlKjE6lzv7UP/nV
XrdbbBR0dNDYIkhYiF2Ia/c25q5hV4BEyrnHMNRUgNT5zu/lW5U=
=x1MQ
-----END PGP SIGNATURE-----

--nextPart4644300.HXtna1eSI3--



