Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 12 May 2016 07:05:20 +0200
Message-ID: <1588847.AaxGtfAtFh@sven-edge>
In-Reply-To: <CAKOC6KQMSca-tSOoKFm9t1LXrOnwHKbf3Ac0hXT6QZWxM_uwtw@mail.gmail.com>
References: <CAKOC6KQMSca-tSOoKFm9t1LXrOnwHKbf3Ac0hXT6QZWxM_uwtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart22861884.dEJtd8tydJ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Problem with DHCP on batman-adv V
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart22861884.dEJtd8tydJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 11 May 2016 18:58:48 Alvaro Antelo wrote:
> Hi everyone,
> 
> I am testing batman-adv V5 from the development feed on Chaos Calmer
> and so far everything is working except for DHCP IPv4, only static
> addresses.
> In the same setup wich involves bridges connected to bat0 interfaces,
> if I change only the routing algorithm to batman-adv IV, DHCP works
> fine.
> 
> Is it a expected behaviour?

Afaik there is no working gateway selection logic in B.A.T.M.A.N. V. At least 
Antonio works on some patches for this:

https://patchwork.open-mesh.org/patch/16139/
https://patchwork.open-mesh.org/patch/16140/
https://patchwork.open-mesh.org/patch/16141/
https://patchwork.open-mesh.org/patch/16142/
https://patchwork.open-mesh.org/patch/16143/

This includes splitting up the logic and use the metrics for each routing 
algorithm. But I think he can tell you more about now works (or doesn't) and 
what will work after his patchset is applied.

Kind regards,
	Sven
--nextPart22861884.dEJtd8tydJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXNA8QAAoJEF2HCgfBJntGyKQP/2GhtvoTh1m0LRiHjf1F7/hU
clffrDF6H0eEa4cZBMqXp44ydAhhvN0FrtJnrizV6y7La2cZYOEaB76nJpSjDLtM
LUOCvMXmdfXJj3XuK+W2qoDMnxCTuC8Js5i4wwHEgHmSyTbPBzZ3GAPG6n2jn8qv
eqXHZ9t0QDWnd6vsdoCPjy+RXP3Jvq6PJtHypETYHPPvdRVN99gXnrAOIgAuqbl3
5aXPwnYvr6ByuIpRDZeBb0945UWvdLLLI0rc0Dn1fkQlS2XH12CtgRBZYQvfsn25
mT+IWlC7/fE1v+2ckrsAwHtwyEThlVuC56l7z6sfuIZI6zuCEGYSBi5gaHAu8ZwH
V8g0mby/2ev1JsLial8TbN6yEAokEbYnhE50aebqAzR0UDLtwmf1ocB7fuyxv0N+
Z2DjoBg6XlsA44BOMif4ewWRu7qb3OF5lyzJDYd4yuIn2N2ccbnT3CNk5QllyP/E
bupFwMEul5WNTnn+gCp+I7xM0Ag9Bcmu3V09RX355eXCvUsm3p0tnbPszdlHXWPB
zPqboozyUIozBIntsA1zZvnpPvKeFKLMyMqXLanREUSatTmWA8/H8wdXVApI8GzM
9BWfENE04eytLRu4CWwRsz9I7ItT/QCYJTPTfOYmV79UlPaG9gSaHM4paf3WX8Fz
ziXZwzxvbG6kbXB/h1WS
=pupi
-----END PGP SIGNATURE-----

--nextPart22861884.dEJtd8tydJ--

