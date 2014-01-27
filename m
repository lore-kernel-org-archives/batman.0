Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 27 Jan 2014 15:57:55 +0800
Message-ID: <2314387.HvPbVFGchE@diderot>
In-Reply-To: <52DE4C6C.10904@meshcoding.com>
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>
 <52DE4C6C.10904@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart44868894.680PfLeRJK";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix soft-interface MTU
	computation
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart44868894.680PfLeRJK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 21 January 2014 11:31:08 Antonio Quartulli wrote:
> On 21/01/14 11:22, Antonio Quartulli wrote:
> > The current MTU computation always returns a value
> > smaller than 1500bytes even if the real interfaces
> > have an MTU large enough to compensate the batman-adv
> > overhead.
> >
> > 
> >
> > Fix the computation by properly returning the highest
> > admitted value.
> >
> > 
> 
> Introduced by f7f2fe494388fca828094a4ebdab918a7b2d64f8
> ("batman-adv: limit local translation table max size")
> 
> > Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>

Applied in revision 2b108cc.

Thanks,
Marek

--nextPart44868894.680PfLeRJK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS5hGDAAoJEFNVTo/uthzAb5wH/ijByQORxdKKtGA7bchIahZN
KoN8y6D+tDvLgGhahslnK1Uu/doD838IxMiJHfd2iZUTgRvigZzJ+QOvRnRgIknm
Uzxf/NA0xZUeT+aM607SjHwni31wET0UGTjjLkV1GfHniCKGLm1/PGd5+V7MOMpH
cSFjP/6wvYbGBqxTehe3T6N6vBxgaK3gXbafbA0dZNntDmvdQi2AUrYcg7pPlLEK
nuXe0bNPMyhVoj1KFUghZTzZNIzk8JNaGP/RkiJaC6lV8o8BrxAhuXySY+FQQro0
ukR49cBUpaRvkgQfMQ5E3DqcYyyxnDRteVi6WmnexxS1IwcPlZbZopTcjRgqHVg=
=SmFa
-----END PGP SIGNATURE-----

--nextPart44868894.680PfLeRJK--

