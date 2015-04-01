Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 01 Apr 2015 22:02:14 +0200
Message-ID: <1834234.ImvpviMFU3@sven-edge>
In-Reply-To: <20150401193550.GA24391@vostro>
References: <20150401171821.GA21008@vostro> <2646597.jD5Rzrq2qD@sven-desktop>
 <20150401193550.GA24391@vostro>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2043453.Ct3FqAadeU";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] musl build fixes
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
To: Alex Suykov <alex.suykov@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart2043453.Ct3FqAadeU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 01 April 2015 22:35:50 Alex Suykov wrote:
[...]
> It's not that linux headers are not available in musl, they are.
> The problem is that musl provides its own standalone <netinet/if_ether.h>
> instead of including <linux/if_ether.h>, and if both get included at the
> same time, gcc complains about duplicate definitions.
> 
> Can you please take a look at the patch below?
> That is enough to get a musl build, too, and it keeps packet.h intact.
> 
> In glibc and uclibc at least, <netinet/if_ether.h> includes
> <linux/if_ether.h>, so those can be interchanged freely, and batctl already
> depends on netinet/* headers. With musl, that would break bitwise attribute
> of course,
> but only outside of the kernel, and that would be a musl issue anyway.

The linux/if_ether.h -> netinet/if_ether.h seems to be understandable (but 
rather unfortunate). 

I am  not sure why why you include linux/types.h to the different source 
files. Most likely because this include should actually be in packet.h as 
mentioned in
 https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-March/012930.html
 https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-March/012942.html

Kind regards,
	Sven
--nextPart2043453.Ct3FqAadeU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVHE7KAAoJEF2HCgfBJntGMHsP/iY+tP3T3Y1MhwXupzbg6boo
fonn5Qd1jwOvUnOIob1Oju4FY5Ye4WCnv4jz2BYn8y3RhifxRo0V4q5+XIZQMkrw
7w2PK3YTTUg1IHgTvOOPOU5wAlnqH9/76fsRRjWUhNJS+t6GGvglR7e6UmcdYBTy
We0K9d+9JQTUq/KMx2CylhIrBAB0OgSF0uoFTYupk1V05tCJdVnex01MZbgA4Ot3
ISWmKZl/vxMPeTA/dJKlehn2v/7nAbBtpXszv3Uri2o45IyJMCmgp8lEoM9jOWJw
L3QqloGpmG1i2CIx2/J10LCFOaXrFtUYJjvt6xgiMEykQreT+jAF7vXd9YvgB9Cp
PDhmBrZXAI0d0otuVISSHNW62oXJYVM27EbmUYEUeo9DaUCEo/teryb4SRMnVA4y
m3uaZZmXZvI2Aj/xdLldYbXFIBhEdqWUEMil6bstCwSNqxdbWjFvbIuv691FlywL
7/8CBRrqGb1aEm7Io+DQeMbsUNjER9QhYjhpPqmKeBGphO5moj3ylPzNByeUZRWI
3OqR5hDZtfAObCsUL1kP0uH6AS5oik4OX3kMCo6ypWUVG3lCwrEk7R5f8f0sERKe
DGEdZ1Z8lf5F8b7H5U3K+wZrdv617TrlAQAXqytYJ3QG7k7q01U+flNBs8teePtD
7EDDf4tXuA/RlxznnTIr
=AASk
-----END PGP SIGNATURE-----

--nextPart2043453.Ct3FqAadeU--

