Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Apr 2019 11:30:06 +0200
Message-ID: <3742207.3UPO53M6zG@sven-edge>
In-Reply-To: <20190422092048.GG6201@otheros>
References: <20190422081214.8481-1-sven@narfation.org>
 <20190422092048.GG6201@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2062830.b35WlyjXgK";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Drop log subcommand
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

--nextPart2062830.b35WlyjXgK
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, 22 April 2019 11:20:48 CEST Linus L=FCssing wrote:
> On Mon, Apr 22, 2019 at 10:12:14AM +0200, Sven Eckelmann wrote:
> > The correct way to get a log of the activities of batman-adv is to use =
the
> > standard kernel tracing infrastructure:
> >=20
> >   $ trace-cmd stream -e batadv:batadv_dbg
[...]
> The trace-cmd approach does not add/provide network namespace
> support, does it?

Afaik, not at the moment.

> If we were removing "batctl log" now we would probably need to readd it
> later again when adding network namespace support, both for
> either a netlink or IPv6 node-local multicast approach, right [0]?
>=20
> (Although for the IPv6 node-local multicast 'socat' for instance would
> work, too.)

I am rather sure that we shouldn't add the namespace specific logs in batma=
n-
adv via a batadv specific new infrastructure. Sounds like horrible hacks wh=
ich=20
we shouldn't even try to upstream.

Kind regards,
	Sven
--nextPart2062830.b35WlyjXgK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAly9iZ4ACgkQXYcKB8Em
e0aZtw//ZWpomp+Lou9CwAwXwCBDhK+ZYq9pzRLfx4241i3gxVW7o3J7oRUcvFip
hk/Q2lylaaDnVT9pIWCzAjBAp8ssJ74zjo6MxrUig6CoEZGcOqhw+tJFX+/JRO0v
6s3pb906RFvLv6EQAET5XdkMPPT69WYeZOPSnA7+Hino70vsB4cxzYyXM48Wt2AU
L7EXKHbt1pVlVIGqgvGItFzSLv9Mhc3aSHjPSxSCTpRFto4Wo4O6ElT4MOFH5NfT
QwUIf3D5R1HG/MjdrmUxgh/Mw7GkjafraCTGdsSxMY7Mhv206OupYnU/ii6ClZdE
X8FhwGrkWhHB3m6QuAdvGEk7GprX78JIKQgx22GeZ+rpUQhFqhGLj29RbltyMgiQ
apZYIe63Ugb514GSUsbXtC6RvjkslpJDLzM+FgzPOLneiynlxs2OcyYl5NVhdGtB
bJYjdI67JmsFsmM62lH5Bfk7DLNquT38fMm4J38u35wrUpaLfkcY3WuwNHItqKTl
JJSsU5RnI32LTyhZDkRXHH4RUo6GbYKJQ+gDjPoMjep5Udd+4+mjg5jl/Rmozi4g
p1OU3mqZPD2s5/FeDGBrLtTE+C3OR6w5b+Pt3jfVnpdW7tACWfz/By7QLI+NO0Y1
ysr0vQcVJBR2QkGvfp9MvFkjclzNnMsPZ6DPyi2kLnxS5JXNrcs=
=C4DF
-----END PGP SIGNATURE-----

--nextPart2062830.b35WlyjXgK--



