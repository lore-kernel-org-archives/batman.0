Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: QoS over batman-adv
Date: Mon, 11 May 2020 08:38:32 +0200
Message-ID: <2200656.2eICcKID6T@bentobox>
In-Reply-To: <CAG5qQ7j1FzdwTqcAPcG=tBp5YTFm4UiOgVdSuk0qL5-pT6KB+A@mail.gmail.com>
References: <CAG5qQ7j1FzdwTqcAPcG=tBp5YTFm4UiOgVdSuk0qL5-pT6KB+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6114849.T8T7SrjxRy"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Xuebing Wang <xbing6@gmail.com>, Simon Wunderlich <sw@simonwunderlich.de>

 
--nextPart6114849.T8T7SrjxRy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 11 May 2020 05:33:39 CEST Xuebing Wang wrote:
> Hi Simon and community,
> 
> We have been using batman-adv on OpenWRT 15.05
[...]
> We are exploring the idea of QoS over batman-adv to transmit small
> quantity of high priority data. Any suggestions? Thanks.

First step: Update OpenWrt to something which is not EOL since many years. 
This will also update the batman-adv version to a version which is actually 
supported in openwrt-routing.

And then you will get the dsfield or 802.1Q values propagated to the mac80211 
layer (as part of the priority field of the skbuff).

If you want to have QoS on a higher layer (before it enters batman-adv) then 
just use the normal queuing disciplines of the Linux kernel.

Kind regards,
	Sven
--nextPart6114849.T8T7SrjxRy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl648ugACgkQXYcKB8Em
e0btYw//TGQq6LsdW35YXpkA/xeeOrAKoGr/+s/29LU8xu3m7HkiSmettAAjeifM
gmI91z0x1Cf4JHmAaGqF3plhSgFWl3N+Kepe9oYeZSobh94tngxC7yjN7MmfQ7rt
U+KLz/aywdc+SRfxdeNc2z4L3BdosuB7MclkVxod/wIwuZ9ttJJP8uklNgx1F/OZ
GGO2N6K0AI9sdY/vDOZ8x1CSW6Z3uP7jpSuPFhfvOqPqWCEtB3tSTikcQ776UUgd
NX+Iep4mUXFCqZoKWHMb2YnXNN3SDuFFufiKttGMA/uY+00eUGvI/HloAlSTaOlm
Hc0ojS0ylgF12FkawwP5arb0J64FP4OHPL6Xtiz8DkrBkl4lknZnDZaFuM8VM8Qt
YQuujx5frKW/GIbj4+XkOF9jMIbUeKwIRBRiAFqLX2jfAsFHQKxUt47+385EPJb4
A0UfIjZSOpJzcQj0wlHIHE5JLSZ4GsYvAYmDAlNgtz59x/Jwi7+NwTVCc3UeJldj
Md/S0vr7GCtFIkn+4z91olRVJviGnALtnCRPZB6gebAvctCYFfKQv5L4arUu6LSG
4luuRQ7HcbY4xL5wqy4LYRD4mCqZAqwIMoKxbG91kGQZkLs6nSXZfIURQnWxiNJf
yQ8alx0s+0HmR3DklIX8DOkGtKDxNK+TUjbkWHkdUguWBfu7qbM=
=KnUS
-----END PGP SIGNATURE-----

--nextPart6114849.T8T7SrjxRy--


