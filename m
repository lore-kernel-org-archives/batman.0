Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 10 May 2016 23:28:45 +0800
Message-ID: <1875667.fHtehojA4H@voltaire>
In-Reply-To: <1462812071-16467-1-git-send-email-sven@open-mesh.com>
References: <6307812.WAqRcEYAvX@bentobox>
 <1462812071-16467-1-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6254248.g4fFbHQqZp";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v7 1/4] batman-adv: add generic netlink
	family for batman-adv
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

--nextPart6254248.g4fFbHQqZp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, May 09, 2016 18:41:08 Sven Eckelmann wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> debugfs is currently severely broken virtually everywhere in the kernel
> where files are dynamically added and removed (see
> http://lkml.iu.edu/hypermail/linux/kernel/1506.1/02196.html for some
> details). In addition to that, debugfs is not namespace-aware.
> 
> Instead of adding new debugfs entries, the whole infrastructure should be
> moved to netlink. This will fix the long standing problem of large buffers
> for debug tables and hard to parse text files.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> [sven.eckelmann@open-mesh.com: Strip down patch to only add genl family,
> add missing kerneldoc]
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> ---
>  MAINTAINERS                     |  1 +
>  Makefile                        |  1 +
>  compat-include/net/genetlink.h  | 34 ++++++++++++++++++++++++
>  include/uapi/linux/batman_adv.h | 53 ++++++++++++++++++++++++++++++++++++++
> net/batman-adv/Makefile         |  1 +
>  net/batman-adv/main.c           |  3 +++
>  net/batman-adv/netlink.c        | 57
> +++++++++++++++++++++++++++++++++++++++++ net/batman-adv/netlink.h        |
> 24 +++++++++++++++++
>  8 files changed, 174 insertions(+)
>  create mode 100644 compat-include/net/genetlink.h
>  create mode 100644 include/uapi/linux/batman_adv.h
>  create mode 100644 net/batman-adv/netlink.c
>  create mode 100644 net/batman-adv/netlink.h

Applied in revision 2b20eb5.

Thanks,
Marek

--nextPart6254248.g4fFbHQqZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXMf4tAAoJEFNVTo/uthzAPqAH+wTi0u6/f52KhpOH9k9XiBXt
BY2cFGOxfYz0drSa3I1wGgBCPnBrGzm9LKwLCKupSG36zTLpCtIHHA6Mmqg2u2c1
B6y4exG4/OkKqkXnrNj8iSafqloxqY/1RHULLxNp7ZzzSL/bknwy8U/YQ0DKRgaP
erzp82WOwdyY/zadB4riSzvPbMraQmnxLUZha3qr0F0dOfc4jO3EcUB3Fxm0cbKp
uFxfMF/zF5Yla0O5CcYU/9TXtd9uI8c1c1OBSuzXLfMQt7Nx050P+q7PYc/lQs3w
yeArrTe65GO3E+irg/kh0R2ghQoVFwYijOfB6nbFup0ZJY4YhX2Zc7wiJalThQ0=
=M+VU
-----END PGP SIGNATURE-----

--nextPart6254248.g4fFbHQqZp--

