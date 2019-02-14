Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 14 Feb 2019 13:46:35 +0100
Message-ID: <1687264.beubBEU3KB@bentobox>
In-Reply-To: <20190214124301.6222-1-linus.luessing@c0d3.blue>
References: <20190214124301.6222-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart96899318.V8qgRDvtOE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Add multicast-to-unicast
 support for multiple targets
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
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, David Bauer <mail@david-bauer.net>, Jiri Pirko <jiri@mellanox.com>

--nextPart96899318.V8qgRDvtOE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday, 14 February 2019 13:43:01 CET Linus L=FCssing wrote:
>=20
> +What:           /sys/class/net/<mesh_iface>/mesh/multicast_fanout
> +Date:           Feb 2019
> +Contact:        Linus L=FCssing <linus.luessing@c0d3.blue>
> +Description:
> +                Defines the maximum number of packet copies that may
> +               be generated for a multicast-to-unicast conversion.
> +               Once this limit is exceeded distribution will fall
> +               back to broadcast.
> +

No new sysfs config files.

Kind regards,
	Sven
--nextPart96899318.V8qgRDvtOE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlxlYysACgkQXYcKB8Em
e0ZBHA//ajfCpHGoYRd/WQlHiiF30nV1galxd5k0IL2bcoaQaVR8VE2THBZe1RL1
W7G1+9333cOUaYDMJPrLo5J+lbQFWBRTldJV4tI1MBkWKXgQcznCMxnZUNLZhAuh
Ki8VGC/vYhxJcirIfb3FnZiRO5/G0La69VJwO0jpTmy7uYW0M+oyk41h/bVLLVrL
jAm7ofv5Dl0GY3ROuJKpX49kBMuD37wYvO22GIR6S4UahVYr0OVtgCBlFDK7X/nO
v6YlaVmm2tKirnapdMcW2NiJtp7yFVjGDjVLxM/ftncbpRzR/mMT4wcpBmU5CUtJ
en3G83XXc1a9om1yzzmYukIm7ESO+NUxovZhDaCcSiusGSWnp53qzhdAl0C2GG75
XZ0pKCV+SxW6QvwjrVXDVFksaeVeEyEUGssa/x5+uhdk+lwyaR2sQM27dD2KL21m
aLRc1iwrKdIA8mR6B/3nbXtBbJU3bAi4EWaUzscxRSuJ/7vhHQa8icCiP/fS8DpK
L+POCxGMlx7CzWal2J4yvnTmIuiOtwWAt5WKq/LwGvr5l6XRYn5EW4VRsiA73aPl
ClmZvETGZzb7J5QHLZ/jPYoOWjbwcTMWlPoDkVZJdfq+VV2RQETUJ6TupwbnjAgF
Sw+eOYW8pZ8PjsWgNJWHSrw2GaOtQdGq4jYzIdplrhhff8JlXaA=
=yrgu
-----END PGP SIGNATURE-----

--nextPart96899318.V8qgRDvtOE--



