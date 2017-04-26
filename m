Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 26 Apr 2017 18:05:48 +0200
Message-ID: <1504855.vmUtePouqW@prime>
In-Reply-To: <1493216459.18414.3.camel@openmailbox.org>
References: <1493216459.18414.3.camel@openmailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1782383.EhJu8sBe6S";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] how well does batman-adv scale
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

--nextPart1782383.EhJu8sBe6S
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

"works well" depends much on  your scenario.

I've seen many well-working networks with 100-300 nodes. There are Freifunk 
community networks with over 1000 nodes running batman-adv (i.e. "standard" 
users like laptops and smartphones), but they employ a lot of filtering to 
avoid too much broadcast.

Unless you have special restrictions like minimal broadcast traffic or high 
capacity on the wireless links, memory and CPU, I would not recommend to plan 
for 10 000 nodes and beyond.

Cheers,
     Simon

On Wednesday, April 26, 2017 4:20:59 PM CEST fuumind wrote:
> Hi list!
> 
> Been lurking for almost a year on the battlemesh list and recently
> joined here as well. 
> 
> I'm curious about how well batman-adv scales. Would a network of 10 000
> nodes work well? What about 100 000 nodes or 1 000 000?
> 
> Thanks!
> fuumind


--nextPart1782383.EhJu8sBe6S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlkAxVwACgkQoSvjmEKS
nqF5PA/7BNE+SFgY9OUNv1+Xj+x6CgePWsOCC8i2tgOyjSDKFJpTbE4P1afxcpPo
oYX+ThzzmL7ZaLhT1yN1cSmiqpd+HOLItBFZJ6GynOrUAJQ5kEppP7WrKsWLMU70
5duTYrjobLtViGYVWiQ17TL6LOvpegcZPxQzLNHjzsplsJLeqSRI1cXxy/hPtiuf
xhlOhvmrHekcWcyODCSF8rpQOTnleEKkE/dIiJCq9alKKBeAlVzmQbp0mr1RAoVw
HBsDDAMQ8EBkOfSSbIrh9w5AgUxo38FD79hByUBVZ37ltD685xZXS25o9rXRRdkl
/Kc0g/bSQXVEqLDufdGdalbbw6xVhVm2IzySmeJNlmdMLYr2tJsSIqp/HpWnsp/b
bu5y16MpqgE2ITvBl7HGdgYrXHddWTTEIaiaiM2V9FCSpP6cjNinJKx3ZRZxT+72
7t3ZKaov142En7b/0ewV4Wg1voiL/fa+0gKB7INiIptx/NTHcriJmhLIRFKJH0gp
4BmE6SWtZjjn2Ej02SFX44Vgl66vidi1qZ2WNtCxIUDEQQytjgRF7wDdM99+mtgF
qYqVyMmzzZGEJYUtZiND7PqVWY4V4Swy7oi5FWIXrAjmPbndTeihegiCp8cyPrXx
YAg7t5aOn4NTNg6AAFK4Fg5bsjzHw7lIfOes3ko1LL9gwonoEXs=
=liud
-----END PGP SIGNATURE-----

--nextPart1782383.EhJu8sBe6S--

