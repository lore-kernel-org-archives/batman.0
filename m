Return-Path: <antonio@meshcoding.com>
Message-ID: <5303C934.8060200@meshcoding.com>
Date: Tue, 18 Feb 2014 21:57:24 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392670129-2498-2-git-send-email-antonio@meshcoding.com>	<20140217.161314.741869447870850076.davem@davemloft.net>	<53030165.2050404@meshcoding.com>
 <20140218.154152.94226033273009453.davem@davemloft.net>
In-Reply-To: <20140218.154152.94226033273009453.davem@davemloft.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="teqPVMJPlCWfjAVjW1nOpwdcITV6CoTFu"
Subject: Re: [B.A.T.M.A.N.] [PATCH 01/10] batman-adv: fix soft-interface MTU
 computation
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
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, mareklindner@neomailbox.ch

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--teqPVMJPlCWfjAVjW1nOpwdcITV6CoTFu
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 18/02/14 21:41, David Miller wrote:
> So I pulled this, but I just want you to know that you should really
> start to bear down and minimize the amount of changes you are submittin=
g
> for 'net' as we're starting to get deep into -rc territory.

I decided to wait until the last bugfix was ready before sending the
patchset....but I imagine a better choice is to send the big bunch as
soon as possible and then keep the small remaining bits for later.

I will do that next time.
Thanks!

--=20
Antonio Quartulli


--teqPVMJPlCWfjAVjW1nOpwdcITV6CoTFu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTA8k4AAoJEEKTMo6mOh1VvA4P/jxVaCEAMCP6agZkhKQVRN9p
/NQH+8CNUweoAtK7kHhys4VchxkMuwSmX4JcTDCEjQOPHSjcdxOuuGnjUOEaqKOb
AoyS4ugSX6Sd4lplWA5gL98ShU1YAABZJbbcsTbAiX5eYMitfEv8SIojrhO8Ug2X
F9rT+4ZRDVArJR3FqYtZKP6Cm+xskGEvzLnqI7KckMCulde/kEw1NWxhv3gJ4fu0
XrTsvsjcQTYlmTISMr+wT10N2tHQ00BBOunUCUPE6ti7bezxT3/hE/eUMcYwmWMZ
sb6K4tff18sT1eSKIPow/teGP1C0FFmAbtFFmMswAvuQXxOy9cJUaM8OHc2RhBY1
XLXr55sMV3G3G98atiIAwCrFSXui6HPi8SuKAhfbU691b6/d+4ozNC0Jb62wPxY7
ok4eOm9xaF14gkA9rylQj/ONCKIf4XTdPWR0pn5sc65vIJxi148udyn/0VywesXl
XFWVbm/LD4TAIo9UnGGgN/eE2CSOWlf0rnFhU4lqI0X300xZs63CtGoC5+BXwEyL
i9plwMockf+kk1g5xf/egaL3WI3/iKKYHjy/qZVj82zTwrkQrb7hWZL9dKah+oo1
kMes3l3ojMIzWF/Ms6GsB4uQOMZQhzLnpboJDgOJNy6R7nIB+FIdbfVT33wXu6bN
5N6nmACplLu44137EEwg
=f3Av
-----END PGP SIGNATURE-----

--teqPVMJPlCWfjAVjW1nOpwdcITV6CoTFu--
