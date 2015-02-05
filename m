Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 05 Feb 2015 19:24:50 +0100
Message-ID: <34714295.JmkViaXzvE@prime>
In-Reply-To: <54D3B243.9060800@web.de>
References: <54CE26E4.7070307@web.de> <1941941.HLll8057rP@prime>
 <54D3B243.9060800@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart21566099.7sEGlSdv1L";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batctl: feature to filter nodes/clients
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
To: Moritz Warning <moritzwarning@web.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart21566099.7sEGlSdv1L
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Thursday 05 February 2015 19:11:15 Moritz Warning wrote:
> >> 
> >> Some explanation beforehand:
> >> Clients are computers not running batman-adv,
> >> represented by the MAC address of its network interface.
> >> Nodes are computers running batman-adv,
> >> represented by the MAC address of its primary interface.
> >> 
> >> List of all nodes:
> >> Get all MACs from the 'Originator' column of the originator table
> > 
> > Note that this may also show secondary interfaces of your neighbors - you
> > may have to filter that against a list of primary interfaces you collect
> > otherwise.
> Ok, I wonder how I can filter out those secondary interface MAC addresses
> of 1-hop neighbors.
> Can those addresses be recognized by comparing it to the Nexthop column?
> This seems to be the major problem for me right now.
> 

Hmm ... actually you can't find that out from the originator output, since 
there is no distinction there.

Maybe one thing how to find out from a remote host without prior information 
(e.g. centralized database) would be to look at the tt global table - 
secondary interfaces won't show up there. But thats also more a hack than 
anything else. ;)


> >> List of all clients:
> >> Get all MACs of the 'Client' column of the transtable_local table
> >> when it starts with a '*' character.
> > 
> > Yes, but you may want to filter out local mac addresses, which are
> > configured on top of VLANs on bridges.
> 
> Are those the MAC-addresses of the bridge interface. Say, when I bridge bat0
> into br-lan, then the MAC of br-lan will show up as client?

The mac address of br-lan will most likely show up in the local translation 
table, yes - unless you never send a packet from that interface.

Cheers,
   Simon
--nextPart21566099.7sEGlSdv1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlTTtXIACgkQrzg/fFk7axaxHACgiR6aWCCpnTZvYUN3dDB+yqBj
s/wAoJdLxBjHrxBeNPfSlgtPzD6QZGQH
=KF5/
-----END PGP SIGNATURE-----

--nextPart21566099.7sEGlSdv1L--

