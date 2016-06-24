Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 24 Jun 2016 21:57:50 +0200
Message-ID: <24448293.C3avDh6gQR@sven-edge>
In-Reply-To: <9404219.qzAPb65udo@bentobox>
References: <CAM3k=84krmoLaW2X59VujDb_ZxuMJW-6pwGDhDLx=0-HHG6O=Q@mail.gmail.com>
 <CAM3k=84yf5iiZqYrzTK2cSwJGM8cmRH4Vf9cJxthz4Lp3dowCg@mail.gmail.com>
 <9404219.qzAPb65udo@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2654094.g8pWa7J0ZN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Adhoc0 Interface not showing up
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
Cc: Sailash Moirangthem <sailashm@gmail.com>

--nextPart2654094.g8pWa7J0ZN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 23 June 2016 12:53:35 Sven Eckelmann wrote:
[...]
> "ip link" shows that the adhoc0 interface is down. Please make
> sure that the interface goes up. This is now definitely an
> OpenWrt+wifi driver question and not related to batman-adv.
> 
> The interface combination [1] is showing only
> "#{ managed, AP, mesh point } <= 8,". So you can try to
> deactivate your AP interface in /etc/config/wireless. Make
> sure that you only see the adhoc0 interface in `iw dev`
> after you've restarted the wifi.

Any success when only using adhoc0 without the extra AP interface? 

Kind regards,
	Sven
--nextPart2654094.g8pWa7J0ZN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXbZC+AAoJEF2HCgfBJntG47sP/1BjRjq8Irm2vRDPWLqc9Il/
AiXzjt47AboKbD6nIIZWpoqWSQC0I27Onq4klRiOWlpfc9T2eOXy3mrGtMNVWYbA
/+U3gBk/+UM3qY8SraqKgIYb1yO1iZ3ykJmW/KpLgwT3dn6ifBz0YyVcYzKtpn6p
MZccexJKpa+y4yx1moDQW/NMIUPqibexlv72SkZZQZfSfbxsgWaIROuheJyU0Qm9
7ktIbEF3D/ogTiwjCdJ4ADzjcNgDsNs5irZbRmxA8U3KzNjHcIXb6bFvQZ77kU1K
jLw+PzW1VzimqZ/V/Har2p5BJHm0pKvjCnOGwhhKs2gYScLYJ0jaYEx+7/Ae1xb1
n7SZKNNZqlfOdjAPBcUYyGikFRHAKdf66NU2oQEG+IvTostBYrEb28iS8nyJhxBf
axqBDre4kMtcwipgtUoWvkgL/Uqz7baZd23chf629TySHdmd5vavBF9KyOIXyXPp
A5uutuhAsAfG/xDdffcgRgUWKE506i3RT9to/bHKuQ8rj+gwUy4MkQgELCqvH7Y0
i1JBh+N7jrjv8a4/WQafC6II9AXOZ71kdGtSHutD/Gn5CGxQO8E34CzeFielbOz2
uEhtMkEP9tgoK47nL22eZKcTtIhxHMldPnfDC2kD+//9ktwVDpz0KueLvXsv55r9
DdwDykb1XlLg2n+/AWeY
=TL1m
-----END PGP SIGNATURE-----

--nextPart2654094.g8pWa7J0ZN--

