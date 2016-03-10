Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 Mar 2016 18:44:39 +0100
Message-ID: <1676205.nXJgt3zli3@bentobox>
In-Reply-To: <1366236516-14512-1-git-send-email-linus.luessing@web.de>
References: <1366235673-13763-1-git-send-email-linus.luessing@web.de>
 <1366236516-14512-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2855198.7W4jkA50Uz";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: Fix broadcast/ogm
	queue limit on a removed interface
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

--nextPart2855198.7W4jkA50Uz
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday 18 April 2013 00:08:36 Linus L=FCssing wrote:
> When removing a single interface while a broadcast or ogm packet is
> still pending then we will free the forward packet without releasing =
the
> queue slots again.
>=20
> This patch is supposed to fix this issue.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---

You are talking a batman-adv interface when it contains multiple slave
interfaces, right? So batadv_purge_outstanding_packets would be called =
in
batadv_hardif_disable_interface and not in batadv_mesh_free (which is o=
nly=20
done when the batX interface will be removed).

This at least sounds legit and I cannot find where else this imbalance =
would=20
be fixed.

Acked-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
=09Sven

PS: This patch only requires the path change from / to /net/batman-adv/=
 to=20
apply via git-am
--nextPart2855198.7W4jkA50Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW4bKHAAoJEF2HCgfBJntG7hYQAJBx8J26Joq3vo/m/4rkqXMi
oNtwdOjjd8bqJy2DtS2wH6GCe20TpnBdgDjvEIL22uLLGXgQQVUkr5ip5wS0V/ze
N/2OgNZ96c5729xNRMDHg5p0Cu6f8IiW2mxjpw3gPBICWUOdTwL0L4EKaDqgvCwt
2cW1Zu2qMfbZHoSgjWtnQPzZS9bPjqBo8NrG0Z6wCE3wli6uNX6zhYQXAYZTMabn
M7FNG0YzYiLw69erom1zson91gZJto6bGuR+enIcQ2+L5DwCUGnmTzE0h7HVsCzJ
aIwjnquyBCc98q23c2770FUd3zFcbTQ3T9QG7ujaZgmun1/RqsLW/sJmG1v0HxFx
dngHgHQdP8i0FnfFY7xwe+C/va7tsuWCIEj9VQBe7e2wRYlWtQGgsHa5Mxn51EMO
8TcEWgYQ+kX4V8yfFa2eUqpgW6tAeHwUnRFwki+LtttC9Ju9OhBYzsZtOFWsWxZL
OSBIZoqSGyy/ZdkLZ9FOfkwm56VeKXJnvC6gqXQNbtglK18KGJqlxQzAZTX9NIHV
2X19OTervjKW2vE3RAoecp6vnzfzy1O0N4tY3CPbVi1uuRzRBZ/T/BWILCebRlQi
0xI3LXsxNIiypQ+AZUnkL/Y8q8YDs/k8KyDDnY/jRvSqPBeKGLYVRSB5NFm88JEh
c/tKt7HjghHVxsUfMyy5
=fMpg
-----END PGP SIGNATURE-----

--nextPart2855198.7W4jkA50Uz--

