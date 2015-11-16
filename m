Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 16 Nov 2015 10:13:23 +0800
Message-ID: <9732868.d8RG61WZUP@voltaire>
In-Reply-To: <CAJuY50zaR=aT6UB+Nk0T3KrQMTkGKR=nGxw_HsB2+haYCkbbMQ@mail.gmail.com>
References: <511E55B5.60900@wirelesspt.net>
 <CAJuY50zaR=aT6UB+Nk0T3KrQMTkGKR=nGxw_HsB2+haYCkbbMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3084197.QoDyS6NLlN";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Classes and purposed classes (problem to solve)
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart3084197.QoDyS6NLlN
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Saturday, November 14, 2015 20:04:49 3zl Trizonelabs wrote:
> With multi-gateway there it seems the general problems how to
> influence the batman-adv gateway announcement in respect of gateway
> capabilities.

Can you explain in greater detail what you are trying to achieve ?


> Additionally we encountered the problem that a gateway lost uptream
> connection(internet) without switching itself from server to client,
> so nodes with path to that gateway routes their resp.clients to a
> "black hole".
> Question is how generally control the batman-adv routing in those cas=
es.

If you control the gateways the gateway should detect the uplink failur=
e and=20
stop announcing themselves as gateway. That is how most people are doin=
g it.

If you don't control the gateways or wish to solve this on the clients =
the=20
batman-adv module would need to get extended to influence the selected =
gateway=20
from=20user space.

Cheers,
Marek

--nextPart3084197.QoDyS6NLlN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWSTvDAAoJEFNVTo/uthzAKasH/3Fo/TyhIf235kyEwLvsoWjT
JUwhOpaA91NyfMU5DTZZ5nwoW1dX5DmmJZAExwM5as37hAAmIpRwXJl9yAbFDgF4
cpVABMo9jtC146ao7fROj6QJ4OPsyvQzk7GusYHAueEXdo4nwOtS7qTExbnDYBTx
AxcTnhR013I6i2R/OhI/e5djtjl2IUwZ8PyhA8p9/NO1PswNG67WYTMerCbxfGPu
LeKW12BoPAo9u2IxhiHEXkibT0NKfW/hyUxWoBxfi4DDS65n4ZRQP3fZoMF1SH+p
c+3ryWpko1eg6IEalHDASDE0uPFl0oMJhv7urW3oMZGq7myPp3NUb2DgW+57jzQ=
=4yRc
-----END PGP SIGNATURE-----

--nextPart3084197.QoDyS6NLlN--

