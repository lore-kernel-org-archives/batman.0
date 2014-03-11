Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 11 Mar 2014 18:12:13 +0800
Message-ID: <1829140.2fHYrOKtOG@diderot>
In-Reply-To: <1393082406-3615-1-git-send-email-antonio@meshcoding.com>
References: <1393082406-3615-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1699520.tmCSJpazbU";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: properly align constant
	assignments
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart1699520.tmCSJpazbU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 22 February 2014 16:20:06 Antonio Quartulli wrote:
> All the assignments in packet.h are properly aligned.
> Also the multicast constants have to have a similar shape.
> 
> Introduced by 1c090349e2f65d19a7f356cc0b61f13644c53bb6
> ("batman-adv: Add IPv4 link-local/IPv6-ll-all-nodes multicast support")
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  packet.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied in revision c77850c.

Thanks,
Marek

--nextPart1699520.tmCSJpazbU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTHuGAAAoJEFNVTo/uthzA3uwH/iFVnBhe8D2vHsyrSD3/EigZ
DcVPEzhSrGUekiTLx4BwLrbYjX5UMrg0l2QZXhRhRKFmDD6diJ6G4lTwdSCiPZa5
duvnq6J5z+4vDdQuuGGmYe6iMVb+wfvZYSkvVMtAsQ7rNOmYq1BemfHGqnDph2Us
3zKerY8GaNXK+A1kYa4cv0tsgJw0L+p1Iv2EMrZ/221wejSCA0Tm2Ja62Ly0/FMU
GAYsvHLsVbxhBUoCr9+PvTgxdJSnNaWPkZsP9p97cFcDULLOvR+8jJiFv8KU8ZtT
f5Ol85YLtrGyGcDxXzu/GUEg89/gLP6PBNYRO4W1Ew8PXhEjeoaMAu9FzuZ+JcE=
=qDIq
-----END PGP SIGNATURE-----

--nextPart1699520.tmCSJpazbU--

