Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 2/4] alfred: Allow operating without any interface
 specified
Date: Mon, 03 Jan 2022 09:54:26 +0100
Message-ID: <1647569.GsyeJrCcj3@sven-l14>
In-Reply-To: <2907656.mQGJSZOrAB@rousseau>
References: <3748133.vRqKQLy7FI@rousseau> <2887321.KE3FGX6OkO@sven-l14>
 <2907656.mQGJSZOrAB@rousseau>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4639238.kWkPaYRiN0";
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
To: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

 
--nextPart4639238.kWkPaYRiN0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH 2/4] alfred: Allow operating without any interface specified
Date: Mon, 03 Jan 2022 09:54:26 +0100
Message-ID: <1647569.GsyeJrCcj3@sven-l14>
In-Reply-To: <2907656.mQGJSZOrAB@rousseau>
References: <3748133.vRqKQLy7FI@rousseau> <2887321.KE3FGX6OkO@sven-l14> <2907656.mQGJSZOrAB@rousseau>

On Sunday, 2 January 2022 20:01:47 CET Marek Lindner wrote:
> On Sunday, 2 January 2022 15:20:20 CET Sven Eckelmann wrote:
> > This now causes the "--force" option (+its storage in the globals data
> > structure) to be completely useless. 
> 
> Why would global->force be useless ? The alfred_server() function still uses 
> the global->force state to determine if globals->mesh_iface is configured 
> correctly.

Ok, you are right about mesh_iface. But the patch missed to adjust the manpage 
to clarify this.

> > I would prefer to have this handling still be there when
> > !list_empty(&globals->interfaces).
> 
> To be honest, I hadn't fully understood what use case global->force is trying 
> to address. What do you have in mind ? Checking for list_empty() will require 
> alfred to be always started with an interface configured while alfred could be 
> used without any interface at all and operate as local data storage between 2 
> processes on the same system or the interface could be configured at a later 
> time (via unix socket).

No, I wasn't talking about list_empty() but about !list_empty(). You removed 
the first block because you want to have have alfred started without any 
interface - fine with that.

But the default behavior of alfred in the past was to first check if the 
selected interfaces make sense and then return an error if there was a problem 
to open them. The force option basically ignored any error when there was an 
interface not ready yet. But the patch completely removed the chance to pre-
check the interfaces on startup.

> > And why is it necessary to not open the sockets on startup when interfaces
> > are already given?
> 
> The main while loop calls netsock_reopen() in each round which will open all 
> necessary sockets (unless I am mistaken). My guess is that this was added when 
> the ALFRED_CHANGE_INTERFACE call was added. Therefore, the netsock_open() call 
> is somewhat redundant unless alfred is meant to always require an interface at 
> startup time and alfred is meant to bail out whenever that configured interface 
> isn't available at startup time.

See above. The situation I had in mind was:

* force not enabled
* an interface given to the process
* interface cannot be used by alfred

Kind regards,
	Sven
--nextPart4639238.kWkPaYRiN0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmHSucMACgkQXYcKB8Em
e0ZOIw/+KNl0DfGZkQ8ewv+0aAT0dpj0tkMuNNpcHa/dCqt9kUky42n/brXT4ntk
cBCxs62PaqzdOzPOHW5Kbb6AYLxFz0yOUNQTRKlonCf5vG0NKX52VNGKNirt+i71
x2GmBj3CbD7AYc1b+WwhCbtwr3CFg6zBIoWWuPEfQpTphc4GewGRrpP0/R+PVjgT
xrmlp+OjZoKjhsYCHndc+gNzWI0R2p4hNzAqDg9coK86CMHuocM/qIuqaLP5js1f
stvlsGrdPPT/CM5F+4RWoGC59zOCtBtuYWb5dIAdjSo0FjPGuT9JeU9hb+oRiI1R
8EGkaT08yYqtEPg5uyGBxFsyGYrPnOL4JSI8u8uc1rTr/0Eec+V1wHkmF9fhaV0m
gQW9sPUuUSDhJcgR9BnxpNbIvsQohmAyi4yFmCzAwvXG0uJMnEiVJ88JMiiB9BKB
3ZDCQR2Q63hR/GXlna2AUI+kzJaV9u7rWfHoA5SxND2Z2XZGE/OL1+h3tflxJrUL
8l35CPrA1lUPxrzSRp+Umxs5sCDiWktbmu5G2HCfHn7VLhCb4F+6O/nS+5+O91PC
w6BmMKsmnQfT6ljZwbtcLzAlhyes5RySjXXc8py0ZDKU6QOsRTDfsdJ94OBPtq4Z
9pRlpNJskdfJonKgm201fsq1qwsMwbAS+/Mv8d2FtJpVHsMpmvI=
=caER
-----END PGP SIGNATURE-----

--nextPart4639238.kWkPaYRiN0--


