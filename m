Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 05 Feb 2015 13:34:51 +0100
Message-ID: <1941941.HLll8057rP@prime>
In-Reply-To: <54CE26E4.7070307@web.de>
References: <54CE26E4.7070307@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1513823.KxoXJeh2E2";
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1513823.KxoXJeh2E2
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

Hi,

On Sunday 01 February 2015 14:15:16 Moritz Warning wrote:
> Hi,
> 
> I need to display the number of all nodes/clients as well as all neighbor
> nodes/clients. This would be easy if batctl would be able to output the
> respective list of mac addresses (batctl ... | wc -l).
> 
> I've started writing a patch as part of a feature request:
> http://www.open-mesh.org/issues/203
> 
> But the problem is how to get the respective output form the debug tables.
> I have been reading the docs, but have not been able
> to understand the necessary information needed, no offense:
> 
> http://www.open-mesh.org/projects/batman-adv/wiki/Understand-your-batman-adv
> -network
> 
> Some explanation beforehand:
> Clients are computers not running batman-adv,
> represented by the MAC address of its network interface.
> Nodes are computers running batman-adv,
> represented by the MAC address of its primary interface.
> 
> List of all nodes:
> Get all MACs from the 'Originator' column of the originator table

Note that this may also show secondary interfaces of your neighbors - you may 
have to filter that against a list of primary interfaces you collect otherwise.

> 
> List of all neighbor nodes:
> Get all MACs from the 'Nexthop' column of the originator table
> and make it a unique list.

That sounds about right, if you want to include all neighbors which are in 
radio range (even if you are not currently sending to them). Alfred-vis for 
example only considers neighbors which are actually chosen for some 
connections. Again, you may include secondary interfaces.
> 
> List of all clients:
> Get all MACs of the 'Client' column of the transtable_local table
> when it starts with a '*' character.

Yes, but you may want to filter out local mac addresses, which are configured on 
top of VLANs on bridges.
> 
> List of all neighbor clients:
> Get all MACs of the 'Client' column of the transtable_global table
> when it starts with a '*' character and when the nodes own originator
> MAC (of the primary interface?) is also in the 'Originator' column.

Yup, but in this case again you don't know what are clients and what are 
bridges/vlans configured on top of your other nodes. That's going to be tricky 
to filter.

How about you use alfred-vis or your own alfred-based service to do the 
filtering properly? Some kind of distributed/centralized database would help on 
the filtering job, IMHO.

Cheers,
    Simon
--nextPart1513823.KxoXJeh2E2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlTTY2sACgkQrzg/fFk7axaNtwCglQ1LK1ovC3TDyyFXI623xoZX
xfAAn0GGbfovp7I4ARuqEPeyV3HpajSE
=kGlt
-----END PGP SIGNATURE-----

--nextPart1513823.KxoXJeh2E2--

