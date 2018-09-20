Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 20 Sep 2018 10:09:26 +0200
Message-ID: <2282923.cjxhcyjvHZ@prime>
In-Reply-To: <20180919.203434.1784595444537176012.davem@davemloft.net>
References: <20180919122213.23108-1-sw@simonwunderlich.de>
 <20180919.203434.1784595444537176012.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3058391.ecf3UUKo0T";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 00/11] pull request for net: batman-adv
 2018-09-19
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

--nextPart3058391.ecf3UUKo0T
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, September 19, 2018 8:34:34 PM CEST David Miller wrote:
> From: Simon Wunderlich <sw@simonwunderlich.de>
> Date: Wed, 19 Sep 2018 14:22:02 +0200
> 
> > here are some bugfixes which we would like to see integrated into net.
> > 
> > We forgot to bump the version number in the last round for net-next, so
> > the belated patch to do that is included - we hope you can adopt it.
> > This will most likely create a merge conflict later when merging into
> > net-next with this rounds net-next patchset, but net-next should keep
> > the 2018.4 version[1].
> > 
> > Please pull or let me know of any problem!
> 
> Pulled, thanks Simon.

Great, thanks!

> 
> In the future, you can put that merge resolution guidance into the
> merge commit message.
> 
> When people give annotations like this, I refer to them when I do
> merges and it helps me a lot.  If it's in the actual GIT history,
> that is tons easier than if it just appeared in your pull request
> email.
> 
> I manually included it in the merge commit message this time.
> 
> Thanks!

OK, thanks for the hint! We will do this.

Cheers,
     Simon
--nextPart3058391.ecf3UUKo0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlujVbYACgkQoSvjmEKS
nqHtNw/+OA3aGtNYu33bG1rewbMCj78pEbfChw6NwgVmPYVJlOt4pck7DKAi3Y9p
M4trxMtOA8KKlxgZDA66lZ0j7Nc2Rw74Sw17CiNDbt36yJlr85Q0bvbL253it9LE
dRpbD7XnHbfYcgOzHmwqXEajVDk/N1wn1ajmAM/EyL2R/pJBePBeBs9mnsqtOz/l
nMpKt8tWt5qNzrMBRLjCCS6qp5YZZDZl6/b5Fs7rCzvKamkxZBzSwjcwx2BxxPCN
dPlOk/AWiMdfr2xopo0wpn5IvmTDCPdw4dHfZL7hY2PQClFypjlj7JI6R4L+3dsn
NS8gXqhppj/W6upF54n0AuXAxyLelxX1atE8AMWIEqvPVbc1OhMWZM+j7EdYO0Q5
n129bjhuRGWH26FyX6g4+xFOvkYApXo/lk75L0Bw5YrhjdYnbYcULUwvl/KsFq6O
N1aO4xWyqCKS3or+LvCDgJdflov+1wWQTIMYPbLsSJ9mpS/z3USRe6ZU6DJyr8cj
PeK/UaOJUVX508pnbOv91XAegdXG9JnSDBD/jU0IDCBHmh4S4V3Jit0y8yeYD0Wh
c+4E1dxSGbHxOetl0/S5LVvbSlrdZiyB54DhRfXpa5ZUe5Ed+WkHCCEwk5fvbg+8
c3R4wUYMV00LAdww4pMI7E5wCusOKEXeUKxY/obUYDJGw8Y5ESU=
=KB8m
-----END PGP SIGNATURE-----

--nextPart3058391.ecf3UUKo0T--

