Message-ID: <4821D62A.4010705@leo34.net>
Date: Wed, 07 May 2008 18:17:46 +0200
From: Daniel Paufler <dpaufler@leo34.net>
MIME-Version: 1.0
References: <51B22798-78A8-4425-BAEA-530297B1518A@cslab.ece.ntua.gr>
	<4821B37C.4080608@leo34.net>
	<200805072203.33919.lindner_marek@yahoo.de>
In-Reply-To: <200805072203.33919.lindner_marek@yahoo.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig37B7057A4BA7C13903E782D7"
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
--------------enig37B7057A4BA7C13903E782D7
Content-Type: multipart/mixed; boundary="------------080804050208090104000707"

This is a multi-part message in MIME format.
--------------080804050208090104000707
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hey Marek

Marek Lindner wrote:
>> I am mainly interested in redistributing zebra routes to batman as i d=
o
>> with olsr_quagga plugin. This way, i can think about switching from ol=
sr
>> to batman 0.3. Perhaps, you will enable it in your code again.
> it was never "enabled" - it was part of a patch.
> I'm not that familiar with zebra/quagga. Can you explain what you need =
and why=20
> the dynamic HNA adding/deleting is not enough ? That feature did not ex=
ist in=20
> revision 502.
Enabling zebra to tell batmand to add/remove routes needs a patch in
zebra. It would be really nice to have a batmand plugin whatever that
talks to zebra for getting dynamic HNA routes. So i dont have to modify
my zebra, but can enable a plugin in batmand (as it is in OLSR).

I need this for BGP routing. Imagine to route two batmand clouds
together via BGP. If the third cloud joins, i dont want to reconfigure
the other batmand-daemons. They just grep the routes from the running zeb=
ra.

Another big option would be to let zebra speak batman / olsr protocol
and be able to configure batman / olsr through zebra interface /
configuraion. But that would be "top of everything" and imo not necessary=
=2E

Greetz

Daniel

--=20
Dipl. Inf. (FH) Daniel Paufler
Angewandte Informatik - Computer Aided Facility Management



--------------080804050208090104000707
Content-Type: application/pgp-signature;
 name="signature.asc"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4yLjIg
KEdOVS9MaW51eCkKQ29tbWVudDogVXNpbmcgR251UEcgd2l0aCBNb3ppbGxhIC0gaHR0cDov
L2VuaWdtYWlsLm1vemRldi5vcmcKCmlEOERCUUZJSWNHQXE2eW1GVWtaTFRJUkF2dW1BS0Rx
OXp6Qll4ZmVxUzM1UW5WYXQydlpJNFN0NndDZEU3dTQKdC9jQ3hCa0xManlUSEY5RVUxS1px
TFE9Cj03dWt4Ci0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQoK
--------------080804050208090104000707--

--------------enig37B7057A4BA7C13903E782D7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIIdYqq6ymFUkZLTIRAnurAJwJGOJsk++1a96Rwqkb1OSjYfm5EgCgtkUF
ONtnK+TIZmGfrOfgXNg/yBk=
=Kcig
-----END PGP SIGNATURE-----

--------------enig37B7057A4BA7C13903E782D7--
