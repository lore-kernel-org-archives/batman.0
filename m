Date: Thu, 13 Mar 2008 09:41:00 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv / mac-addresses without leading zeros
Message-ID: <20080313084100.GA21613@hrz.tu-chemnitz.de>
References: <1205334058.47d7f02ae5c39@mail.bluebottle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <1205334058.47d7f02ae5c39@mail.bluebottle.com>
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


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bastian,

the output comes from ether_ntoa(), but i personally like the padded
output more, too. ;)

So the latest revision should print pretty MACs. :)
best regards,
	Simon


On Wed, Mar 12, 2008 at 03:00:58PM +0000, Bastian Bittorf wrote:
> during batch/debug-mode the output of all
> mac-adresses is without leading zeros, e.g.
>=20
> 01:02:03:04:05:06 =3D 1:2:3:4:5:6
>=20
> we would like to replace mac-addresses with
> hostnames [1] for better understanding of
> the debug-output. Would it be a great problem
> to strictly output full mac-addresses?
>=20
> bye, Bastian Bittorf
>=20
> [1]
> each router 8-) has a list with
> mac =3D ip =3D hostname
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQFH2Oicrzg/fFk7axYRApMNAJ94wGFj4zXcs1nyxSH7P9GcUM4NrACVE2jh
kMYyWvceIVk0/7T3/tHUWw==
=4XiJ
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
