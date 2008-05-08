Message-ID: <4822C548.40603@leo34.net>
Date: Thu, 08 May 2008 11:18:00 +0200
From: Daniel Paufler <dpaufler@leo34.net>
MIME-Version: 1.0
References: <51B22798-78A8-4425-BAEA-530297B1518A@cslab.ece.ntua.gr>	<200805072203.33919.lindner_marek@yahoo.de>	<4821D62A.4010705@leo34.net>
	<200805081723.37648.lindner_marek@yahoo.de>
In-Reply-To: <200805081723.37648.lindner_marek@yahoo.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0BCB86E2E2D99FE3AD805F03"
Subject: Re: [B.A.T.M.A.N.] 0.3 final <-> quagga
Reply-To: dpaufler@leo34.net,
	The list for a Better Approach To Mobile Ad-hoc Networking
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0BCB86E2E2D99FE3AD805F03
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Marek

Marek Lindner wrote:
>> Enabling zebra to tell batmand to add/remove routes needs a patch in
>> zebra. It would be really nice to have a batmand plugin whatever that
>> talks to zebra for getting dynamic HNA routes. So i dont have to modif=
y
>> my zebra, but can enable a plugin in batmand (as it is in OLSR).
>=20
> Your concept of "batman plugin" confuses me a bit. Is that a plugin in =
batman=20
> or a plugin in zebra ? And what are the functions it provides which can=
't be=20
> provided now and why ?
Its a batman plugin like an olsr plugin. zebra doesnt provide any
plugins imo.

You provide a external switch to insert HNA by script. Unfortunately,
zebra cant call external script as i have to patch zebra then - or i
dont know how.

with the olsr-quagga-plugin i can redistribute zebra routes to olsr
internally. thats something i like to see with batman-zebra-plugin.

Greetz

Daniel

--=20
Dipl. Inf. (FH) Daniel Paufler
Angewandte Informatik - Computer Aided Facility Management


--------------enig0BCB86E2E2D99FE3AD805F03
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIIsVKq6ymFUkZLTIRArGEAKCTfegTXFawaWiCcaU4cU6pyk4s3ACgtMwV
QU0Nvv4qmbklx4ttxbpWBUU=
=TxE3
-----END PGP SIGNATURE-----

--------------enig0BCB86E2E2D99FE3AD805F03--
