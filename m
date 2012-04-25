Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 25 Apr 2012 22:51:42 +0200
Message-ID: <27822870.WoBxtuRSLo@sven-laptop.home.narfation.org>
In-Reply-To: <4F985E17.8030309@inti.gob.ar>
References: <AE90C24D6B3A694183C094C60CF0A2F6026B6EF3@saturn3.aculab.com>
	<20120425.140904.935584797119761625.davem@davemloft.net>
	<4F985E17.8030309@inti.gob.ar>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6850444.Tzkj7E4NRH";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Traffic Control in batman-adv
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


--nextPart6850444.Tzkj7E4NRH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Wednesday 25 April 2012 17:27:03 gtolon@inti.gob.ar wrote:
> Hi,

First thing: Don't reply to random messages when you actually want to start a 
new topic.

> We are doing some tests with Traffic Control (tc) in routers with
> Openwrt running batman-adv, want to be able to share the bandwidth with
> some degree of fairness between users, so we think that SFQ could help,
> differentiating the flows depending on ip addresses and ports.
> 
> The problem is that when adding the SFQ qdisc to the wireless interface
> managed by batman it doesn't work as expected. We tested the SFQ in
> other configurations and it worked fine, in full queues, the dropped
> packets affected the big flows, allowing the others to pass, but in the
> interface managed by batman-adv when packets are dropped, the result
> affects all flows almost equally. We thought this could be related with
> the bridge we use to connect the batman with the non-batman interfaces,
> but in a wireless Acces Point bridged to bat0 it also worked fine. Maybe
> it's related with the way bat0 works with it's managed interface? We'd
> appreciate any advices. Thanks in advance!

Why do you add the sfq qdisc to the wireless device instead to the bat0 
device? It doesn't really makes sense to me.

Also your statement about "batman-adv bridged with non-batman-adv" doesn't 
work, but "batman-adv bridged with non-batman-adv interface" works statement 
is slightly irritating. Please explain it a little bit more verbose to help us 
understand what is the difference.

Kind regards,
	Sven
--nextPart6850444.Tzkj7E4NRH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJPmGPeAAoJEF2HCgfBJntGt5cQAKz0E73p+mlgDqwA82fDWAHc
sDLX6YDaEABI0bZpNWqogq5PMdTm71ePy8xySLiRtYcrMdqnSloXODz7/6fLxLdz
LW/dMuVIMtEBVKNjqt65K0XX1GZ4oCzz9+8g2dkK14b9ooJrBtm1NTxVkBbJigBO
UFDNfoorsJ7GTJfSKHZ5DveTvAFDWsGIPOktRpHZLm7UIR7E9rxldvWCwUDo/6GM
Vh0fvQC/BpOKR6+4+Q/rs0oem2F+srmpe+UB8V0V3vVe1hogW/tFAjG9cpKFxKzt
ITnsip7EzkUTT6OhKn3ftzwhXe8ilHQbBVPajW4DbI7JcVZhhpbMvZyALrvjhDMQ
H86k+KG115GAVSalJBQUbLWMqJO0IhMfwQKxvYpX4Re/GTAmZLEnHjafFYXXGU1E
Q6aGnFytQolxWBkGjI88j6a5uDd00DuOiKF4J1rNu2gWaTUpdXCubUIfzaQCAL8v
q9FjDFK0qk0HO87JC465FoKyqwEWrX2hH0lxWebNu2JwQdYuhsVXoNi/QkIT+TFT
6OqNh/PksdNsgwvF+fQhm3Y6bvI+iJXI1O2Fo1A4lK2HNr+QFPCw1mzsRlBnWNRC
VEPgeD1WQQdg1Dj7LhUsAJAmo7XrJXb/SgPbGIAn6Dcm0YmdjhufhK7x29KZJ6DK
UJZYkfIRVN3IskGwjRa4
=V7cb
-----END PGP SIGNATURE-----

--nextPart6850444.Tzkj7E4NRH--

