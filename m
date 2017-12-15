Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 15 Dec 2017 08:05:13 +0100
Message-ID: <1866122.Qj5mpMoAt8@bentobox>
In-Reply-To: <CAEUausrvG17xyN6EfAvw2PgUXz3+QPmzVTCt--eM3yi-zbvPoA@mail.gmail.com>
References: <CAEUausrvG17xyN6EfAvw2PgUXz3+QPmzVTCt--eM3yi-zbvPoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1991021.YoEINu7Poi";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Switch backhaul based on connection
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

--nextPart1991021.YoEINu7Poi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 14. Dezember 2017 12:20:48 CET Carlito Nueno wrote:
> Hi all,
> 
> I have nodes A, B, C.
> On all nodes, wifi and lan are bridged. Also, they are all connected via mesh.
> 
>                                         |---> node B
> ethernet <--> Node A <-- |
>                                         | ---> node C
> 
> Node A is the exit node - connected via ethernet cable and node B and
> node C are connected to A via mesh.
>
> So, when I connect node C via ethernet, does it start using ethernet
> as backhaul or still keeping mesh.
[...]

Sorry, this is not a batman-adv question. And it highly depends on your 
configuration. For example, the bat0 interface doesnt seem to be in the 
bridge. So I have to assume that you use routing - and thus you have to check 
your metric settings for each IP(v6) route.

And if everything is in a bridge then you have to check your bridge cost
(and STP, ...) configurations.

Kind regards,
	Sven
--nextPart1991021.YoEINu7Poi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlozdCkACgkQXYcKB8Em
e0bHEQ//YeUsiaHyUGuGCS27liwm1qo6qvuBDIvIbMowK/UwuMt7BLqpAM42kvPr
0pYT7Gv/kMIPbjuC7dhKvqYvL0mEVMuU+T0UgEZV32lnquOkI11z5EjKLFXGqLj5
KhORtK+OCsTVFABEVd+vnNRbYww6HI6AIZ0sd5oDgZ/MW3NjJVtOx7YMtL+OAbMP
7lwLq8JX3eyNdyrbSrC7BsnAOwMLOALaYPYq1b0gF89JnrTAmlmqGg/AgDCH1LYc
xKPq5JmN0v6JzsW6YZqsKcAgxdg1hgRbzU7BNi4W2TLUXwk7Q7B3riRnCj857ac4
L1gEdS1fQGc0VjE+51qvF+5JevcqVjIjLI8f4iSyXYBWeDUkvtrdEX3XTIIDw0xB
BAJjylMV5kIAkjtzGWKaVV9hp1hQehuf/WWkYxY94voYjZJIfFkomGebv2RsFWyp
jveCV9bMZmkR/Ghz8LluSl4bFKDvtQ9TMgNrnmNzKQfM3h5r5btTj/yYg9HcubMe
88AHbo4/shED4u7e/cEj6Ma6h+HoC8/4cBcmNVM9bnYv5+kaYdLR0uaa5Z0b6jQa
GskW35hC7asjq3cdYLHLOiFrqaXvLh7fgcvDgN7AyChM0pNnUwSdJDdGAzyu5WkV
sbcoP0nGkODRchybPl+2u91/gDwNTwtadbcOmvgOxVUEzgjUlH8=
=KFBi
-----END PGP SIGNATURE-----

--nextPart1991021.YoEINu7Poi--

