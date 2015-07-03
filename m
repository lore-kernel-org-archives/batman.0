Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 03 Jul 2015 19:13:02 +0800
Message-ID: <2779160.PvUSbAU1eu@voltaire>
In-Reply-To: <1435811430-6949-1-git-send-email-linus.luessing@c0d3.blue>
References: <1435811430-6949-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7853678.Nv38Ee9oT1";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix broken capability
	checks
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart7853678.Nv38Ee9oT1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday, July 02, 2015 06:30:30 Linus L=FCssing wrote:
> Fixes: bfd0fbaef270 ("batman-adv: Make DAT capability changes atomic"=
)
> Fixes: 586df9e2537b ("batman-adv: Make NC capability changes atomic")=

> Fixes: a51fa16ecf3f ("batman-adv: Make TT capability changes atomic")=

> Fixes: 201a54ba710a ("batman-adv: Make MCAST capability changes atomi=
c")

Can we please split these patches too ? Antonio needs to merge the patc=
h pairs=20
before submitting them.


> @@ -422,7 +422,7 @@ static bool batadv_is_orig_node_eligible(struct
> batadv_dat_candidate *res, int j;
>=20
>  =09/* check if orig node candidate is running DAT */
> -=09if (!(candidate->capabilities & BATADV_ORIG_CAPA_HAS_DAT))
> +=09if (!(candidate->capabilities & BIT(BATADV_ORIG_CAPA_HAS_DAT)))
>  =09=09goto out;

How about using test_bit() to be consistent ?


> @@ -299,10 +299,10 @@ struct batadv_orig_node {
>   *  (=3D orig node announces a tvlv of type BATADV_TVLV_MCAST)
>   */
>  enum batadv_orig_capabilities {
> -=09BATADV_ORIG_CAPA_HAS_DAT =3D BIT(0),
> -=09BATADV_ORIG_CAPA_HAS_NC =3D BIT(1),
> -=09BATADV_ORIG_CAPA_HAS_TT =3D BIT(2),
> -=09BATADV_ORIG_CAPA_HAS_MCAST =3D BIT(3),
> +=09BATADV_ORIG_CAPA_HAS_DAT,
> +=09BATADV_ORIG_CAPA_HAS_NC,
> +=09BATADV_ORIG_CAPA_HAS_TT,
> +=09BATADV_ORIG_CAPA_HAS_MCAST,
>  };

Do we need an initialization of the first element or can we rely on the=
=20
compiler to start with 0 ?

Cheers,
Marek

--nextPart7853678.Nv38Ee9oT1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVlm5CAAoJEFNVTo/uthzA9sMH/1JUyXywa0IdDztOzNSujrqv
fZhXQ3qo5BEfoqwTyKgN3We5/NZ49kfE9MOnFZbSepW6uEVRK/r7kkyZC+unvmln
V6Tg2qyHAwYfuxpaIucfFpGRtOmIkkL0XRwkZLF/LdDDKQ4S/w/YOTSUkLke42Pp
2gnsIcUdTWiSt8b7xt7TvCPqQ6B9/Xo6cAB3lgcDTbTe9Pz1WPyW5SEwJN3vuUKC
NcjW+1OlSrTrAvHwM2YrlB0dSvRTr6BsbVRIvxrVctbzpZDLSh41Wb/jpgdfLHQv
V9hgntn25jJaHQbY0AQUy8Izrl5TYs9otmfaDwHnV0Hs5YOCgW2IXVmUPQn8g/k=
=6Lvm
-----END PGP SIGNATURE-----

--nextPart7853678.Nv38Ee9oT1--

