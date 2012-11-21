Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 21 Nov 2012 20:55:39 +0100
Message-ID: <1920966.iU3YQxcXDK@sven-laptop.home.narfation.org>
In-Reply-To: <CALDpWg4kZSisvbA4DFdZSDgt0OzYgH8-dNDJE3HUm8xxeCPMeg@mail.gmail.com>
References: <CALDpWg4kZSisvbA4DFdZSDgt0OzYgH8-dNDJE3HUm8xxeCPMeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1373755.itugNe63Fi";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] batman-adv: node socket communication
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: liu muye <lmy19901031@gmail.com>


--nextPart1373755.itugNe63Fi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Wednesday 21 November 2012 14:43:33 liu muye wrote:
> This is Muye, I am a university student. Currently, we have a mesh
> network project using B.A.T.M.A.N.

batmand or batman-adv? I will assume batman-adv in my answer because you 
mention batctl later.

> We are trying to establish wireless communication between each
> B.A.T.M.A.N client so that they can share information through the mesh
> network.
> Specifically, we want to write an application on top of the
> B.A.T.M.A.N using socket in order to transmit the data packet from one
> B.A.T.M.A.N client to other B.A.T.M.A.N client. For example, unicast
> or multicast.
> 
> Would you please give us some advices on how to write such
> application. I have looked at the batctl ping and tcpdump source code,
> but I was not able to send data packet using the similar mechanism.

batctl ping uses a special trick to inject icmp-like packets. It is nothing 
which you should do when you want to sent data over batman-adv because it is a 
debugging thing. batctl tcpdump is just a lightweight tcpdump with some 
batman-adv specific extras and has nothing to do with the normal data 
exchange.

> We greatly appreciate any of your suggestions.

Just write your application as you would do it normally. batman-adv works 
transparently for you (when you configured bat0 correctly of course). 
Therefore: add interfaces to bat0, configure your IPv4/v6 on top of your bat0 
device and write your applications using normal sockets for AF_INET or 
AF_INET6. Of course you can also use raw sockets or any other protocol which 
runs on top of ethernet.

Kind regards,
	Sven
--nextPart1373755.itugNe63Fi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQrTG7AAoJEF2HCgfBJntG5t8P/0/G1kI8HJmzrAKmCPKVpXiB
7eE4rmnBpoFrRt8D57jobZLT54duIlFUCjQ+PFB6VbyKKtEWt/Eq0wg3B90i0eIN
4S/bpLfa/Eq7RAPNYQi3pEqhHfVbeuej0bVJ7TuC8Mhc9rA/osiBTnD2IM1/iWS2
y836TDPiFmljQoUWKL2U6PGaaM1wqHrrvRUa2ZGuNGmaVsfJmHQ+wBXGe6PzKy0V
5CXMY2OIQ+DCFSapz809y2SLjP0PYZxmQF/k293zbpMiSSScOrGgcwqExo/PaE4Z
s7w3O1W+siHwpPNRZA3ek2ACXQ2zv26y6MZe0CI1sjWAyJAvAcj0F3/8xCqw9G0l
xbf++vD08I2oX5tUY3COq0cik4p5G6yREVvLJvy+c3lBwYyqmrkdw/vQSfafRlNZ
h+0aCxjGE4F242KLyEBDhEdhKrMexYJbhqV+LYVSlkQ3rjql8Sj7h1Aifp9npAyP
ajJ012UKRos6z8jtVqvTWBg3JJBg562DpsdHFSCfW6zzymXmT/ZDjhCjxiW1Byxq
xkdP/Wbjb387x94CH520icWpoIBFowZ3ENTOSoqDT8XnBRFSzA2frEbDmmBiHcMm
HAy8n2yY8Hn9j/0oSIs7GBpTNX7IW5qC1BbG/cERFGoIwamrl/DKFhA2fHYuzU9S
oDzy+nqtKQxCxW6u/8F6
=53nq
-----END PGP SIGNATURE-----

--nextPart1373755.itugNe63Fi--

