Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 01 Dec 2012 17:58:22 +0100
Message-ID: <5918074.YCMEhHtl7H@sven-laptop.home.narfation.org>
In-Reply-To: <20121201164044.GO24115@ritirata.org>
References: <1353931112-17392-1-git-send-email-sven@narfation.org>
 <1353931112-17392-5-git-send-email-sven@narfation.org>
 <20121201164044.GO24115@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5918074.TFHqnHlbtT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 5/5] batman-adv: Allow to use different
	sized hash locks array
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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


--nextPart5918074.TFHqnHlbtT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Saturday 01 December 2012 17:40:45 Antonio Quartulli wrote:
> On Mon, Nov 26, 2012 at 12:58:32PM +0100, Sven Eckelmann wrote:
> > The amount of locks of a hash directly affects the parallelity when all
> > access independent parts of the hash. But this also affects the amount of
> > memory used for each hash. Allowing to decouple the hash size and the
> > lock size allows to reduce this memory consumption for hashes which don't
> > allow this parallelism.
> > 
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > ---
> > 
> >  bridge_loop_avoidance.c |   28 ++++++++++++++--------------
> >  distributed-arp-table.c |   16 ++++++++--------
> >  distributed-arp-table.h |    6 +++---
> >  hash.h                  |   19 +++++++++----------
> >  originator.c            |    6 ++++--
> >  originator.h            |   13 +++++--------
> >  translation-table.c     |   22 ++++++++++++++--------
> >  vis.c                   |    8 ++++----
> >  8 files changed, 61 insertions(+), 57 deletions(-)
> > 
> > diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
> > index 1a78bac..781119f 100644
> > --- a/bridge_loop_avoidance.c
> > +++ b/bridge_loop_avoidance.c
> > @@ -38,7 +38,7 @@ static void batadv_bla_send_announce(struct batadv_priv
> > *bat_priv,> 
> >  				     struct batadv_backbone_gw *backbone_gw);
> >  
> >  /* return the index of the claim */
> > 
> > -static inline uint32_t batadv_choose_claim(const void *data, uint32_t
> > size) +static inline uint32_t batadv_choose_claim(const void *data)
> > 
> >  {
> >  
> >  	struct batadv_claim *claim = (struct batadv_claim *)data;
> >  	uint32_t hash;
> > 
> > @@ -46,12 +46,11 @@ static inline uint32_t batadv_choose_claim(const void
> > *data, uint32_t size)> 
> >  	hash = jhash(&claim->addr, sizeof(claim->addr), 0);
> >  	hash = jhash(&claim->vid, sizeof(claim->vid), hash);
> > 
> > -	return hash % size;
> > +	return hash;
> 
> I do not fully understand how having the mod operation inside the function
> would prevent the decoupling. Why you need to move it out?

Because following calculations can create different results:

* (i % hashsize) % locksize
* (i % locksize)

Example:
* (21 % 4) % 3 == 1
* 21 % 3 == 0

And of course, we could use only the first calculation. But then we would end 
up in having more hash buckets mapped in the first part of the locks when 
hashsize > locksize.

Kind regards,
	Sven
--nextPart5918074.TFHqnHlbtT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQujcuAAoJEF2HCgfBJntGWTsQAJ+xgxmBFIYNs+w06ETaWpeR
V7/Pbgw1tWkVpKRSm6zflNmRHJVJ+PNfyMKltQ2GeTlbu4twkceUBfCspreWmvwh
TFsbU3VAxuotJE6Irq0z9MYIIY2UFrbxiEHH0NF4V5B/D5vpfM1yoIQGOlpRSdU3
pCF3XE6BYmiaffEiIlxi+7nwqPlLRiVVREqRsiGCrZQOpdc9aDBXh7anaR332gDS
S6sCXc1UYIOdy+J+ZDYrP9Sl5/pPwtHDIUF23jUwGo1/yDWNFnLVKRFCxUt7rwdm
iG/d/uizRkPkSJvybU2kH98wUtTRRBnP1xHsN4EwNP5x4J4HGludLeWkqHBaxMbR
vUNqrcSvXLeJdMK21KxUMyZStwLNt6IP8i9/roCTL+v6LOac9511RTRZ4iwAPfRO
tUY5ENx+v1eJCwMmq/St0AVn3sgSQo8VmzQm5lAK5cRkriRexpDHepN5i3xfwBsd
tGjGQL/HIOJfA+9UdnWZBTCTO/XSbr6+yl1XjE1vlLf+kUY4jM5ipNS0h24Htq7j
9QIgRGfg9ppGRACq0DHD4phSoQK8aKVr6X6OCMyh6lsO91W15DWQo1ifsZfXxPI5
C7x53t1SdhwVVq2MKYzJnwf7AQyyASZ7XtTdihFBt1UT17dvGz9eBWwii6Njexue
ll1Xepr2/coxme+O9uz1
=Alkx
-----END PGP SIGNATURE-----

--nextPart5918074.TFHqnHlbtT--

