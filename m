Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 27 Apr 2019 05:56:03 +0800
Message-ID: <1906609.VMlLDzDynG@rousseau>
In-Reply-To: <20190426171231.18156-1-linus.luessing@c0d3.blue>
References: <20190426171231.18156-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1987896.iMoehAmBEL";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: introduce "noflood"
 broadcast flood prevention option
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

--nextPart1987896.iMoehAmBEL
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday, 27 April 2019 01:12:31 HKT Linus L=FCssing wrote:
> With DAT DHCP snooping, the gateway feature and multicast optimizations
> in place in some scenarios broadcast flooding might not be strictly
> necessary anymore to be able to establish IPv4/IPv6 communication.
> Therefore this patch adds an option to disable broadcast flooding.
>=20
> Larger mesh networks typically filter a variety of multicast packets via
> ebtables/netfilter to clamp on overhead. With this option such firewall
> rules can be relaxed so that such multicast packets are only dropped
> if they cannot be handled by multicast-to-unicast, for instance.

Could you outline the use-case for this specific noflood option in more det=
ail ?
The description above is not entirely clear to me. Especially, the 'might n=
ot=20
be strictly necessary anymore' to 'firewall rules can be relaxed'. How are=
=20
these things connected ? Is this option implemented only, so that some fire=
wall=20
rules don't need to be set anymore ?
What happens if a user enables 'noflood' but does not fall into the 'might =
not=20
be strictly necessary anymore' category ?

Thanks,
Marek

--nextPart1987896.iMoehAmBEL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAlzDfnMACgkQU1VOj+62
HMB8Ogf/TU63cHgwMTnnBULG8/BX111BhCV7T0Jp4G91tF+5j4a39y/Z6gf+E/TT
TSjDBiSK7tm+D/GnNQw1jmh+ZJEekHMn9oa/CAxA88o9ux3PTwuZexCEi6jIAKLH
wnAzuqasFfb4LejpHmuYzE9N+GXtN6VCXpQ4+CFLkxwyHL1wMEkGLgs7bvrMsrv6
SVxNFzbxru4QXYdDyrgIijlPHmyYJeIxwHzAiwmgiDLjOodRm+KeB0xpQfZGCNNc
i24PaiIFjycHj6BxJXFsRM9wDjUgzYNuUuvmJ7A9Gigh38A+RMFJ63W3s3hg9stl
DVIv3JT+ZOtjwCQeqPxSAxUcf9qZIQ==
=4rD1
-----END PGP SIGNATURE-----

--nextPart1987896.iMoehAmBEL--



