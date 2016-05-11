Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 11 May 2016 16:16:59 +0800
Message-ID: <1773695.vA4OGxhCMG@voltaire>
In-Reply-To: <1462812114-16577-2-git-send-email-sven@open-mesh.com>
References: <6307812.WAqRcEYAvX@bentobox>
 <1462812114-16577-2-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1782314.Ys10Uh2snF";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v7 2/4] batctl: Add basic infrastructure
	to integrate netlink
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

--nextPart1782314.Ys10Uh2snF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, May 09, 2016 18:41:52 Sven Eckelmann wrote:
> From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> 
> Netlink can be used to add new communication functionality to the kernel
> module. It can also be used to replace the old debugfs files. The binary
> interface used for this will be defined in the added files.
> 
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> 
> Forwarded: https://patchwork.open-mesh.org/patch/16079/
> ---
>  Makefile     | 12 ++++++++++++
>  batman_adv.h | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  netlink.c    | 28 ++++++++++++++++++++++++++++
>  netlink.h    | 30 ++++++++++++++++++++++++++++++
>  4 files changed, 123 insertions(+)
>  create mode 100644 batman_adv.h
>  create mode 100644 netlink.c
>  create mode 100644 netlink.h

Applied in revision 8f0805f.

Thanks,
Marek

--nextPart1782314.Ys10Uh2snF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXMup7AAoJEFNVTo/uthzAf/wIAJ1XnDqosYY3YJXMqWzQdIYS
vJBw3rJvcMs1PphgGbtY7gR9nOnGdrF8hgZkXiVPiCp5MVrZGCwn3sqgvyrwrsoR
5clFYWW9yD6w9tJO+NN4r/7r5N05Ru7z2b2hsWvc9AzLoK1HGkGM+QyQYkuhlHdM
2ridXU4b0Wmhqo2YGW2y7OTNs0zOLzexyhgRrDxBC3GfKC8h9OtfigFUL/LGxMlZ
oMfy7B6J0XwY2hrLVQPs3aiNG9+GaBF44PJTnbst8BklpJGoZA0QmT8suT22Nkry
fptxrQj9Ps1IG4h9DTiVN02FrTbx/pd4yhtB76PiOebL5KnJFqQSveDNc+2GEZY=
=i8Dm
-----END PGP SIGNATURE-----

--nextPart1782314.Ys10Uh2snF--

