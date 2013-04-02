Return-Path: <ordex@autistici.org>
Date: Tue, 2 Apr 2013 17:19:31 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130402151930.GL4024@ritirata.org>
References: <1364903975-7141-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HBg0C3yr6HVa1ZCc"
Content-Disposition: inline
In-Reply-To: <1364903975-7141-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: properly push
 NET_IP_ALIGN bytes more
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@open-mesh.com>


--HBg0C3yr6HVa1ZCc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2013 at 01:59:35PM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
>=20
> every batman-adv encapsulated packet is supposed to begin
> with an Ethernet header plus 2 bytes for correct alignment
> on 4 bytes boundary.
>=20
> However, even if allocations are made correctly, the final
> encapsulation is not made properly since the encapsulating
> function does not push NET_IP_ALIGN bytes other than
> ETH_HLEN.
>=20
> Fix it by pushing the correct amount of bytes.
>=20
> Introduced by 7f91790974c258e71a62f6dee8cb1dbe5dff36c3
> ("batman-adv: Reserve extra bytes in skb for better alignment")
>=20
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>

This patch can be dropped.
We don't want to send those two extra bytes, we use them only for local mem=
ory
alignment.

Sorry about that.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--HBg0C3yr6HVa1ZCc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRWvcCAAoJEADl0hg6qKeOkW4QALyO2bwxE+DOL4WOFKkddMFF
wAQ9GLx3SPvQNDi85N4omo8M2H67PaO6PwAeHOdM98NBCYbIAexx4S2pWpH8Bh4i
6nFsvWlP5HhdwFEA0STGq0+TlC4zXB1+1DGzSoTdddYRamksFLdkFqSNmadY+KNW
/840gDmofLX4iSVuJNk1mkK1FqHJYWKhCWu6Hva+kNbo/eG8SSURSZvMnTC43VEK
B5iMvAxwnYkyKpxr+I1ysyKYtRb6wZKP1h0LeU6Il4es0jRESjmzSxi2lJYOWRYJ
prDngLd4VEgUFZFUloiIQpwlKqqwXDP8inLaVCy+APidY6dDWlpgWKG/lqUKyJPY
f4mrfjWeznMdy+MD2KsYf/v1oWZ9BYoGcX8xMEWV/tzmjLjbMcWe31nDvJDeskUh
f9bxvSCdkJLX4+/x5PL/7CqAoz4l9jyF9EqDfam5WdgAgzbhAHKeM90iP7yFYT5A
F6idO3bBsC/lzmYTTbz5GJZpFfcDc2cwcCT4hprNeuBAqZRvCKe9xNQ+RaWMQoj6
RDfBf9iwDr217hOxPVk+oiyXj4LVtJxq7NbzW8Om0I/EKtABoPbVlc2iqOeT9heQ
BNGvfLwDObhqz9CXBx9qf4LyZmPKPqdziZezyigJ4UAvgOh7LUZyCEfmPSWiDEfd
CQX8ZLhNBRjsviFlAPLn
=2TX4
-----END PGP SIGNATURE-----

--HBg0C3yr6HVa1ZCc--
