Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 10 Nov 2013 11:32:08 +0800
Message-ID: <7485220.UFT0vr62Ck@diderot>
In-Reply-To: <1383743711-10143-1-git-send-email-linus.luessing@web.de>
References: <1383743711-10143-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2021417.RIW9E5uViu";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: add missing multicast.h
	include
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


--nextPart2021417.RIW9E5uViu
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday 06 November 2013 14:15:11 Linus L=FCssing wrote:
> Not having it doesn't seem to break anything, but looks like it's
> recommended C practice.
>=20
> Introduced by: a3f58139efedb96222dffdda89896c243fdff49e
> ("batman-adv: Multicast Listener Announcements via Translation Table"=
)
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---
> Added "Introduced by" clause
>=20
>  multicast.c |    1 +
>  1 file changed, 1 insertion(+)

Applied in revision 16d633d.

Thanks,
Marek

--nextPart2021417.RIW9E5uViu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSfv44AAoJEFNVTo/uthzA8uAH/AyyYQ2wB8E73xsHSPJwpWwt
Kh7VfSEahOFdHfqrrcS+j9tfzcRFnNDxr9Vzvkit2ptnu+tmEgtrSn5rf57SFL0N
9M7RQWMzTPj7xh9zah+stOx24MC5NQZhZaM6Jk3c7535I7C3KO2NJ0NLJF9VhBp7
RJC2/5rDyhUfrohRfhEY3q0rmUKJr9Hwa12HAqufUNAgRTySHKT7O+I8lP/j9MeZ
RkmV3heKEyB19as+8Qore8IQ+8eIiBpBboyfAIXzN+bFZStQ1Ft8yDkAxDquj9Xu
ch6yY5+VqnM7SGFcitu7F11YSNRail7jKiDPZpbJ8nrCt6HBG/gQBAkHFM2i9HY=
=nQcL
-----END PGP SIGNATURE-----

--nextPart2021417.RIW9E5uViu--

