Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 08:12:47 +0200
Message-ID: <6222779.RWVmag3jgT@sven-edge>
In-Reply-To: <1461876897-12677-3-git-send-email-andrew@lunn.ch>
References: <1461876897-12677-1-git-send-email-andrew@lunn.ch>
 <1461876897-12677-3-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1943332.NDgg6MdQlS";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batctl: Use netlink when available,
	rather than debugfs
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

--nextPart1943332.NDgg6MdQlS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:54:57 Andrew Lunn wrote:
> The kernel has gained support for exporting information via netlink.
> Use this when available, rather than debugfs. Netlink has the
> advantage of being network name space aware, where as debugfs is not.
> 
> If netlink is not available, batctl will fall back to debugfs, so
> should be backwards compatible with older kernel versions.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  Makefile    |  20 +-
>  debug.c     |  19 +-
>  debug.h     |   4 +-
>  functions.c |  11 +
>  functions.h |   1 +
>  main.h      |   1 +
>  netlink.c   | 810
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 7 files
> changed, 862 insertions(+), 4 deletions(-)
>  create mode 100644 netlink.c

It looks like this patch currently only adds the printing of netlink 
information in a way that looks similar to the output from the legacy debugfs 
files. This is ok but I find it weird that it claims in the commit message 
that it uses (for everything?) netlink instead of debugfs when things like 
translate_mac(...) and ping/traceroute still have to be ported to netlink.

Kind regards,
	Sven 
--nextPart1943332.NDgg6MdQlS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXIvtfAAoJEF2HCgfBJntGzRcQAJfKtzJc9rHU4QXgyUgJ1p0F
E+0/nMP4SuT9mMPT0vtQw8gT1S1mgMiMlnipPUQ2ZjkS1ez16Y9sO33jS7ykFcM/
hFfPdSHnjCJFJ+Ix8jEsX9vtUoqQd8ZK7p0y+ukbPE4t2EtNar6edmR8Nyq1/9F0
FdHCc6tfON+TTzWjTRVOFvqPMrk6wtV4FK4FlcubKjrkBLcHige8ix77w7x2IURn
HC61hIeod+MxTyFhvGQOFYCbE1pw1xSX+TBYFYVraoTeUkhO2Sab0smkYh3j6QCo
3FQN9J9Jb4izYmha5Zk7eOji2UPqXlWX/Zbb4bmxe1U8/dNEcW3duRRoBPkJaYYq
xC186+7buO90BhLoq1MWo6Spn7yOnpGtza2rA3o9diwp2DbKct1YCAA6g+i9hAb2
7YUaDvnV2Y3her6ypf1wbUADNRiA34jkRvIQr4v7MOEJ1iABRDR9WfsYurNBaDda
Lh+SH6yhpMhjSz4Su0gyvaR3GhAt5qnimuX9SVW6VozVKbQJyTOwBksthtplw5Pj
Ub4H2zhs678gx5Q0mZy/9tPoytZUNw7+HI60JAvK9TyjH3o/cHK6ptnqk1oaYC1h
acc3SBUgQK3xLiji0OkeAXiwYsLob7uqDOflQhP7msuUdMmBYoiC68C3PoOuuVCu
DRsEQy39PXtkRS+dg7Sy
=ileO
-----END PGP SIGNATURE-----

--nextPart1943332.NDgg6MdQlS--

