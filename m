Return-Path: <antonio@meshcoding.com>
Message-ID: <5534EF84.8090402@meshcoding.com>
Date: Mon, 20 Apr 2015 14:22:28 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <13114664.Eg4ODy7KEo@bentobox> <28031511.vQmOOoKVTs@voltaire>
 <5534EB7E.2060809@meshcoding.com> <7605822.cxC5KnHP44@bentobox>
In-Reply-To: <7605822.cxC5KnHP44@bentobox>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="V2vBb7c9B3evuH6kIfQsq5PnNKSMeeJhr"
Subject: Re: [B.A.T.M.A.N.] [PATCH-next 0/6] Patches for batman-adv 2015.0
 release
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
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V2vBb7c9B3evuH6kIfQsq5PnNKSMeeJhr
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 20/04/15 14:12, Sven Eckelmann wrote:
> Can you also check the "weird" patch which is in the release since 2014=
=2E2.0
> but doesn't seem to be in net-next.git/linux.git?
>=20
> http://git.open-mesh.org/batman-adv.git/commit/31f391475cc08724e96ab060=
ef4aa6503d11da8e

Why this patch is not upstream I don't know - it made its way through my
pipe to net-next, but probably was never sent.

However, after re-reading this patch and quickly testing the current
behaviour with linux-4.0 I have some doubts about its usefulness.

The problem I tried to fix with this patch started by observing that
when changing the MAC address of a soft-iface VLAN (e.g. bat0.2)
ndo_set_mac_address() seemed not to be called.
Therefore with this patch I change the no-purge MAC addresses in the
local translation table when the MAC address of bat0 got changed.


I think we would need to investigate a bit more if this is still true or
not and then decide to revert or not this patch (in the latter case I
will send it to net-next).

A test that could be done consists in checking if ndo_set_mac_address()
gets invoked when changing the MAC address of any bat0.x interface.

Cheers,


--=20
Antonio Quartulli


--V2vBb7c9B3evuH6kIfQsq5PnNKSMeeJhr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVNO+IAAoJEJgn97Bh2u9ef9sP/idWkdzjpQcoHEWIMOc1Osrh
zQV9Q2tjvmtl2kWifFKyTvUw4S0uv6lz0NaNEKHGo801OdSWuYfPzI10cAopYR6B
GlL52qtT84ustRgIwr43dVJIWo7zvDchXyTxa+SbypahXuyDQ3QtrsCu3+NxD3p/
6z4Yhan5FGgsrm3PicWqQUP0LQevPIfjoVimPhVYWTMQ15MWS1UvLQf8w0q2XKtr
eaygaxuiSf11NpeXOlbhHECMYdY8pLgfGcl4UuRzH2B4UHaOlDjDNGln8ArsMo5I
TD6hf6+f3WWf2NkLhvA2Q3tkgz+SCpgBcZUSmrQHOebcQU3Gv1SwlOz9vbdU1AS4
TyHdVs1fLBvrBqQ0pCnfOueGmavXbBLvoV/jhf6We1Xy7rw63PtMmuex53ViedQG
qStuKr2VoVzOssUMyAZ6I08nJpa5fZJJ79likpZHQ5fodswagXPvNtE9mStjGaqf
Yy7BkBCv6S3515HXEN1/2/tCfz6kMuQYYDH7SOwwBByHoXfJG9FQ30NOiMP1Ku4R
5Km3S0G5mI0ogmxBGHnJd00p65VASbD185PEZCI+K5Z8uz/ueFUpJSvbM/RSF3GG
geMPBSTN+3xsWPJWibCnQeLESfnfJXFpLJ9YOtuDSFK5X0iisUQShKuhjk6bQ/sg
nShNxgUqnjs4PcoP1//J
=dHjX
-----END PGP SIGNATURE-----

--V2vBb7c9B3evuH6kIfQsq5PnNKSMeeJhr--
