Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 14 May 2014 19:46:21 +0800
Message-ID: <1777069.zHZEjYMbUp@diderot>
In-Reply-To: <1399740997-30784-1-git-send-email-antonio@meshcoding.com>
References: <1399740997-30784-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart23337051.ivkVNVaaHh";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add blank line between
	declarations and the rest of the code
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


--nextPart23337051.ivkVNVaaHh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 10 May 2014 18:56:37 Antonio Quartulli wrote:
> Reported by checkpatch with the following message:
> "WARNING: Missing a blank line after declarations"
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  debugfs.c               |  9 +++++++++
>  distributed-arp-table.c |  1 +
>  network-coding.c        |  1 +
>  sysfs.c                 | 10 ++++++++++
>  4 files changed, 21 insertions(+)

Applied in revision 869a0e5.

Thanks,
Marek

--nextPart23337051.ivkVNVaaHh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTc1eRAAoJEFNVTo/uthzAeAwH/j99GersbzR4I86zj7RYZAgA
btbx1kTUbAmfNaEry8RwCWqnn8+7cMlN8gXT2CarK5Rs+ACHsM1/x2K3x3JHqyPS
uOTPEjpXFbpU0MkplGBUFbnfRnQZIH3eC/svpkIZmsX+aODXD2Cl9YxxrcyaE94X
SGX3Rya9KenapFnscyEKvovZaJskgqieaHY1azYs+cBNO9c9Fttr7DEf4qfjDYjj
jzqeAESv6V9ZiUUNwoX3t23RBoB0FeY/9uUKaxWkydPUCd+ht/EiweY/UvWnz7qZ
sHjlvuOVtYj1O31qEzTZnIAAK+SZbqhfpUD5lsWoPlD04xAQ+3250bg03eunXXU=
=cIWh
-----END PGP SIGNATURE-----

--nextPart23337051.ivkVNVaaHh--

