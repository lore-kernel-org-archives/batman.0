Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 14 Dec 2009 01:26:51 +0100
References: <20091213203156.GA5016@Linus-Debian>
In-Reply-To: <20091213203156.GA5016@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1573728.j8czA3dBQi";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200912140126.55424.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] wireshark-batman-adv: Displaying issue with
	vis-packets
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
To: b.a.t.m.a.n@lists.open-mesh.net

--nextPart1573728.j8czA3dBQi
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Linus L=FCssing wrote:
> The second originator field of a vis client update packet looks a
> bit odd in wireshark. Sven :)? (have a look at the attached
> cap-file for an example)
Thanks. This is fixed in v2009.2.0-2-g6f93aff

> I was also wondering about renaming this field maybe, in the
> beginning I got quite confused by seeing two identical originator
> fields in most vis packets. Maybe it should be renamed to previous
> sender or forwarding originator instead?

It is changed in v2009.2.0-3-g33f16bd

Nice catch and bug report :)

Best regards,
	Sven

--nextPart1573728.j8czA3dBQi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLJYZLAAoJEF2HCgfBJntGaIEP/izkkjGZT0x66HQ+vQ6SGh9a
KNZuu4UtsnAOzUJU0mqjb5HeJgILMFPLQevKbHAdoE3WQMyB3NS8cKdgAsFrrqhx
yQO51jSQrMqkSbomTY6316BS2u91RLYLYxWsSjTQZTIP5tokaiO2CpiBpnF1wkr6
lJkhF/DH9meD4Kroa+J2/j1olKGOdIzTeCtQp+MWRy/WieDFhzeTNzidUHgfXcN+
5lNZ0KebiAnr0Y9yqWBEwdNLpiNfZ2uepzes7R/RjXPoqJc+obLMrZbFspbqdA0S
e2R6iyeliSHzyYr4ey2hhOVz83aov+Z6ypaDgFCXEBF9qSJQMhfROSKV1PgsTtk3
J78xxXzOdOtZl1tq8M3L9fhK9X7gT02YMLxr8p8oL9DJsIIL2A/d7W3QThRmP4zc
V4QSNVEc8ZloHcCub9LCzoW/DI+I5D5dNJSEwbyQTHxYZG0O36kNJlP3mhGtvQhk
xODbBCIes6ALCAzXqSBtZVeKznp7lu/T6scVEbBKMkWAnNOsoWOUs+vMGXlZCK6z
/aKRVEVhdXMaOMRjoMrOpXmvhIlpQB+cVce8L23q65JYnMMqQDM4SuoCAPsgU78N
Wk1uUzFSo+SNyz0Lx79+jtA7IRRJuOeM5OfGpNKE5qxHZ0DdGqNb+/joNS4UgsLQ
UrWxYZlveeayn4msp+Wn
=/Ojc
-----END PGP SIGNATURE-----

--nextPart1573728.j8czA3dBQi--
