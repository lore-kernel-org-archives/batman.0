Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 08 Jul 2016 17:50:29 +0800
Message-ID: <6861135.rRYW7QbeoD@voltaire>
In-Reply-To: <1467970715-18251-1-git-send-email-sven.eckelmann@open-mesh.com>
References: <1467970715-18251-1-git-send-email-sven.eckelmann@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4423056.h3oADlmSjA";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv-devel: Exchange include order
	for uapi header files
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

--nextPart4423056.h3oADlmSjA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, July 08, 2016 11:38:35 Sven Eckelmann wrote:
> The build of netlink.c currently fails because the definition of
> GENL_NAMESIZE and similar things are missing. This is is caused by an
> incorrect order of backports and non-backports header files mixed up with
> uapi and non-uapi header files. Parts of the header files would not get
> included by include_next because it not anymore in the remaining search
> paths.
> 
> Reported: Marek Lindner <marek.lindner@open-mesh.com>
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> ---
> Please check again - I might have forgotten something.
> ---
>  batman-adv-devel/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied in revision 5306b0e.

Thanks,
Marek

--nextPart4423056.h3oADlmSjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXf3dlAAoJEFNVTo/uthzAHC0IAIUnzHLfH1jHpEXAWmFWpwMA
DFNbvngJS4hwJqKpfQE86n9vQlRq2ZzQL8MyzniXxaGAiwsnLex64G34cRnRS2a1
8Yj5fsqm8luuy0HirLuSKYS12NNDXUDp6htjh0kX67MSoH0Hqq5NFeMrDGotlUor
OJKA5oCDjB3hguZEjCogTUcP6rIORuf89ir/2ufGPYxo63r/22UT+9aFLqOEccpP
d/BEUqARQDlZ1Kb1pma92utAg0MmxuKlOf8e3MRegqwYROjQ8HnBlfRLH4Qv7rtT
9fp+kFHYjZSwKQ+SEqOfwkmZmP/5zGxQpNdH6rlK6H11GbdRtKvpi6eGBaQq+RY=
=Yac/
-----END PGP SIGNATURE-----

--nextPart4423056.h3oADlmSjA--

