Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 17 Jan 2010 00:40:23 +0100
References: <EACB115D0487C4459885C4B54EE8D9CF05D74AAB@USDALSMBS02.ad3.ad.alcatel.com>
In-Reply-To: <EACB115D0487C4459885C4B54EE8D9CF05D74AAB@USDALSMBS02.ad3.ad.alcatel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7495171.DuVjWF21sV";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201001170040.31071.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Security on adhoc network
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: LAMBA Jaideep <Jaideep.Lamba@alcatel-lucent.com>

--nextPart7495171.DuVjWF21sV
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

LAMBA Jaideep wrote:
> Are there any solutions currently under implementation for providing
> security (other than open/wep) over adhoc networks ?

What kind of security do you need? Security is a big field. Maybe you just=
=20
mean encryption and authentication.....

When you only want to make the whole wlan stuff unreadable for the outside,=
=20
you could just use WPA_NONE. But this doesn't resolve the problem that the =
key=20
could leak and make the mesh attackable - but that is something which could=
=20
always happen. So it is probably not a solution for freifunk projects, but =
for=20
mesh networks controlled by a company.

There are other ideas for traffic over batman-adv. Just forget about=20
encrypting your data over wifi, but instead do everything some layers above=
=20
it. I think Linus had some ideas in implementing the needed authentication =
and=20
encryption over IPsec in a mesh. I am not sure what his ideas were exactly,=
=20
but maybe he could add some more information about that.

And most of the encryption and authentication stuff has to be resolved by t=
he=20
user and not by the network provider. This means https for sensible data=20
instead of http, ssh instead of telnet, pop3s instead of pop3 and so on.

So it really depends what you want and cannot be resolved in a "security fo=
r=20
everything, against any attack and for every purpose" blob.

Best regards,
	Sven

--nextPart7495171.DuVjWF21sV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLUk5oAAoJEF2HCgfBJntGKMoP/j2fDhi8Fr9bqaTrBvmCEE/o
iz4C4lU57E5t6n1zBUl0l8zr1oLSKsnEK8AjGRzWcoHTYP0eH+sxjAXo/0iPFJP6
M1qZpoqdNsW01Sv3cR0smwgkxvvh16z6KFY7qH8NySG6buk0YveXZyAoEa8LpxtF
FV6OXRwy5SRQH83EcZshpSehg+cyIqrCOLX82RXYdpe4X2/vk8VuY2uG/bq8rh7w
xMXNbZPg1UN4C9EkS9pfQTI2E0UF27bQbQx6KyKMtCfpjFQ/nXQ7czTpHjUH4Grw
CpSlTx3NU4YrscAaN75z0op70y4PgeKyymt3VXx9rHxyUCV3OspCR1fthhsKymxa
Ua7su0U/kkV0MIuv4Ua+ofPiU0lu6kweUmqXxjql36CsCZxsFLclFAqYEarURLvt
ZV9wCAcWPFwrFC3fr5BXdL6fmBeYNn7LWhe3Ln+HTAHkPY4eP9Yn2axNmKb1vXrT
d3ue0Qmr5FIHtefPaA3AWWfHUf4Zu5/jJ57m5vMaXuyQJGwdsNJ7rCiSiTPsdW5S
mqgjL5pUl48ebN3HJyBevB2F/cUXL1Vaic6DP3JRwRzEzj1+6pOImiERc94vHKud
lzTRpHF07X4vR5+Xowl3hp5TqVvZRy4kUafK4PS+X3nPISA2Zuts0vQlv2sTsiiO
2aZd6JYQ1kcQMquQBI8i
=bngg
-----END PGP SIGNATURE-----

--nextPart7495171.DuVjWF21sV--
