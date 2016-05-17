Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 17 May 2016 16:08:21 +0800
Message-ID: <1676711.kYp5gAOYDX@voltaire>
In-Reply-To: <1463153416-6569-1-git-send-email-linus.luessing@c0d3.blue>
References: <1463153416-6569-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7632138.zEae9FReUp";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 1/2] batctl: adding multicast debug
	level
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

--nextPart7632138.zEae9FReUp
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, May 13, 2016 17:30:15 Linus L=FCssing wrote:
> From: Linus L=FCssing <linus.luessing@web.de>
>=20
> This patch adds the multicast debug level to check for own
> multicast flag changes for instance.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---
>=20
> Changes in v4:
> * rebase to current master (no conflicts)
>=20
> Changes in v3:
> * none
>=20
> Changes in v2:
> * added a sentence about 'mcast' log level to manpage
>=20
>  README       |    1 +
>  man/batctl.8 |    6 +++---
>  sys.c        |    5 +++++
>  3 files changed, 9 insertions(+), 3 deletions(-)

Applied in revision 55042b3.

Thanks,
Marek

--nextPart7632138.zEae9FReUp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXOtF1AAoJEFNVTo/uthzASRgH/jE5TaYx3AScBW+/W1L/nTyz
6N3iWb3c8muapVIC0I05n3c25g2iGv/DJQe82KZQavJdhma1YDT2XfCA7dEVO+AI
Q2rQaJWSlA9ENl6MWb7hX7uU3igRqG41O5sUB2Kd2Nzt5rWIUi0DtdaLgFDgDqUZ
7P/2cNJeQtrJHfABkxXoTfqEuHpI5w5qyQU6axx7FJ9jx+0AibecHeZFa7j5Id0N
yVLyH2WkRoLyP/yycEniBhSGFPS3iL3iChgjTfxz7IqctUsLd+nukdOaBKCzpBcf
dF+6W/8uB8eJVB1BifKxyZ3wR0CQWXksoZOy2XGy200Gw6bmbagEb8QXJtssato=
=UVwP
-----END PGP SIGNATURE-----

--nextPart7632138.zEae9FReUp--

