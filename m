Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Aug 2018 11:06:30 +0200
Message-ID: <2950360.XQPVAlnd6X@bentobox>
In-Reply-To: <1e3a0849.c275.1658a0b9176.Coremail.heishuihe2008@163.com>
References: <2791173.mX5NbDZpiX@sven-edge> <3703195.ExmNLY8AJ8@bentobox>
 <1e3a0849.c275.1658a0b9176.Coremail.heishuihe2008@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1638291.E8EZIUobyM";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Recent test result. Re:Re: Paper "Performance
 Evaluation of BATMAN-adv Wireless Mesh Network Routing Algorithms "
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Ligang LIU <heishuihe2008@163.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart1638291.E8EZIUobyM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 30. August 2018 16:55:38 CEST Ligang LIU wrote:
> >[...]
> >> One strange thing. Can I ignore this waring, even if I think the wifi driver is ok?
> >> [   30.628792] batman_adv: bat0: WiFi driver or ethtool info does not provide information about link speeds on interface wlan1, therefore defaulting to hardcoded throughput values of 1.0 Mbps. Consider overriding the throughput manually or checking your driver.
> >[...]
> >
> >I would say that you cannot ignore it because it means that the wifi driver 
> >didn't provide the expected throughput for a station.
> >
> >But it is most likely better to let Marek and/or Antonio answer this question.
> 
> I said it's strange because it seems the throughput value is acttually updated when batman is running, even there is a warning.

Maybe it was just not available when batman-adv asked the first time.

> >Btw. please structure you mails better. I will not read through this 400KB+ 
> >text mail just to find your annotations and questions. One which I saw but 
> >which should be answered by a different person is "6-node case".
> >
> I described the main results.
> And the attahed log is just for whom interested in finding the reason. It could be ignored for the others.
> 
> I have to emphasize that, the tests show that the output route of V is ok but the delay and throughput are bad. We should try to find where's gone the bandwidth. Do you have any suggestion about it?

Since there is still the problem that the ELP messages are potentially sent 
too often for low quality links (which also need the automatic retries by the 
wifi driver/hw). Did you try to increase the interval [1]? Just to make sure
that they don't use the complete airtime.


There was also this odd wifi problem which somehow was (maybe) 
triggered or caused by B.A.T.M.A.N. V: https://www.open-mesh.org/issues/341
Unfortunately, the discussion with the reporter was rather frustrating and at 
the end stopped completely.

When I remember it correctly, the wifi performance of all nodes (even when not 
sending data over the batman-adv interface) was rather bad when some 
B.A.T.M.A.N. V nodes were around (and one of the nodes disappeared?).

Kind regards,
	Sven

[1] https://www.open-mesh.org/projects/batman-adv/wiki/Tweaking#ELP-interval
--nextPart1638291.E8EZIUobyM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAluHs5YACgkQXYcKB8Em
e0ZH7xAAn8qcBrVYHFyejX3AsfyQe07V+LwdtNU+suh1eBusSxU2Fj70XibmVbfH
hBjFlc1RT298Ply86KGrfrafI6e5NJtnIqJXb88PeRsskinze5daQhddF3e9CvgO
V0CQzEB1Q4E8qjk9ZcWmMJ3/S2ZFmosKscy6FoFb66NFEJJpItrZbeiDWWTbuzQd
au9PaGBvZzdPOZ3jm4jLmZiMii6pkOqyhtHF9jccrZ3lurxZN6WEUvEkSf2B/bHt
ad4WgaG5cvYMF8opRj6NmFPYU73Q9Eefrb2cZaK+KjgytbpAusph94vaY0aYYlV2
ZhQ3cPR7UBXntZjgjzSui3AUlfaScAkTnGE/RyVB4uFbSzZG/4r73IhADbUY/RU8
UUIqwnV0jGCbhk1IkXjQd3Elz1KJG+yoQovJQ7xUDOPqVVlkIxalLbxKjeK8x6Ze
d6ke3RISdzNlsKjEqNuiZhNTI21dqg58rBrzSRv16qSzZz/PMAOXuU/eOqMIEH+B
lGPUjwsPrz1j8awQek7nFRC1ShS2RpU2CIKKJ7SESTDQ4CBeunqZnW/1lPqlQomc
kNSzENM8/XbQzWTpMPzsn+e304TC8RVKW1cTuQVOzo/ia0XziRxougmy4oDBtH9X
4Zizbt3ssrhLKAF1/G5cxvQmUJNqK5B6N0MIQCrr5XpDc5mMZQo=
=FCHL
-----END PGP SIGNATURE-----

--nextPart1638291.E8EZIUobyM--

