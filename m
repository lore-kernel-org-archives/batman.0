Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 05 Jun 2012 22:46:52 +0200
Message-ID: <1773376.eftnT4ifSy@sven-desktop.home.narfation.org>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAPvMiqao58dPrVwIXxeghf4BAAAAAA==@gmail.com>
References: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAPvMiqao58dPrVwIXxeghf4BAAAAAA==@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1977783.3I5T1XZodY";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] bridging problem
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


--nextPart1977783.3I5T1XZodY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 05 June 2012 22:09:51 Walter Robert Ditzler wrote:
> hi batman list,
> 
> i have problem setting up batman-adv "clients". i could need some help
> indeed.

Can you please describe "problems" a little bit more in detail.


> what i want
> **********
> 
> | eth0  bat0(wlan0) | <mesh network> | bat(wlan0) eth0 |  <ethernet>
> 
> (backbone lan)
> 
> | wlan0 (Client)       |

I think this part was destroyed by your mail client.


> my questions:
> ***********
> 1) do i need 2 wifi network cards in the mp box to connect with wireless
> hosts (laptop's)?

No, many drivers can create VAPs (so you can easily have one VAP in master 
mode and one in Adhoc mode)

> 2) if yes, how can i make the bridging to work form connected hosts
> (laptop's) and eth0?

I think this sentence could not be parsed by me. Do you want that mesh unaware 
clients (here called laptopts) can connect through your mesh node's eth0 
interface to the mesh (and beyond)?

The answer to this question is given in the script you showed bellow. You 
should just check that you don't create loops when attaching multiple devices 
to a bridge.

> with what i work
> **************
> 1) alix2 boards
> 2) debian 6.0.5

Just as small info: hostapd on debian 6.0.5 has some problems with multissid 
setups. Could be a problem when you start to experiment with VAPs

> 3) kernel 3.4 486
> 
> what i did
> ********
> #!/bin/bash
> 
> ifconfig eth0 down
> ifconfig wlan0 down
> ifconfig wlan1 down
> 
> iw dev wlan0 del
> iw dev wlan1 del
> 
> iw phy phy0 interface add mesh0 type adhoc
> ifconfig mesh0 mtu 1528
> iwconfig mesh0 mode ad-hoc essid adradix_mesh ap 02:12:34:56:78:9A channel 3
> 
> batctl if add mesh0
> 
> ifconfig mesh0 0.0.0.0 up
> ifconfig bat0 0.0.0.0 up
> ifconfig eth0 0.0.0.0 up
> 
> brctl addbr br0
> brctl addif br0 bat0
> brctl addif br0 eth0
> ifconfig br0 10.10.10.11 netmask 255.255.255.0 up
> 
> route add default gw 10.10.10.1
> 
> exit 0;

I don't understand why you set ip addresses and routes here... but ok, i will 
not stop you doing that.

Kind regards,
	Sven
--nextPart1977783.3I5T1XZodY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJPznA8AAoJEF2HCgfBJntGeAcQAM1LVjVZO3it6IifHW3bUkAE
+wrFq2pD/NxV3VQeuxRb3YvR6Tv5qE6pVTEFNJuKTYgId32ahc5Yc/sa9LRorJIW
Gx4dQILEddmm3H3apNEjx89lHKM5iuiZe3TUja6ClbobodfY/vkT3JpEYyhMVIA9
qFL565y5CyN4tonFxwb68Ahssy/aapwFJ2fhdAiAILtcdH8eCK5ymR49JJpkbpPH
qJFSyHDBGc30WCZgsOKCMTYPmlgIBSQF33eJL8zv9NFVGrmnMiikZw4VV45s8Wu1
xxapapYZzre1fJMhthgy9U3p22AYJOwHb9KK4gMeC2c3xBnIq4H8pxG4PnAg6iUE
fpilLVH5MLFQ3p4WrHpV1gczHzgFdLLplNAi3gL2+dAU+Vmz4HE0LdPr/qbk/gq5
VV4byJFlChqHIC3Ba7KmNqJKxNAWB458WXk8VhVGaaYj2Q+enBZByZ0dr90any5b
/NpZPfNEWHOx4VYa7fkrXD3yify9AE+8HE2wszB23rpp/YZamiFeXR7nz0T09HIR
oAg61WMSrX2r0VEhmV/RBf3iGzcus7Xq188hqe5dSCzJG+1CfQU+p/77o2KuyrI/
Qu3iiC1QIFur5kAfnrXSS3GdKz36+Id5VSAbQWz1pqF0y8mZZ1hCDk6WVKR2Jpwu
O1KuJiMnbkXZLqgx1fCw
=3pX2
-----END PGP SIGNATURE-----

--nextPart1977783.3I5T1XZodY--

