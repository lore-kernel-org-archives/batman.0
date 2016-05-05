Return-Path: <a@unstable.cc>
Date: Thu, 5 May 2016 20:06:20 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160505120413.GN11201@prodigo.lan>
References: <1462434282-3307-1-git-send-email-sven.eckelmann@open-mesh.com>
 <20160505100435.GL11201@prodigo.lan> <1726573.p6gE20s2JI@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="D5arhb13WwWKLIR9"
Content-Disposition: inline
In-Reply-To: <1726573.p6gE20s2JI@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: replace
 dev->trans_start update with helper
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


--D5arhb13WwWKLIR9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 05, 2016 at 12:36:54PM +0200, Sven Eckelmann wrote:
> On Thursday 05 May 2016 18:04:35 Antonio Quartulli wrote:
> [...]
> > >=20
> > > +#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 7, 0)
> > > +
> > > +#define netif_trans_update batadv_netif_trans_update
> > > +static inline void batadv_netif_trans_update(struct net_device *dev)
> >=20
> > Sven,
> >=20
> > do we really need to rename the function is the original one does not e=
xist
> > in kernels < 4.7 ? Or maybe it exists but does something else ?
>=20
> Not necessarily but Linus' noticed for a different function that some dis=
tros=20
> (or stable maintainers) backported the function which we introduced. Thus=
 we=20
> used the same trick to solve the conflict.

Yup, thanks for reminding!

Cheers,



--=20
Antonio Quartulli

--D5arhb13WwWKLIR9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXKzc8AAoJEJ4aZjxxc6bKtwkP/3kHw/JiuKZqABVn2NgfKZvi
325ZGDkHEWnikV3GhOfqYFPqCdgkaAbqJnFkvbl2u/UET1XUk+9RyxPuijzvewve
DCFcCchJQgy7ShccTCzu6TuJ3OLO3oidfeZvVvSifeNGDEEWiSVsD2G72pAhRYmv
t6q0cj8EfCJ7gQ/klyLXiXMn+Rc/EcSBnGA9M20RaNuANkGNEX2BHWViIDD7ffc6
o9W974pPgSlikBDdnOJUqgHwo0SnXFkVrMTFacnTsgqIgr6lnBbsPCdMb7r4tdbL
YyF+6JRh6glwO9NbSPUzGG+pdT0m16vfpGrQGDzx/5Q5bAt/djUTQASV/FbbgHKU
RjoFqosnbYcqF/Xef3Wls3f1/i8ffdopYMGi55gRvz8IdW5rHVj/b6CRehsds8N/
FWgiXAvZmafRW44gd3/NqF15SncS5qf1F5Xm6r9LrPRjtGeWVCd2iiH8lP7A/9W7
VQAK4R+4ku5q+QkshHBt0Vs+eFfxLrVedQBD4sKOSj47zoNlJhCFzb7ReLlCXqXz
pSeLNCbdyCx2ClMDh4W+L/Ory4sfRG21bBGk4Gazn+TxCcrObwrQ7v1sPZIBDHzh
yKzSFolILc+CbKx6aPdRGMfDhsAA5ubbC56hhnNldEN5xL7QBQrVPxIam3HnSMHX
0n/bk2Ua6sCR448WZcJP
=2sZl
-----END PGP SIGNATURE-----

--D5arhb13WwWKLIR9--
