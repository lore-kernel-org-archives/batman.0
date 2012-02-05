Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 05 Feb 2012 18:41:38 +0100
Message-ID: <1723771.EVlpUnIhZa@sven-laptop.home.narfation.org>
In-Reply-To: <26576244.EFS60i6JSc@g10h4cklab>
References: <26576244.EFS60i6JSc@g10h4cklab>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5462950.d4qVmlxodk";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] batctl set different bw not the one passed as
	paramenter
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart5462950.d4qVmlxodk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 05 February 2012 18:34:39 Gioacchino Mazzurco wrote:
> as in subject
> 
> eigenServer gioacchino # batctl gw server 10MBit/5MBit
> eigenServer gioacchino # batctl gw
> server (announced bw: 8MBit/5MBit)
> 
> why?

Because it works similar to wifi coverage when you use `iw phy phy0 set 
distance 10`. You ask for a bandwidth and this bandwidth is encoded in a 
binary word not large enough to store (10 * 2**20) or (5 * 2**20). So you end 
up with a information that is only similar to the input you gave.

Kind regards,
	Sven
--nextPart5462950.d4qVmlxodk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJPLr9SAAoJEF2HCgfBJntGw1UP/2ubB+LWcztPPgFDN9xSAgQ4
Cygm/vYC2g/YvCPw0EPQ3/W+tEsWAG84sbNepu01xHAZldm277GsbcD1r5OURiF7
RmhaHAp8AxiulBB7X+8UEiIbftL9IoH+JUJfVh5DBF9wTyOqx5kCRd1kypdtecJO
lBNLhlegWYo9Pn5Ok8YIGPaj53jc/rlotNbBL4ZfYEtgNhV4Zu/xSVez3p71Ju0Y
XCUAJFezeoAfEYDwoAePlscyRJvAcSnG2coyibKr+A0LQs2Yf2MSnUDkfAO6rWtr
g0pHoM0k6zUYg6uNn4f5PvxGkEVJT9YfGYAYQOgzXV0xwYbveshsnTbbSmIQ7Kdw
KQ5sIlhBo5zwTJBiehdBlvZIWY3RwwFmw+qvWXsStWMy6aeKrlO0qkLpFCcBTw1H
cU8DhYYLxGKMJzxf8XdYI/lqwxPi9td9hbBdR/HHkqlvGqMoGsAZjZ+kbacyz2Af
ppre+IREOoQ2Bs7bUa/HvZoma+KRWk9xtvY+erkU/co2zEG5pZS/diN2MkMaiISM
gti5q5X7reMkJSAn2XJbc7RpgKNIXZkZzvkmsPTXcCQpzl2d80UIUVUy6yksNpDb
wuAq6o/SFc2FUq1BVNoNYxkld4gmJQKyuBI2IJIPYveZbJYbP/4rSa9c3bFvBJSJ
9jcVfMlLmWrU2zh+xW4N
=cvmj
-----END PGP SIGNATURE-----

--nextPart5462950.d4qVmlxodk--

