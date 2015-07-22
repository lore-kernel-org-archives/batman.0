Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 22 Jul 2015 20:01:51 +0200
Message-ID: <5967184.Q5nWeNzPJU@sven-edge>
In-Reply-To: <CALaFpeWSYsMCVFf5mSCnVyOZJRpRzFahSRD5ndVg8rUc9jHpYA@mail.gmail.com>
References: <CALaFpeUvicwHWQag0Upv5UNQ935TYY-RJuXVUtpT7gfORWZm7A@mail.gmail.com>
 <15974886.03QyElGMEP@bentobox>
 <CALaFpeWSYsMCVFf5mSCnVyOZJRpRzFahSRD5ndVg8rUc9jHpYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2480689.M6jXH5z08g";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Recover in case of node fail
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
To: Carlos Meralto <carlosmeralto@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart2480689.M6jXH5z08g
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Don't contact me directly about batman-adv. At least Cc 
b.a.t.m.a.n@lists.open-mesh.org

On Wednesday 22 July 2015 18:56:41 Carlos Meralto wrote:
[...]
> And with this command i can ping at layer 3. It is not possible in
> batman-adv? I want to measure the recovery time and so I'm doing a
> continuous
> ping. With batctl -p it is possible?

This was not what I said. ICMP ping should work perfectly fine. I just 
suggested that you try `batctl -R` for debugging so you can see the hops
batman-adv uses during a batman-adv native ping.

Kind regards,
	Sven
--nextPart2480689.M6jXH5z08g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVr9qSAAoJEF2HCgfBJntGyDQP/iSzHA9Z7nLWElagKruM7HGZ
pntok4+aelZZc2DK3SFSZP2x2Uc6R1Ask0z7h6pHqA+ddo1XocI6YB3+ijIheS7E
g9Zm4vjJaW6OiN+V/F60/pVxq9OjzDpZyShqMAgpnm/mBMf0jFmV6ZEAHDz8IqHw
pK76O9aE0Hk+8C/d86Cg52KO7h8+zN7rgg5954vzGB2bI799HBFvVOwAPYruNQs5
HdykSiwJ9eTkzpL2h1rT1S8fJhjYOIUKhEWemPZBmDlvlSmJI/7v2apm3sX9GVLB
4t75jxsRdGUrcWjtarrHSOkL2i15sT5xfJ8MVgMl+8hUCGnY8/p5W73eBPyBN+Bq
vFKPtYDCOF6yLR3iLCuqHE+25j1Yw7UksTpM9IdQcimZclHGXCMxvE+GLnJma9fq
f8N7HSeOt38m3own6wsrbLDye9a2OB11RpQYlH1Pr3naz3AUOZMj7AGVp7ZNIPwd
lhTZ6ajm0a/79NrNs07QMvIWIptGp6FNbIJUMaOaiYmB2PZa9NWTB2CmOZMHevUR
7mLab+6iqILSdLT9wVhIDBHJdd1PBcz4bQCe3ULxGHhETS+zLu/hvYoL+689fx2+
/ZU030hBUjHEhnugrEvaL+X8Quk+tV3sokmVjbk8Ui0WtUF/VwVKFIwVQzDhRRiu
V1HrYYK08zZbg3tBMC6U
=VHgh
-----END PGP SIGNATURE-----

--nextPart2480689.M6jXH5z08g--

