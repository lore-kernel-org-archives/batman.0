Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Feb 2016 19:47:23 +0100
Message-ID: <2782217.C3IPJnY5Ul@sven-edge>
In-Reply-To: <370FBFE49C48C642A1C49A056DBFC0702B70DECEB9@BFHMAIL04.bfh.ch>
References: <370FBFE49C48C642A1C49A056DBFC0702B70DECEB9@BFHMAIL04.bfh.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1962829.Sg9RG0DE9L";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] How is the metric calculated and interpreted?
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
Cc: Sutter Nino <nino.sutter@bfh.ch>

--nextPart1962829.Sg9RG0DE9L
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

> How is the metric (?/255) calculated?

Puh, please read the section 3.1 of "Inter-Flow Network Coding for
Wireless Mesh Networks" to get the basic concept. Details about the
TQ calculations can be found in the source code [2].

> Concerning the output of  "batctl o" below, how can I interpret the following? 
> -What is the meaning when the originator is the same as the next hop (Line 1)?

The best next hop to the originator was detected to be the originator itself.
So this noed doesn't have to transmit packets to this originator via a
different direct neighbor.

> -Is that correct that the originator car 29 will send all packets to car20 directly without a node in-between (Line 2)?
[...]
> car29                     0.864s (175)                        car20 [ wlan0]: car23 ( 0) car36 ( 0) car31 ( 0) car35 ( 0) car21 ( 0) car24 ( 0) car20 (175) car29 ( 0)

No, this node only knows its own view of the network (next hop to
destinations). It knows nearly nothing about what car29 learned about
the network.

But this node knows that the "best way" to reach car29 from his position is to
send packets via its neighbor car20.

> -How can the potential nexthops be interpreted?

These are just ways to reach this originator + the calculated TQ when sending
over this originator/neighbor.


This was a little bit simplified but should give you a starting point.

Kind regarding,
	Sven


[1] https://downloads.open-mesh.org/batman/papers/batman-adv_network_coding.pdf
[2] https://git.open-mesh.org/batman-adv.git/blob/789b846af6a9471982b181687a1cba8dc996b269:/net/batman-adv/bat_iv_ogm.c#l1119

--nextPart1962829.Sg9RG0DE9L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW00C7AAoJEF2HCgfBJntGS9UQANM5BiBS2lUuKAof3bXNxEFi
FvQ9V+aKhNCqxYFy8nFZG7LBtiWizG6gdeW5NiYXeot7WcK7eFzNKofvQNNYL377
+GRaKaHKy6rIu1ZBMd7B4U8QYT3y9bYTNMrIkDuklMqGRFPclX4uQDmRiy1Up52f
W1r3PXowyNFwJznpVBkkc3m24tNf6ZUzB1y4lpdCPCo4cKE1TWgtVEcRGpPPIcF9
dDNCmd9uMgvYAl5pKN5K9G4k8EwNLW2G2xj89ZRCFSjAdwpAI7zeDRzA+czvZbjb
gpL7xY1v73yXrplhYsEbYYb/3bjILcHldkyAOuNv56csXd0fz0F3OdM9QFepFgOo
C9C+P6yccrOHpfbJE+MP4I6jlgZ65zCCDH69eiMIB3iJ5DXR09snYJ4AVlT6aYMQ
b9Gd52PMsouxWG/yn7QULkG+wP1axPBey9T+scjyaa6UDFJ7XbsRtfvkxTnubaT5
Gq8gsC+EhcZCx4qyAog8PIJ93dfD/lS6OZsFeymw3V1H32/1OZcPpXQizCR/Cdzd
80TvSWPdN24/Rfqzii6KQCgCC4qXTiyJ0aF1bbxYgUxsmrIqbqsx9QPtD/XI32Xv
a6ut+TjuGqekO0ggAjVP5u3qgVTsrcT62pu819wefEOSFFn+gJskVIpiXE/mJHjl
rCUT5mn0nVVn6cS3XxFw
=rnyT
-----END PGP SIGNATURE-----

--nextPart1962829.Sg9RG0DE9L--

