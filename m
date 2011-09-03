Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 03 Sep 2011 11:33:18 +0200
Message-ID: <1708693.BHy3oZg7c1@sven-desktop.home.narfation.org>
In-Reply-To: <CAFevQmPHjkJqXSrFS5PHbOU3wmCMm5OLLDpyrBF_tvRLz+5r1g@mail.gmail.com>
References: <CAFevQmNDWyoA2PnhkRUDXV44r-LreLbjgCj=dqEggvyUbaKE1g@mail.gmail.com>
	<CAFevQmPHjkJqXSrFS5PHbOU3wmCMm5OLLDpyrBF_tvRLz+5r1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1430256.CrGUeXDinB";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] batman-adv and coovachilli
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
Cc: chilli@coova.org


--nextPart1430256.CrGUeXDinB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Friday 02 September 2011 13:09:44 Filippo Sallemi wrote:
> Hi all,
> I've a little problem and i need a confirm from you.
> 
> I have 2 mesh node (gateway) with this configuration:
> lan is a bridge with bat0 and wlan0 with node1 ip 10.0.1.1 netmask
> 255.0.0.0 and node2 ip 10.0.2.1 netmask 255.0.0.0
> wan : eth0
> msh : wlan1
> 
> and 3 mesh gatway (client) whit this configuration
> lan is a bridge with eth0 bat0 and wlan1 with dhcp
> msh is wlan1
> 
> on each gateway nodes run an istance of coovachilli that create new
> interface tun0 ahead br-lan and when coovachilli start deconfig br-lan
> and assign the ip of br-lan to tun0.
> all other node are simple client.
> 
> Now the problem is that when coovachilli is not running i'm able to
> ping node1 from node2 and viceversa but when coovachilli is running
> i'm unable to comunicate with other node with ip addres not in the
> same subnet.
> I think that the problem is tun0 interface that block all traffic o
> something. I have tried to use tap device but the problem is not
> resolved.
> 
> Suggest?

coovachilli works a layer above batman-adv (we personally don't care about ip 
addresses that much). So it sounds like a coovachilli "problem" and you should 
ask the coovachilli support.

Kind regards,
	Sven
--nextPart1430256.CrGUeXDinB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOYfReAAoJEF2HCgfBJntGzSkP/1cjGrgPdZZCOxbiFLTe2vsG
3cvOeJQDkYFkK4hfMGoqNs77xA3Bj9K1V+dLzKcfjf5KJPfWor5UYCXHVM3ZD05G
gR0KGVLVLs9HoqjsNwrgOvXbzvV3sfSnAShXiWMiCwt9qXBBw7ZTqgsc+IY7GV5I
36kV21ccqVUguDR/+xavQFUCjicosve901aymd253j+lTvMM64nxRF5qsKQ20sEP
UawItNYJo9aOcq/R/BwH8H3/5HpM6aZAMcj1xBja92i+f+sNpg8RSwi1nbgLpapC
UhHIgdJf3qA967ZCC2P7cIgL4W2iAJvyo2HI6rCZzlTMOXY6b+w9wHXs1nG2rjD5
X3p9gRFLykTQMmBEkJvNqvE9r0AHi/5+qyLLCj+KORSeOE4PqY4VW/6oPci+0B/b
PtpNO27x0u82bAa6d3JPBWASsMfHaVA8rqXgqKBrANQZqNUrECJGn+EvD/euY2dy
HchXcUjLjykBV537H9/+IgCmHJrPtlHz6KAxpy95s9ce13/im52ml5qxy/sowO3k
Yi5233Iz1WI7FP8z0SGndYf0XR3mHMeJ6TFlkQJogz1Xn4QvQWPYK6eU4Fari1Bv
GpQApvBD4hGSgAwJlATW78iOlECBDsaorsb1AqvOdBt6gf6xLhxxbADnnMC8MfC/
tn5d7PEcqiqo78oAMVuK
=4+lw
-----END PGP SIGNATURE-----

--nextPart1430256.CrGUeXDinB--

