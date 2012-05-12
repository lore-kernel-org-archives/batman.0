Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 May 2012 14:01:41 +0200
Message-ID: <1379829.aiuEal9R8A@sven-desktop.home.narfation.org>
In-Reply-To: <20120512115652.GB14279@ritirata.org>
References: <1336823339-4095-1-git-send-email-sven@narfation.org>
	<20120512115652.GB14279@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1784554.sFqPWoXLxO";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/8] batman-adv: Move hash_ipv4 to
	distributed-arp-table.c
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1784554.sFqPWoXLxO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Saturday 12 May 2012 13:56:55 Antonio Quartulli wrote:
> On Sat, May 12, 2012 at 01:48:52 +0200, Sven Eckelmann wrote:
> > hash_ipv4 is only used in distributed-arp-table.c and therefore can be
> > placed inside this file instead of the header.
> > 
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > ---
> > 
> >  distributed-arp-table.c |   24 +++++++++++++++++++++++-
> >  distributed-arp-table.h |   22 ----------------------
> >  2 files changed, 23 insertions(+), 23 deletions(-)
> > 
> > diff --git a/distributed-arp-table.c b/distributed-arp-table.c
> > index e678ec4..4894a85 100644
> > --- a/distributed-arp-table.c
> > +++ b/distributed-arp-table.c
> > @@ -32,6 +32,28 @@
> > 
> >  #include "translation-table.h"
> >  #include "unicast.h"
> > 
> > +/* hash function to choose an entry in a hash table of given size.
> > + * hash algorithm from http://en.wikipedia.org/wiki/Hash_table
> > + */
> > +static uint32_t batadv_hash_ipv4(const void *data, uint32_t size)
> 
> since the function is static, why do we want to use the batadv prefix? would
> this create confusion?

Consistent naming scheme.

Just imagine that somebody needs some function like that in another file and 
don't want to move it to the header. That would mean that he removes the 
static and add a declaration in the header file.... and now we have the 
problem of the missing batadv_ prefix. Either he changes the name everywhere 
or creates those potential namespace problems.

So I would recommend to use the batadv_ prefix everywhere. Less problems in 
the future and maybe a happier David. :)

Kind regards,
	Sven
--nextPart1784554.sFqPWoXLxO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJPrlElAAoJEF2HCgfBJntG40gP+QEZDNNQV8Jnd5WS1eD/hSH7
tyhoVvavURXj+f4jMit5MOWjvQf49WYT+Rx+sLzXYSigFl5fukgC34sHH9aT8WMG
vDuj4WahLXNPtg+H97+TiEKOATgFb1pZVsqpEaUzdjuxQ7sQWvEskgT7kmackd/+
RtIlYnjFk1uzKKSKCmfqkPCXNg6ImW+Yk+mJUrSq8UiMNR+tKVgnfo/PxCuEH/q6
OyO1lC5mkoBDgN4vz7hbsCKDSGuW5DVbCUgO847fpX8+5soD14gQ68EmvqJZ0QPy
sSKj4/EKDqsW2YI6/5EV81vlUgIuE58Vro/1r404UOIFfj+fjDCMf0UXmXud9mIc
pLjc5njPvPO9LjVuGvWFGW2QKAiEiNjueva9xMXawC87MrdBmUynNa5YFN1UyOsU
XDFxdLXjUY87GyfCgKYu337+whtd/qPZUHBXltWL1GYgQ+we2BseQLn1m6kzeGFQ
v4q978/gjEfQ+rsVLlGdq+vXWSlKFRd2x1XTuzlzWcJnY/08PJJb75ge3V59/6c/
Nf45m5aN3O/G0t42mVyvC0r62j+ejVCXH+MC72pbQpVhMzPBJNSFJsNZFAB48+Q+
46qMJTL0VuQ8YZ3rYPUL3brJmyIiimeX2EQl9MCUkAbmvh5spzFR9y6JDkmum/b1
05OWxbPEmbJO7NJ1BL97
=pBML
-----END PGP SIGNATURE-----

--nextPart1784554.sFqPWoXLxO--

