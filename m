Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 4 Nov 2011 16:17:56 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111104151756.GA12738@pandem0nium>
References: <1320015072-10313-1-git-send-email-siwu@hrz.tu-chemnitz.de>
	<1320015072-10313-12-git-send-email-siwu@hrz.tu-chemnitz.de>
	<201111011108.48015.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <201111011108.48015.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 11/11] [RFC] batman-adv: get primaries
 address through bat_priv->own_orig
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Marek,

as per our IRC discussion, I'm removing this RFC patch as well as the
primary_addr caching in the bla code to avoid any debugging complexity with
this cache. I first introduced it to avoid code bloating to fetch/check/rel=
ease
the primary_if in all the little functions, but I found an easy and non-blo=
ating
way to do that. ;)

Regarding BLAII after this change, all functions hooked up somewhere (bla_r=
x(),
bla_tx(), bla_periodic_work(), ...) will more or less return as long as the=
re
is no primary_if - it is needed to find out the own address after all.

When a new primary_if is chosen, the claim table and backbone gw table are =
wiped
to "simulate" a reboot - with the new interface, we might have new neighbors
in the mesh after all ...

The patch is already included in my blaII_dirty repo, I'll update and rebas=
e=20
main patch series accordingly as there were no more comments in the last co=
uple
of days.

Thanks
	Simon


On Tue, Nov 01, 2011 at 11:08:47AM +0100, Marek Lindner wrote:
> On Sunday, October 30, 2011 23:51:12 Simon Wunderlich wrote:
> > Instead of acquiring the first interfaces originator through
> > hard interface (including referencing/dereferencing), we can use the
> > cached value in bat_priv->own_orig.
> >=20
> > There might be some cases where this function was implicitly used to
> > check whether there is a hard interface configured at all (i.e. if
> > batman is active), therfore this is patch is an RFC.
>=20
> Most of the functions do not simply retrieve the addr but also check if t=
here=20
> is a primary interface. So, what happens if batman-adv has no primary_if =
?=20
> AFAIK that can occur if all added hard-interfaces are down.
>=20
> What happens with BLAII if there is no primary interface ?
>=20
> Cheers,
> Marek
>=20

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk60AiQACgkQrzg/fFk7axbwzQCgkvN4+8tNCZS6eSH6eRigXkZo
MjsAnjWhdUQB8aYFMzwFpp0nyCIke8Ar
=0rG+
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
