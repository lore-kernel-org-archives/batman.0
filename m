Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH maint v3 3/3] batman-adv: mcast: fix duplicate mcast packets from BLA backbone to mesh
Date: Mon, 14 Sep 2020 21:12:00 +0200
Message-ID: <6205936.0nzyDX8fZS@sven-edge>
In-Reply-To: <20200914012136.5278-4-linus.luessing@c0d3.blue>
References: <20200914012136.5278-1-linus.luessing@c0d3.blue> <20200914012136.5278-4-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2913249.5A1q0F6Dos"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>

 
--nextPart2913249.5A1q0F6Dos
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, 14 September 2020 03:21:36 CEST Linus L=FCssing wrote:
> + * Check if it is on our broadcast list. Another gateway might have sent=
 the
> + * same packet because it is connected to the same backbone, so we have =
to
> + * remove this duplicate.
> +
>   * This is performed by checking the CRC, which will tell us

There is a "*" missing in the last added kerneldoc line. This causes follow=
ing=20
warning message:

    ./net/batman-adv/bridge_loop_avoidance.c:1594: warning: bad line:

Kind regards,
	Sven
--nextPart2913249.5A1q0F6Dos
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl9fwIAACgkQXYcKB8Em
e0aixRAAocvatDu9B2RFS6mRWR3gg/p+8zo6/ChIKgxx7mHxWA/F0mTfttRFg/c8
faCYeK9RLtlNY30awDJhjjwaV2qRN0g8g2huS/o3bRIWrcELAQMKCJKYd2+tJvtH
tptBPmqBI9Fjs9pt47jsLUKb1vvZ8dfP+OR6eLU+CUOEdaR1qOh9DMQ65GNwZ3u4
WLou8FU14T2bEOl+8m0A4USfyQuNzxpPO92UpdpBDp2IqEd6wLs4MupnfPz1ov8a
AMDYsqmXy8Y/XubeTCSUmDbP+C8P6CmcPU6sgI6bDU1e9vouKLue2Gyj4436iHEO
2yp89yG8sDBti67Jd/Zq7yMImWC3e9XVTT9nxGuS70x7l4c6pD8kEkEAaP/JgUsz
uy84PTOwqKw7mBbMNm9qeCa9bU1Ub+JJ2Qv+McvoNUrP0Ec2QdXIHldBFzjxADK2
SOdnSfOxVPuO1EFdUT9OKdYOcuFG5SpjaiCI+7jRAQWjtqs/q/8rz8wbDjNV7oqo
ModikdSYVOiGOWECpmYP4UmSblrvi4VM+uNqxIELnhBInRfkgOyXdMUo92gmnnRa
+qrHKTAmPkD1IZbKlHuSipHGfqdCk/em26vpsU9DkLPyH/3YZKrHy6KhCG+o6wgh
n24+iE975KMgRg4v4lqJLIe/YIidzH3SpErd3CXkHvTp8WUS4D8=
=5xOJ
-----END PGP SIGNATURE-----

--nextPart2913249.5A1q0F6Dos--


