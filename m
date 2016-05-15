Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 15 May 2016 14:17:58 +0200
Message-ID: <8086534.UgBdovvYXm@sven-edge>
In-Reply-To: <22866212.dooYpi8Uhz@sven-edge>
References: <20160514145129.GD4375@otheros> <20160515120626.GG4375@otheros>
 <22866212.dooYpi8Uhz@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1463316601.vYK9PtJmH1";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] kmalloc() vs. kmem_cache_alloc() for global TT?
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

--nextPart1463316601.vYK9PtJmH1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday 15 May 2016 14:15:01 Sven Eckelmann wrote:
> On Sunday 15 May 2016 14:06:26 Linus L=FCssing wrote:
> [...]
>=20
> > [0]
> > https://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/linus/=
kmem-ca
> > c
> > he
>=20
> This patchset has a bad bug. It still uses kfree for tt_local objects=

> allocated via kmem_cache_(z)alloc.

Also the kmem_cache_destroy seems to be broken regarding the RCU handli=
ng.

Kind regards,
=09Sven
--nextPart1463316601.vYK9PtJmH1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXOGj2AAoJEF2HCgfBJntGq/YP/1h8sEVSipRPgq9DCKPkFYot
/+j7NFBdXTvYqcgDCgWrWcSDKcAfi9v1ON1pPmPBjndnEnJ6j///gQtvNR6/pW8S
We2qc4+nPO2jLSCdYtNq1vs745yG57G4yjkNCkxu0juCiGfUvkIseF69bQGzNZpV
fkt/z9t4veHNKT2moI8DOrVnR5v0Cbxrb2BTRoLaANi1MzJUvWb5mct+/sY7ky4Z
RRcs6HSUK89KGaftuhnGA2qaAnBu7+OwWsdlyUT5NVipPf1Su7r+5zbf9uMSnbh2
G9zD4iNdi35uNz2/hI+nqsXay4Y3mdpFD87iumfuKDA0IAmYHlry9S+JFy6x7KIA
zpRPYCk9gLcVYUxLMvLn6Go3deMi77yIK6xNfP/1ikdd3HuExdufu4ZQv1dSIslr
dQqhiDEEV43rxmjpFZEqUAQrvIoL2BtsedNT+WuH1r3n2R4mdNpZVTDp+3hBUOpE
c61JLK4z4M2xPfyMjJx6Ov8YWqHq2C4z3tVK35oE6hrUmKYA55UIYjK6tm2TqesD
I1wDHE/J+6WlNrQv2SgEfRVJou/eEXsQ3y0VqwdLtiXi8IiVwiy+Nz0/KmxuVdcn
0KltIHTLn7E74Wcf8/AhM03dH/xd19WRNn9NCuTDsypZaNq1xM9qzi9emKOTHFha
//pf6CggZQFPK1LhMuhI
=lb2H
-----END PGP SIGNATURE-----

--nextPart1463316601.vYK9PtJmH1--

