Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: Bonding Alternating
Date: Tue, 21 Sep 2021 16:16:27 +0200
Message-ID: <4948508.lctyQggAPn@prime>
In-Reply-To: <7e8fe0e7bf7b42baac350b20f2a0846a@viasat.com>
References: <8679334.VDzE56WMh6@prime> <2528179.d2XtbQqvsD@prime>
 <7e8fe0e7bf7b42baac350b20f2a0846a@viasat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2521225.qI6e1uoXLY";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>, "Edmisten, Brian" <Brian.Edmisten@viasat.com>

 
--nextPart2521225.qI6e1uoXLY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Simon Wunderlich <sw@simonwunderlich.de>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>, "Edmisten, Brian" <Brian.Edmisten@viasat.com>
Subject: Re: Bonding Alternating
Date: Tue, 21 Sep 2021 16:16:27 +0200
Message-ID: <4948508.lctyQggAPn@prime>
In-Reply-To: <7e8fe0e7bf7b42baac350b20f2a0846a@viasat.com>
References: <8679334.VDzE56WMh6@prime> <2528179.d2XtbQqvsD@prime> <7e8fe0e7bf7b42baac350b20f2a0846a@viasat.com>

Hi Brian,

I've checked it out and can confirm your issues. The bonding code as currently 
implemented is trying to use a different router from each routing table towards 
the same originator[1]. However, with 1-hop Ethernet links those routers are 
always the same in all the routing tables. With WiFi that would be a bit 
different (I've commented out the WiFi penalty check), but even then it only 
alternates between two of the three interfaces.

At this point I don't have a straight forward fix for this. Will you use three 
Ethernet devices in your later deployment, or will those be WiFi interfaces? 
Also, would it be useful for you to consider bonding/teams interfaces of the 
Linux kernel to bond the link, and give that to batman-adv?

Cheers,
       Simon

[1] https://www.open-mesh.org/projects/batman-adv/wiki/Network-wide-multi-link-optimization

On Wednesday, September 15, 2021 4:58:58 PM CEST Edmisten, Brian wrote:
> Simon,
> 
> Thank you. I appreciate you looking at this.
> 
> Regards,
> Brian Edmisten
> 
> -----Original Message-----
> From: Simon Wunderlich [mailto:sw@simonwunderlich.de]
> Sent: Wednesday, September 15, 2021 12:26 AM
> To: b.a.t.m.a.n@lists.open-mesh.org; Edmisten, Brian
> <Brian.Edmisten@viasat.com>
> Subject: Re: Bonding Alternating
> 
> Hi Brian,
> 
> hmm, I see. I will try to set up this scenario over the next few days and
> let you know. I haven't used bonding for quite a while now, but I also don't
> think that we had changes in the code which would break it.
> 
> Anyway, will test and let you know.
> 
> Cheers,
>       Simon
> 
> On Tuesday, September 14, 2021 6:57:37 PM CEST Edmisten, Brian wrote:
> > Simon,
> > 
> > I did check again.  batctl bonding responds with enabled.
> > 
> > Cheers,
> > Brian Edmisten


--nextPart2521225.qI6e1uoXLY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAmFJ6TsACgkQoSvjmEKS
nqExtw/8DvoXN+S5a4m2vpXkRItdbkmNlOCmkOVyrK4T8WaA/zbGZM9+HmObaNtu
cR7QtBhJmXI9bTrKMQJ5jiq/ivh7NbIbP/hGbYT9UAvzIKHgbB1cqGHXaCxcJzG2
rZe6GH4651QtEE5sMIgSVLzhNqb0q+V8IwuwIGcz2ns0L6lub8mGyKWQ8/od+Gfv
HbFNspwo/hhYn1rvbSqfvg+w3PWEhDoIHbGrxJZZBXd5iA9RNHKq2idks8kVA9S3
QXhp5WPllhMmko5sXLjHTEPHu81p2vdSpdkYzJQqK+whqjMwiLnqIEDxGh/UPvy8
5OlvL+iFHxHCPlAxbpkPYPkTmE+MWhUhBMjkI7ah+5a9KnFmI7GnweHRY3pFM078
mIZVLlYMpOxgW9z3PXtc01r/quH94Y/wIHZnWsrZHvqD8HAr/2N16rz/vdnhMqBr
OonlMQ+5LTeRkRUUXe8/KARB+tO00e5jouYzpaB4A6Yr9UimoUahIXHHRNosCVPw
AcQMfAiv73tIjDsvCzFJdbS8gh3UtfUSAoPz1rrJpeaSHziA/4lvizRPxuOEif+W
eGN955jG9HCg36LjLUbn8qHv/wJ6YpFvznDee+2LN9x0KtK0g/vIyDBaDwdaGJTx
TBei3621y4J3UdNg2jROSmq4isEwsTL3qVn/l6R/aTFBkWJLgJ0=
=X8x0
-----END PGP SIGNATURE-----

--nextPart2521225.qI6e1uoXLY--


