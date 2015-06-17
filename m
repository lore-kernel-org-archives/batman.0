Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 17 Jun 2015 18:37:24 +0800
Message-ID: <2024417.V1B4mkns3E@voltaire>
In-Reply-To: <1434467426-4281-3-git-send-email-linus.luessing@c0d3.blue>
References: <1434467426-4281-1-git-send-email-linus.luessing@c0d3.blue>
 <1434467426-4281-3-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1445741.7HuXUInKSL";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 maint 2/5] batman-adv: Make NC
	capability changes atomic
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


--nextPart1445741.7HuXUInKSL
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, June 16, 2015 17:10:23 Linus L=FCssing wrote:
> Bitwise OR/AND assignments in C aren't guaranteed to be atomic. One
> OGM handler might undo the set/clear of a specific bit from another
> handler run in between.
>=20
> Fix this by using the atomic set_bit()/clear_bit() functions.
>=20
> Fixes: 7dd9d8992b0c ("batman-adv: tvlv - add network coding container=
")
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  network-coding.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied in revision 586df9e.

Thanks,
Marek

--nextPart1445741.7HuXUInKSL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVgU3kAAoJEFNVTo/uthzAJ1oIAJr9w2D5XiWtndJfE58zdkOp
nZWglrXxcWkbSS8ZbYDPLuQcEUfFjp72JPaduQV2dalUqzGmaHwURow4cPAg61uw
xvma0jmfoXqBxeXBPMAKdVTsRMRap8jK0hodzwW1Xoa3r9ncShR44w5mggs+gBeA
QJLyrrj2k/vWNeJYchsvwqOQMsBA6/egvjLP6PwjfgMB+5g+hil6LEsd62/a8N/a
+DBB5I1SCFcGKltl42WEgUP7qpS+dFLfj+0pHSYZN6QN8ttEG9Rl6Qlb4Ybr7QgH
Y9akWFP4O0M8KqJkcNnc5nXqCPqwPnoIPclBGV7iR1kBzucM2D2qhHYxK8eqopw=
=IMUA
-----END PGP SIGNATURE-----

--nextPart1445741.7HuXUInKSL--

