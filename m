Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 06 Sep 2015 16:07:04 +0800
Message-ID: <2157089.srdYdPRC4T@voltaire>
In-Reply-To: <1439565830-9776-2-git-send-email-linus.luessing@c0d3.blue>
References: <1439565830-9776-1-git-send-email-linus.luessing@c0d3.blue>
 <1439565830-9776-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1810671.YUgf4GzFjr";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 2/3] batman-adv: Remove unnecessary
	braces for test_bit() in NC
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


--nextPart1810671.YUgf4GzFjr
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, August 14, 2015 17:23:49 Linus L=FCssing wrote:
> Fixes: dfb27e75 ("batman-adv: Fix broken NC capability check")
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  net/batman-adv/network-coding.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 5abaf07.

Thanks,
Marek

--nextPart1810671.YUgf4GzFjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV6/QoAAoJEFNVTo/uthzAW9MH/RotYm7vhVWZII6yJlEnSVeK
f29YSoQ25HsWhN1Ld+lJkQh3v2K7xOgNXfq/G8P57n/No+uy/le3g/ogxuJIoiWL
okEg5uuEtZgrBo+l7uHygkkFhLFBRlw+aMqF7GdaWeEJbb1Wc580w2ERifm3UEA9
SX35uHmtgYq+/1tYU2F86hpWZbG+dwVBGvGJIEfJABgB8CQ/RYCO3NYRwZx+hgy9
vpT9h+FVOULLT4tqmLupYQzVjlK4D0EQdKdxV+3LpqNs3k5qNDVmZJ2duoZJFviT
xL9BNMtnsZPOHyomp+UrcU5Xm+kzn7DXVq8xUqDX8R99kyz20tflinz3sLxj4e0=
=boxv
-----END PGP SIGNATURE-----

--nextPart1810671.YUgf4GzFjr--

