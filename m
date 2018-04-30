Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 30 Apr 2018 16:40:38 +0200
Message-ID: <3863603.68k1flvs5W@bentobox>
In-Reply-To: <a9d2ad6cdccf75502119116f102e678@cweb28.nm.nhnsystem.com>
References: <fcb08b8f86753cc2824011d5cc5349e8@cweb26.nm.nhnsystem.com>
 <a9d2ad6cdccf75502119116f102e678@cweb28.nm.nhnsystem.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3115040.sjGKWolu6m";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] about mesh network with batman-adv
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
Cc: KwangMin Kim <kim25444@naver.com>

--nextPart3115040.sjGKWolu6m
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 30. April 2018 23:18:59 CEST KwangMin Kim wrote:
[...]
> However, I have disabled one of these batman-adv settings and rejoined the wireless mesh network. 
> 
> As a result, only two raspberry pies that have set up batman-adv communicate.
> 
> is this right?

They still communicate in some sense with each other - just not on batman-adv 
and will thus not be able to reach services which run on top of batman-adv 
(for example some IPv4/v6 network).

> If so, how do I configure it so that non-batman-adv nodes and nodes with batman-adv enabled communicate with each other?

https://www.open-mesh.org/projects/batman-adv/wiki/Quick-start-guide#Mixing-non-BATMAN-systems-with-batman-adv


Kind regards,
	Sven
--nextPart3115040.sjGKWolu6m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrnKuYACgkQXYcKB8Em
e0Yl5hAApmT3Po/vnLFiS3RmFmfCHW3M8fQkULTZwR2fLZBmYUV70y2s6ERt0SRB
AlI6/xW4Uc6sRlT5m4dMmvbjEWJuCfBAgPj0d9lpt5WTmOE8roodpYBOo0zZ+3VE
hA8gcTQPRIvNZ+m1oTx3RPTaRx6n6AtlREHodJqAcYi5fNEO0wVi+XB1UGW5vsfy
XAjmF/mDRESQq3PDDCQuWeV46V5YFk2rt/RxsvkcY+eEbsyIlYVIPTxXOgvRQ48q
RNJILG7p5FNDY35wBHAIwuuU+aEmR77Lxz96VgM5JCOv7WdFDPUKkb8790vXA3CS
6FqDbBhQuEoq+Rk5oNxgZLvzBugqW9cUjrxEFVlbLCAd3qJNM6KtwYFKNBQb1aVU
0w8fADwJylyzP6mQwmrqnCTruwUm5rzXFr6ne3Dwn3CIvat3bJLQ68PnJQUBi5B/
Aiw79F5Oealc8oPoja7cg+CDTkhXC+MAQcurIvGipiXj458Y4r+gG8ZZi2A3OEOE
5QW6NFIClFKFosq9qG4WmLJpuB4RKba2hfx6/Md0tC6LSslk1NZf6ZYB7gjGH+zo
OLGEQlYFttEYW+r36oZbNiM7p0nY4tHgEVUUwZPEKILOiMBwge5U4cdHT8cewYBH
Cm7wHqeaHhf0jP8CJWkBSZWnOfUxjXub8i2SCNeIW7Kjm6b1xzw=
=13Vl
-----END PGP SIGNATURE-----

--nextPart3115040.sjGKWolu6m--

