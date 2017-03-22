Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 22 Mar 2017 10:26:06 +0100
Message-ID: <1643382.tEoIBi2FKQ@prime>
In-Reply-To: <20170316133429.3923-1-sw@simonwunderlich.de>
References: <20170316133429.3923-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1525917.lcbnaoi1NH";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv8 0/5] Optimizations for setups running
	dat and bla
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
Cc: a@unstable.cc

--nextPart1525917.lcbnaoi1NH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, March 16, 2017 2:34:24 PM CET Simon Wunderlich wrote:
> This is yet another rebased version of Andreas' patchset. I've used
> Antonios branch, but reverted his changes to the first patch, since
> there were unexplained semantic changes (e.g. when no gateway is
> claiming the client) which I don't think are correct.
> 
> Antonio, if you want, please explain your changes or let us discuss.
> 
> Otherwise, I'd suggest to keep this patchset around for a few days (!)
> for a final review, and then merge it.

Just applied this series into 0c794961..cbb2ccc1

I've fixed the 3rd patch on the way according to Svens comment.

Thanks again for the contribution!
      Simon
--nextPart1525917.lcbnaoi1NH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAljSQy4ACgkQoSvjmEKS
nqHCXQ//VUGz0OQpHsqFIbV9oj2w4pYavHqUp/03kfWdHNIj21J8zvD7UDASI5qT
6/R2l6eEDkX2Z7Lrn+ikPIq3Kt+ud1Glj6XQO0OaqRbgU6DppHKYt+o9Yp+Z7rwH
2mGq2QkpyUPpxliKk7l1yfLbfaTbcZBekaq6JhPDO7ApMfpC2SEegkLf7lGosPLa
LuGyvrbt2AJsh2BuD1HXse80fhZYtN31/6NdXuSi6fvryXnqeiFKOQw6CEXUsvYH
mFvv/A7uYgDcMkdDP7gWN4fYhkvJF6GoMoMb6TaS6vLXpLF1bqbz4zyf9ncQxnax
WTu3nSIjXRYK+FcVLPDMQpSe84XxWiIMQNzSc7GyDHuNCyhBVs/yqKX7MOQP4rLZ
EkFk5UPRo/GZJWTn9zamDoXWqMLPcmSPAs1DD6e9D5h8Ds4RFAOXC233WDva5WCk
vgTXeeTACLpGOfgSz+lhk8adEqy3uu4eAEB3PTiBW3MzmyeHv0AhhFeg/cRq3tU/
yc/8K4f8dZLPCbu1LWZ28eDXZfMKz61+DAV9DMwKEV9GttYPvwwNP38PeaRjPdAU
6qLQtMT6n0Ji0qUukk2E+9tM01m8O94V7GfLiIhx0VxgyN/60I+JzmoJgZb3QWuf
AC0lOiFRgjKQiOjLf5gj3tbBKisoJY2fInYTDDcQPv4Hhn881TE=
=LS+Q
-----END PGP SIGNATURE-----

--nextPart1525917.lcbnaoi1NH--

