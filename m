Return-Path: <a@unstable.cc>
Date: Mon, 25 Apr 2016 22:19:41 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160425141941.GI3381@prodigo>
References: <1461590722-2095-1-git-send-email-dvlasenk@redhat.com>
 <20160425133950.GH3381@prodigo> <571E1F70.3040001@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="451BZW+OUuJBCAYj"
Content-Disposition: inline
In-Reply-To: <571E1F70.3040001@redhat.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Deinline
 batadv_orig_hash_find, save 9024 bytes
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Denys Vlasenko <dvlasenk@redhat.com>
Cc: linux-kernel@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>


--451BZW+OUuJBCAYj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2016 at 03:45:20PM +0200, Denys Vlasenko wrote:
> On 04/25/2016 03:39 PM, Antonio Quartulli wrote:
> > On Mon, Apr 25, 2016 at 03:25:22PM +0200, Denys Vlasenko wrote:
> >> This function compiles to 473 bytes of machine code.
> >> 21 callsites.
> >>
> >>     text     data      bss       dec     hex filename
> >> 95903266 20860288 35991552 152755106 91adba2 vmlinux_before
> >> 95894242 20860288 35991552 152746082 91ab862 vmlinux
> >=20
> > Hi Danys,
> >=20
> > thanks for your patch. This function is used in a several performance c=
ritical
> > code paths (i.e. packet forwarding).
> >=20
> > Are we sure we are not losing in performance here?
>=20
> Is this a common case?
>=20
> 	if (!hash)
> 		return NULL;
>=20
> If yes, then we can inline this part only.

Unfortunately not: this case is rather rare at runtime.
These hash tables are initialized when the batman virtual interface is crea=
ted
and should be freed only upon interface shutdown.

(actually I believe this might be a good candidate for an unlikely())

Cheers,

--=20
Antonio Quartulli

--451BZW+OUuJBCAYj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXHid9AAoJEJ4aZjxxc6bKM5AP/ifhv/IETU6CSih4ffMiq5vm
MPXPZgsKo18f87k0BPiP7XePkOxQGCMxDgF4MXeZPPHp8dFx2dnEef4/HVwZRciA
VEd4pJKV0+rdOwsUjeFgJTT5+iPy6ngDhPbGMIuRfsbzO09so+eml3SIr3j3xN1F
LjZUQs8VpXXbcAumJqAWImi2Ap1H8HWe3DsVH3vtlOt1l6UFcgpqidPLVXcs4QnJ
WtYn7QE4V+PSHJsp9XKYVFsOXRJM+nxRhTpT/Wltpn6QcH9CaA+QwJNjdWU5x2Lt
voNSbumtAU7e8O+oMCkaScfdRtg+vQCcoVEE1RhitF6S0C2c3g1oKOLEUuGK7yg3
efiTm4ZLR5ISGrzPLIAPkjjVxsaRlN8LLO/yaAtJGgzNVJphMcqa+S2jEI+fIhrv
vjFa23syN/Nj6VpZOLFcTdhmWuYilvnPFtFL9ioOOrfWur6Y+CMsn4drL+aRTj6q
pgAhFWgDOk0oIfo0e+mk78fRFCWzsQ3zlVfUEIIgXT4I4O0Foae6oQfYLz4KU4xt
s71KdTlrhknlE12TtFmdXwrcdpG+MjVa+ybClBoijJazRc53LZmKa9l4QuS29+2I
GxTdZF894D4oNDfgcXsPeten5pyRx3nB9hxlKf5pavXqzdBM46lV92o0aP8hoXp6
cZG+p0qF/qdsptOfdNnK
=7LJV
-----END PGP SIGNATURE-----

--451BZW+OUuJBCAYj--
