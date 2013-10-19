Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 20 Oct 2013 04:19:25 +0800
Message-ID: <1667097.Scrr0smqIn@diderot>
In-Reply-To: <1382189022-3987-1-git-send-email-antonio@meshcoding.com>
References: <1382189022-3987-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5105230.uVQcMaHHeD";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: fix arguments order
	when calling tt_local_add
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


--nextPart5105230.uVQcMaHHeD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 19 October 2013 15:23:42 Antonio Quartulli wrote:
> Introduced by c018ad3de61a1dc4194879a53e5559e094aa7b1a
> ("batman-adv: add the VLAN ID attribute to the TT entry")
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  soft-interface.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied in revision 148fc50.

Thanks,
Marek

--nextPart5105230.uVQcMaHHeD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSYulWAAoJEFNVTo/uthzAmOsH/1PAsGy1YQQJdKoKs0sLqUmu
cMwKdvXnVekbHbcmzxOMu5waXQVH0fLOMMMe7HpwWYrObZgWpxNNoge5BAGP9yt/
5WqZ8Xh8Mok3eWtDWat30BhM4g3XsIyY0N5IBT6tPrRYPwSrQ49OTciX6GI0gv1i
b+IHXOjG2/aOhL7ofU8+WHhxb8Sgui1A439g13dowSJvZOmYgVVaN1JePH4BTWek
XpAbvFYgoxSRfbtwYC2cgKxykc65S/Bl/e1lH3EQj7Op5FlrRFMNABx2nZEubFo1
e9ate4/LHVN9xmY0INU924q2xQHOD1hRyCGfnxI35c8oq2+mmH1QFCYsV6o/nlM=
=Wdnm
-----END PGP SIGNATURE-----

--nextPart5105230.uVQcMaHHeD--

