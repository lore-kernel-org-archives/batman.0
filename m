Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 22 Jul 2015 17:58:25 +0200
Message-ID: <7098754.rficnZ0CR1@prime>
In-Reply-To: <55AFAFD9.808@autistici.org>
References: <55AFAFD9.808@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2061998.hL7HSJMQlu";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] encapsulated ethernet frame format
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


--nextPart2061998.hL7HSJMQlu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

Hi Berat,

yes this is expected:
 * the first Ethernet section is required for WiFi (or Ethernet) to send the 
packet on the physical link between two neighbors - this will change with 
every hop taken in the mesh
 * The batman section includes a couple of control fields and also source and 
destination (at least for unicast packets). These sources and destinations are 
for the originators, that is mesh nodes within the mesh, which may be a couple 
of hops away
 * Finally, the second Ethernet section contains source and destination of the 
devices which are actually talking to - these devices are not necessarily mesh 
nodes, but might be devices only bridge into the batman-adv mesh network. 
batman-adv takes these Ethernet frames as they are and encapsulates them by 
adding its own batman section and the per-hop first ethernet section as you 
saw.

So if you want to work on the "originator" layer, have a look at the batman 
section source/destinations.

Cheers,
    Simon

On Wednesday 22 July 2015 16:59:37 Berat wrote:
> Hi,
> 
> I was trying to understand how batman-adv encapsulates ethernet frames.
> Batman dissector of wireshark, shows an ethernet II section, then a
> batman section, then again an ethernet II section. Is this
> rappresentation respects the original capsulated header format? I
> couldn't find a scheme that shows fields of an encapsulated header in
> the documentation. So with wireshark, it tells me something like that:
> 
> -----------------------------------------------------------------------
> Dst.Mac|Src.Mac|Type|Packt Type|Version|TTL|Seq.No|Dst.Mac|Src.Mac|Type
> -----------------------------------------------------------------------
> \___________________/\____________________________/\__________________/
>    First Ethernet 	   Batman Section	     Second Ethernet
>     II Section  					II Section
> 
> 
> Why there are two times destination and source mac addresses? I want to
> retrieve mac addresses of originators of packets by working on raw
> packet data. But i'm a little bit confused with this scheme. Sorry if
> it's a banal question, i don't have much experience with networking.
> Thanks for any help.

--nextPart2061998.hL7HSJMQlu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlWvvaQACgkQrzg/fFk7axbAqQCgp0irhd2TFZaG2mm6dIWtgOrD
h8sAoIuG8zJPoySD6khjvS5NPqizHNDG
=8HdD
-----END PGP SIGNATURE-----

--nextPart2061998.hL7HSJMQlu--

