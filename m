Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 16 Feb 2014 14:12:52 +0800
Message-ID: <3265052.kWx0Wm7c0A@diderot>
In-Reply-To: <1392461881-2435-1-git-send-email-antonio@meshcoding.com>
References: <1392461881-2435-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1420468.rM0UhcWeS1";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: add kerneldoc for dst_hint
	argument
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


--nextPart1420468.rM0UhcWeS1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 15 February 2014 11:58:01 Antonio Quartulli wrote:
> Some helper functions used along the TX path have now a new
> "dst_hint" argument but the kerneldoc was missing.
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
> 
> Changes from v1:
> - comment rephrased (thanks Marek!)
> 
> 
>  send.c | 1 +
>  send.h | 2 ++
>  2 files changed, 3 insertions(+)

Applied in revision 4d421fb.

Thanks,
Marek

--nextPart1420468.rM0UhcWeS1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTAFbsAAoJEFNVTo/uthzAgVQH/im05+4mQHKPy31sojiF94fo
J8qG9u7tbrBAoKTAx7VJAOzrfx2ADnBcyEfPTytWaAsxJxHAbAf/neVb96qyA132
D9+OCqkRhzdAYjd89trQ90GvuDtmKSw1IK6JQ4eeEBxz6gZ4h51PC6rPX03Ldxt5
an5lUbtcSNgqH9QKuoZ3A0UayKKFsCi7I9c8pRD1wnrLCne1SF0jXCysOZ7MMxee
wuNuvp6y7RbwPHux0GLBfv8K7EOyE1fDM2fzk087xZ/mN4VI8MRHuv5gOWKdGvOv
I/87oiB62Tu5YKE13IF/F+iv3KoR6jN4S3jn1dSPdJb9ZL+itj5/EQ00Dc/N05s=
=ryGq
-----END PGP SIGNATURE-----

--nextPart1420468.rM0UhcWeS1--

