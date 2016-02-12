Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 12 Feb 2016 14:04:23 +0100
Message-ID: <2193610.djA1bK6ZTb@prime>
In-Reply-To: <OFE4164813.C8B92EEC-ONC1257F57.0038C5A8-C1257F57.003AA049@phoenixcontact.com>
References: <OF64B7E443.53DA160A-ONC1257F53.003E4656-C1257F53.003FAF34@phoenixcontact.com>
 <3200137.NDelIOaaur@prime>
 <OFE4164813.C8B92EEC-ONC1257F57.0038C5A8-C1257F57.003AA049@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12547456.jFqLRrd9nk";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Antwort: Re: Re: Antwort: Re: Looping unicast
	packets when using BLA
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andreas Pape <APape@phoenixcontact.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart12547456.jFqLRrd9nk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

Hi Andreas,

On Friday 12 February 2016 11:40:21 Andreas Pape wrote:
> > > [...]
> > > using dat in combination with bla:
> > > 1.Broadcast ARP requests from the backbone network are handled by each
> > > gateway, leading to multiple dat adress resoultions in parallel.
> > 
> > That shouldn't be a problem on its own.
> 
> I think I wasn't precise enough concerning this point. I meant the effect,
> that
> a broadcast ARP coming from a common backbone reaches all gateways. If now
> accidentally
> several gateways can already answer that request due to dat, then the
> current code sends
> an arp reply from each gateway being able to answer. This broadcast does
> not even reach
> the mesh if all gateways can answer the request (as far as I have
> understood the code).
> Therefore broadcast handling in the mesh layer does not solve this
> problem.

Yes, we may have multiple gateways answering with an ARP reply. But how is 
this a problem? It is redundant, yes, but its just a unicast sent back. I 
don't see this a s problem yet ...

> 
> > > 2. As dat uses tunneling of broadcasts in special batman-adv unicast
> > > frames, the current bla code does not seem to prevent these broadcasts
> > > from reaching the backone network as it is done for normal broadcast
> > > coming from the mesh and heading for the backbone.
> > > Both effects together lead to a multiplication of arp requests and
> > > replies. My patch of last year tried to address this.
> > 
> > Hm, I see. I just checked the code and it seems we fixed this issue
> > for speedy
> > join in the mean time (affecting TT), but for bla the problem is still
> > present.
> > 
> > Wouldn't it be sufficient to add something like a check for backbones (
> > batadv_bla_is_backbone_gw) into batadv_recv_unicast_packet() and drop
> 
> packets
> 
> > if they came from the same backbone?
> 
> That's a good question. This is something I did not dare to do last year
> because
> I cannot foresee possible negative implications. Perhaps someone more
> experienced with
> batman-adv routing should answer this. Therefore I focussed on fixing this
> for the DAT ARP handling only.
> But doing so as you propose would most likely have the positive side
> effect that I will get rid
> of the looping unicast packets in my backbone network, too. But as
> mentioned in my prior mail
> I think this looping unicast packets might have another cause. The
> question is: why does
> a gateway forward a unicast packet received via the mesh with a
> destination mac behind
> an originator somewhere else in the mesh (that originator is not connected
> to the same backbone) to
> its own backbone? If this only can happen if the entry in the global tt
> expires (like a mac adress
> table expires in a switch and the switch starts broadcasting incoming
> packets to all ports), then
> I would think blocking all unicast traffic coming from another backbone gw
> of the same backbone network
> is the smartest and easiest solution.

Yeah, agreed. There shouldn't be any unicast messages to be sent among 
gateways through the mesh. We probably should not only avoid the receiving (as 
I suggested only), but also sending DAT requests to other gateways on the same 
backbone. The check should be similar and simple ... After all, if there is 
another gateway capable of answering, it will also receive the request and 
doesn't need it passed from somebody else on the same backbone.

Regarding the TT question/expiration, as a receiver we don't check the 
destination address and just accept the packet for receiption. But as I said, 
packets among gateways on the same backbone shouldn't be sent or received.

> 
> > I have found your patch from last year. Would you like to rebase/split
> 
> your
> 
> > patch to address the remaining issues? That would help us a lot. Please
> 
> also
> 
> > put a proper patch message. I promise to be more responsive this time.
> :
> :)
> 
> I'm trying to split my last year's patch into logical seperate pieces,
> update them
> to be compliant to the latest master branch of the batman-adv.git
> repositor and will
> mail them for further discussion.

Cool, thanks! I'm looking forward to it. :)

Cheers,
     Simon
--nextPart12547456.jFqLRrd9nk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWvdhXAAoJEKEr45hCkp6hxhQP/A+vNcgXmXw2xodu2T+PtZzR
mgGmI4TsH+8szsvNnFko5DOzj9H9VCnRsECy8n47XXKDqR89uRt4iv58PuBFe76m
gRQxhN7TAndTI5Z0t77AXHugLGerwTLjaMBkv2FLscrUcHXTKqVyOrJOHn1izXZK
DMI8PkUchFsloGP1lx05gqA7EyoIymU/CZaHOsdcO/InJ5Nla8lM7S2k1U2XAvL3
UjXbji9DQZ7mudKY5rXNE2XvWCfHIZFrKh7nM/RZocVSCrQrAyYWipxXz5+HwSyz
FaMmxtTi14xDFkzycqNA/M9TrnB/TrJH+n3N2I6NmIvc6z6xH/8C0tM4jfR/ZD2H
WRR1iIRF1GhbzN7ZkM1OE8vINDCSG+kaLGcA7vdTnruX+sEPteMNr4wpzJ22S4ui
6KKsAuSuQF6+rXkdPV7/P+hzFlv9qAbLIx2EqXo3FJGnIh3uwIqhMD/oJckh6XSv
GaA5V9Ja/7VAGUGdFH2KCWt5ipHCndFSWVFaqN6CrujEsvD3nSmTUESqw3S4H6Bd
PLauYqlTZ8WfkQS3UJZYf6TFUz6WmJS/OJ40kDfw0KUY44U9TEwm4v1QvtSCNsDX
HgBfqWhUXrWo8k1iLwf71BeA2AWm3hFI/cmV5IYsSh8pcfRbIBE69VOsWGyr6zc5
UjD/4tcz8QSD5wZ0zzdL
=CPDO
-----END PGP SIGNATURE-----

--nextPart12547456.jFqLRrd9nk--

