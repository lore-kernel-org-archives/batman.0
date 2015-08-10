Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 10 Aug 2015 15:52:21 +0800
Message-ID: <6739194.7XsaoRhMpp@voltaire>
In-Reply-To: <CAKLmikN+_G6R13LiZDXexnPoim7_w+XdnPUq0S3AxcW14saYow@mail.gmail.com>
References: <CAL4ejvQpfAQUUupvDpAx3xek3QggQc_Gi81ucm=EERo+aBwFdQ@mail.gmail.com>
 <CAF0yFe4xwGomt=gud+7YZ4jfd_qSX9U=B7QYUhaBUjeJjh_D5Q@mail.gmail.com>
 <CAKLmikN+_G6R13LiZDXexnPoim7_w+XdnPUq0S3AxcW14saYow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1859112.7qzyzWiuDL";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Fwd: [Babel-users] Fwd: Why we switched to Babel
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
Cc: Jernej Kos <jernej@kos.mx>, Jenny Ryan <tunabananas@gmail.com>, Marc Juul <juul@labitat.dk>


--nextPart1859112.7qzyzWiuDL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, August 08, 2015 23:51:42 Mitar wrote:
> For batman-adv, because it is a layer 2 protocol, we don't have this
> system available. We tried different tactics such as using DHCP to
> tell the clients the MTU they should use, but it turns out that many
> operating systems completely ignore this. We tried something called
> TCP MSS clamping, which is a bit of a dirty hack, but that only works
> for TCP, which is a problem since UDP is widely used for e.g. VOIP,
> video streaming, gaming, torrenting, etc.

What spoke against using the batman-adv layer2 fragmentation:
http://www.open-mesh.org/projects/open-mesh/wiki/2012-09-24-GSoC-2012-Martin-Hundebolls-Final-Report ?


Cheers,
Marek



--nextPart1859112.7qzyzWiuDL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVyFg5AAoJEFNVTo/uthzAdDcH/1mJtCfX+Vw40LqMiPoY5kwN
tlt9lqeatGyWVlDWze5/Sx5+ECZOPixfrr1mVTBKJZDMrKsWigkKblR3n9qyrh89
8zpuLXiHTheroQlEtULjSQHsQrQ2xpaJblz1hMvcgSDegQVIXzZWSDNbRItFfS4a
/BrNSY2TTEm6CLcntmHxAipCR8nOWcHeCDx9BtDGWdeXrWuXPfLusL1rhkmz9c/C
70qmoJ1IY/dba+F3OiqtnAFJbbD1JkCS1jG7NLvyRjKK8i79uFsLRDudAwLqQj+w
p40fE4CW8kJhwd2FmsE7SRPGG8z77egYwHVaNsPsfhWIN6U5iS5YaMrJquIV7EU=
=KNTQ
-----END PGP SIGNATURE-----

--nextPart1859112.7qzyzWiuDL--

