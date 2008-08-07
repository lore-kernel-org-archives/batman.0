Date: Thu, 7 Aug 2008 16:17:18 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] Gpsd
Message-ID: <20080807141718.GA12017@pandem0nium>
References: <a763b7ed5824a3032473d8d1732f0596.squirrel@unimail.uni-dortmund.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <a763b7ed5824a3032473d8d1732f0596.squirrel@unimail.uni-dortmund.de>
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
To: resul.cetin@uni-dortmund.de, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Resul,

BATMAN does not transport GPS information on its own, not for routing
and not for status information. We don't plan to do so either, other
programs should broadcast this kind of information (GPS, temperatures,
uptime, load, bittorrent file status ...). It should be kept simple.

Maybe you want to loop into gpsd [1] and see if this helps you. Maybe
there are already decentralized distribution systems for these things=20
(if anyone knows, please comment :] ).=20

regards,
	Simon

[1] http://gpsd.berlios.de/

On Thu, Aug 07, 2008 at 01:21:58PM +0200, Resul Cetin wrote:
> Hello People,
>=20
> is there an extension to configure gps data to batman routing like in Ols=
rd ?
> I will make some test with gps koordinates.
>=20
> Can anybody help me ?
>=20
> greetings
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFImwPurzg/fFk7axYRAlXGAKDtwMTUuUL7AMN+buzzxWbfXNa/NgCfch+8
JIU+++cpNDpqfNnbgkW9+90=
=rxjW
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
