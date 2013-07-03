Return-Path: <ordex@autistici.org>
Date: Wed, 3 Jul 2013 12:22:23 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130703102223.GF2325@ritirata.org>
References: <1372840800-642-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline
In-Reply-To: <1372840800-642-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: refine API calls for
 unicast transmissions of SKBs
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2013 at 10:40:00AM +0200, Linus L=C3=BCssing wrote:
> With this patch the functions batadv_send_skb_unicast() and
> batadv_send_skb_unicast_4addr() are further refined into
> batadv_send_skb_via_tt(), batadv_send_skb_via_tt_4addr() and
> batadv_send_skb_via_gw(). This way we avoid any "guessing" about where to=
 send
> a packet in the unicast forwarding methods and let the callers decide.
>=20
> This is going to be useful for the upcoming multicast related patches in
> particular.
>=20
> Further, the return values were polished a little to use the more
> appropriate NET_XMIT_* defines.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>

Acked-by: Antonio Quartulli <ordex@autistici.org>

Thanks a lot Linus!

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJR0/tfAAoJEADl0hg6qKeOjOYQAJPryF/8y7Twb4L8Zoqv4iO/
pf8mD3vOMzF1TPngrfD0Q8JRw8FT+aElRDdNTL5hk9IhUpvUztd51Jm8cdRi3GcU
QLAxF9hk6R4+wg8P7OJQF3aGa/FwuIwnmq/pa4IJIW9pfx5p3xJBuFf8YmTRLQN2
ylW9F5+9LcWy46zG7Xn/wvtv1t5EzN5gRhZABXVFzqDAYM7UyWqvsEcRE3Y2IvNc
I46umIBmEBbfxh5XtH6EFOAS8iYVRrLcSLUgS2vUOEooSI5GpYwrGLVSAArI/osM
MKYRx3D9CsfxQXDx2nEbXp/izkAJ7UbKvjQSK0kopGJsxLWjOC1nUIZYuPQ5ZMmv
7puJbnhgnWRFcE8d4WlagJnMbA64zDIJsxMqRHQW41c0Nl9oUUhSyEiR4vRch+2y
mG+R0qsJoS1ubuq/tP5CK8Yn5JKaWD+7wDzAQsMiexnaBMGUc0wxggEJszVjS0iL
0CrTEcrCytH5KlSZz9Gr4B7KB40RLMP8ZSPNiuEURaChmmWmp4MTbGmDSHf6BtOL
PbH0NEPWR1IvEcmecmiB2SuSwAdXnhgZ7Io0MCAw1PXXwIEGKsuENiADSKKtUAjw
NZtw+s8xf7GgaILSjC1jcv9GRZp09XPZ3E+YvKekJBOBU46JO2ZTknBu3ou1rlOm
T9E8jUYcfM174aNsZkOw
=gr3V
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--
