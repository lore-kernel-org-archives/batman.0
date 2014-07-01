Return-Path: <antonio@meshcoding.com>
Message-ID: <53B29AFF.2070405@meshcoding.com>
Date: Tue, 01 Jul 2014 13:26:55 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <CAHxBzxWTprWsPASmNNGXQqj58LRuAHUkNVtXcWHc1PdoD_4+KA@mail.gmail.com>
 <20140701085027.GA2341@Linus-Debian>
In-Reply-To: <20140701085027.GA2341@Linus-Debian>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2EfFLXSvoaN9VVapKHu3XJ4iqjFO25bvQ"
Subject: Re: [B.A.T.M.A.N.] Roaming issues in basic network
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
To: locborgtus@gmail.com, =?UTF-8?B?TGludXMgTMO8c3Npbmc=?= <linus.luessing@web.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2EfFLXSvoaN9VVapKHu3XJ4iqjFO25bvQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 01/07/14 10:50, Linus L=C3=BCssing wrote:
> It could be a problem with a not yet updated MAC address table in
> the bridge, therefore the bridge on node A not forwarding ICMP
> requests from client 1 towards client 2.
>=20

Hey Linus,

I agree that the problem is probably in the bridge, but how can it be an
inconsistency in the table given that the bridge is receiving the Echo
requests from client 2 through bat0?

Shouldn't this immediately update the bridge table to reflect the client
movement (client2 --is-behind--> bat0)?


@Simon: are you sure that the client is not associated anymore with node
A at that moment (maybe it was jumping here and there)? You said that
you can fix situation this by deleting the station entry, but is this
station entry obsolete at that point? (meaning: is the inactivity time
high? - you can see this through the "iw dev wlan0 station get <client2
mac>" command before deleting it)
If not, it can be that something wrong is happening at the wifi layer
and given the driver you are using (ath5k) it would not be totally
unexpected.

I am asking this because I expect the station to disappear immediately
in case of roaming (the client usually deauthenticates itself before
associating with the new AP). Still, we can have cases when this does
not happen, but the AP should be able to react properly.


Cheers,

--=20
Antonio Quartulli


--2EfFLXSvoaN9VVapKHu3XJ4iqjFO25bvQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTspsDAAoJEJgn97Bh2u9elcoP/RzcsBtmG8W49S2G7hWGdgJZ
p1Q4ZBogWOUtFqAVxmY5SyKE0oh197zNQLvke9pMG/c68BymzxQna1j5L84vmqgn
T/gPMav8ivSzbGuXWkYVrzSGcc3aC3wwO/oE93d7su4TtSBdyWP8WIhWrL4xNpMo
VfX60/fVkiTQCPHfCqS2uEgbFOTTLFbRH+IMbNo1AJ8+ms6u/EUatknCHGV7m0sm
KC/YrnQp5iPn+UFpg54cOCD/f2fPskg/Js/VX4NYLf51428HK5SxwvKWVIIELNyJ
OT/7Yp8L6HWwv9SNfDhKCwGa5cI7QYYi9YPA75FdvbkEvDa8GnJiN2gGsF5dBxqR
K/7/Nwi4UgedDwF1nS7XXJapTYn0vwiDRKktQOm/f0wLeSaRCgTunO1QH6ceiv4V
CI0whHu2LOWeQN1uh2QWLM5FqqSjdFqLXogMrKkMAPIelvkAhkBbBDpqKpfC8P4M
g6mtyM4ZGuw7rpQ+G3wOm+xKa7Jg4jPDZBZ/14YyJYqXPNrZ9t1pzWgmktuIDDx3
+cCdRVaUkxjxHwOeQbV3Z95n2vplDjxHR4v606gjGzn1EjOivu1Ortl+3wQ5m4Dm
neyLqPYJehozvsThWe7q1UDuk8v5ulYWqrhbmEVcaxgvD1c5Uiypvsjs/j/5jxyd
8yy+BNYqULlG9aMB/wb1
=RbfD
-----END PGP SIGNATURE-----

--2EfFLXSvoaN9VVapKHu3XJ4iqjFO25bvQ--
