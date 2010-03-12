Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 12 Mar 2010 21:57:40 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100312205740.GA20427@pandem0nium>
References: <1268325529-10998-1-git-send-email-linus.luessing@web.de>
	<1268342346-13713-1-git-send-email-linus.luessing@web.de>
	<201003112306.48652.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <201003112306.48652.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fixing wrap-around bug in	vis
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


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

nice catch!

I'd like to join the party and propose this version:

#define seq_before(x,y) ((int8_t) (x - y) < 0)
#define seq_after(x,y) seq_before(y,x)

Not so much bitshifting and may a little bit easier to=20
understand, but also not general and does not pass Svens regression test ..=
=2E :(

Wrong seq_before(0, 128) =3D=3D true
Wrong seq_after(0, 128) =3D=3D true
Wrong seq_before(1, 129) =3D=3D true
Wrong seq_after(1, 129) =3D=3D true
Wrong seq_before(2, 130) =3D=3D true
Wrong seq_after(2, 130) =3D=3D true
Wrong seq_before(3, 131) =3D=3D true
Wrong seq_after(3, 131) =3D=3D true
Wrong seq_before(4, 132) =3D=3D true
Wrong seq_after(4, 132) =3D=3D true
Wrong seq_before(5, 133) =3D=3D true
Wrong seq_after(5, 133) =3D=3D true

What do you think?  ;)

best regards
	Simon

On Thu, Mar 11, 2010 at 11:06:42PM +0100, Sven Eckelmann wrote:
> Linus L=C3=BCssing wrote:
> > -               if (vis_packet->seqno - old_info->packet.seqno <=3D 0) {
> > +               if (vis_packet->seqno - old_info->packet.seqno
> > +                   <=3D 1 << 7 * sizeof(vis_packet->seqno)) {
>=20
> Shouldn't that be=20
>  1 << 7 + 8 * (sizeof(vis_packet->seqno) - 1))?
>=20
> Otherwise you would have left the the sizeof(vis_packet->seqno) most=20
> significant bits 0 and the rest one. And maybe a seq_before/seq_after sta=
tic=20
> inline function could be created to make this thing a lot more readable. =
You=20
> could also do that in a macro if you don't want to assume the type of=20
> vis_packet->seqno... which is probably what you tried by using sizeof
>=20
> #define seq_before(x,y) ((x - y) >=3D 1 << 7 + 8 * (sizeof(x) - 1))
> #define seq_after(x,y) ((y - x) >=3D 1 << 7 + 8 * (sizeof(x) - 1))
> ....
>=20
> And maybe you see here that the equal part which is needed bellow that li=
ne=20
> isn't possible. So it must be changed to=20
>=20
> if (!seq_after(vis_packet->seqno, old_info->packet.seqno))
>=20
> I hope that this is right - please check twice.
>=20
>=20
> Best regards,
> 	Sven



--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuaqsQACgkQrzg/fFk7axayowCdFYWggePnC3yQLONXkNHvmYe1
B3cAoJQpYzxmYzHl/kwnARss1SQYH5lC
=xuc1
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
