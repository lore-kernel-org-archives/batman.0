Date: Fri, 5 Dec 2008 21:04:14 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] Looking for batman-adv 0.1-alpha
Message-ID: <20081205200414.GB27271@pandem0nium>
References: <4938F21D.2050907@irt.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <4938F21D.2050907@irt.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Tobias,

are you using the kernelland or userspace version of batman-adv? If you
want to use the userspace version, it's enough to compile and copy the
binary from your desktop to the meshnode (it's i386 after all).=20

However i'd recommend to use the latest revision of
batman-adv-kernelland. For this you'd need to compile the modules for
the kernel. AFAIK they use a debian based system, so you could probably
use our Debian packages:

http://packages.debian.org/sid/batman-adv-source
http://packages.debian.org/sid/batman-adv-battool

(you'd need their kernel source packages to compile it, thou ...)
Please note that the userland version was intended as proof of concept=20
and we might only support the kernelland version in the long term.

OpenWRT also supports batman-adv btw. :)

best regards,
	Simon

On Fri, Dec 05, 2008 at 10:19:25AM +0100, Tobias Gieseke wrote:
> Hi,
>=20
> I'm looking for Batman-advanced 0.1-alpha (compability version 1). We've=
=20
> got some meshnodes III from a company called Saxnet and they seem to=20
> work with this old version.. I can't find it in the repositories so=20
> perhaps someone can tell me where to find it, or send it to me directly.=
=20
> I need it for i386 architecture.
> Is there a chance to get batman-adv running on open-wrt?
>=20
> kind regards,
>=20
> Tobi
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJOYk+rzg/fFk7axYRAnBfAJ9m8PSWmycRDpdKtjJ9zUQiTEArsgCgrG0r
2QMK3Jrh6wQlmJx9NLyvp28=
=JSHL
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
