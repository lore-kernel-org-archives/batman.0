Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 17 Aug 2009 21:20:41 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20090817192041.GA25229@pandem0nium>
References: <20090817183644.GC20229@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20090817183644.GC20229@ma.tech.ascom.ch>
Subject: Re: [B.A.T.M.A.N.] batman-adv packet.h license
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>
Cc: Marek Lindner <lindner_marek@yahoo.de>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andrew,

this is fine with me, let's hear what marek thinks. BTW, there are
excellent batman dissectors for wireshark, have you tried them already?=20

best regards,
	Simon

On Mon, Aug 17, 2009 at 08:36:44PM +0200, Andrew Lunn wrote:
> Hi Marek, Simon
>=20
> I'm writing a protocol dissector for tcpdump which understands
> batman-adv packets. To do this i need to use packet.h, at least that
> is the easiest way to do it. tcpdump uses the BSD license, where as
> packet.h is GPL2. So it is unlikely the tcpdump maintainers would
> accept packet.h as is.
>=20
> As the two copyright owners of this file, is it O.K. with you to if i
> change the license on this one file in my tcpdump patch to use BSD?
>=20
>        Thanks
>           Andrew
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqJrYkACgkQrzg/fFk7axYAbwCgvhTMy2EVQ/9Qh3PkWhYt8yY9
T5oAnRckqI/QEiCDWLTIXT+T+vbkRBTa
=6R/M
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
