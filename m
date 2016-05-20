Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 20 May 2016 09:23:24 +0200
Message-ID: <26642956.zsKuDycQ3V@bentobox>
In-Reply-To: <a1c140db68d543d482a22adfbac42670@BLUPR97MB0100.062d.mgd.msft.net>
References: <1462190269.1971.52.camel@biplane.com.au>
 <2079546.oo0Mk8DjMd@bentobox>
 <a1c140db68d543d482a22adfbac42670@BLUPR97MB0100.062d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11833968.2cDmua9i8u";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] mesh losing internal Ilayer3 connectivity
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

--nextPart11833968.2cDmua9i8u
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 19 May 2016 14:22:58 Nick Schaf wrote:
> I've run into what sounds like a similar problem, but dove in and found more
> details.  Here's the setup:
> 
> -19 nodes running BATMAN-adv 2014.14.0 on OpenWrt Chaos Calmer; various
> hardware (D-Link, BBB, Open-Mesh, WRTnode, TP-Link).

Only scrolled through your mail. But there are two things which I find odd.
First you use a really old (actually not existing) version of batman-adv.

Then you have some TT problems. I think we had many fixes since then which may
be related to your problem. But going through 2 years of fixes might be a 
quite hard (at very cumbersome) journey. 

Maybe it is really a good idea to try to upgrade to the recent version 
(2016.1+fixes) from the Chaos Calmers openwrt-routing feed on all your nodes. 
Maybe Antonio remembers one special TT/roaming bug and can recommend one to 
test. But most likely testing the current version is easier.

But thanks for gathering all the info

Kind regards,
	Sven
--nextPart11833968.2cDmua9i8u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXPrtsAAoJEF2HCgfBJntGG28P/1+PiFe3CyblQtLRHRBMxzQI
RhJEtV6DsLK+tTkzAOY9ISt05ky98zYa6f0KD93DCYyXhdh12cTG3SZoYelwaPrY
N/vnfyqDLX+iSyu/yMMbAQ2Od7XjHRygJtepEklIlq7vBL6925TFffNzspgs74K3
ThHtIqrAQl4ulTRFXNjBm0qtiKV52YReUntJiIcQ7yHaN8zmZh6gZsZVBj7O5Rp6
rbKDII8QGZMt0+JiK7sSxGM8vx15JN3BJqz7r5BSUaB7w/nRdfckYA2/UNm1OrVa
CpuIoh3DgwTqyUVi99beRkLDoq0NJKu/SFX+GNmC3T8rfhKdCoiwvZAsRuld8WQf
HCKt9o6n2vL9kvnTG8eLqdAS0mQRKjlNBMnd9m77lSbm/7VZnWPygGUzcCZy4ONn
YDi4HFO3RbYDYJoxQLwCzWUKAzA3kfdc6qX4sijj5F/UkamBCRk5txmyucd0Pyuy
a/d0m643PKW3Zzg7dZwoHqDau75IrAboY2P933/MnVXL/RJ9MYjEbnG27Wn20sDo
rnxqYkug0EU1QCbffyiyGUgWJ6Vk6JpZBKXQDDDllXjpM1vZn25s3lEmmUqhczdp
s9CijH6IdkxtjqY9EQ0qhBYtI1EO78qrHs5uHm/Df5tY8zI0nvm2IL18wZMQTbYy
YLOXuf9K3gWVwodBtSbE
=iG4O
-----END PGP SIGNATURE-----

--nextPart11833968.2cDmua9i8u--

