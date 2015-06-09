Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 09 Jun 2015 22:49:33 +0800
Message-ID: <2564251.KYcHvgers4@voltaire>
In-Reply-To: <1433172597-21776-1-git-send-email-antonio@meshcoding.com>
References: <1433172597-21776-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1567548.KQIehUXeRD";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 maint] batman-adv: avoid DAT to mess up
	LAN state
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart1567548.KQIehUXeRD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, June 01, 2015 17:29:57 Antonio Quartulli wrote:
> When a node running DAT receives an ARP request from the LAN for the
> first time, it is likely that this node will request the ARP entry
> through the distributed ARP table (DAT) in the mesh.
> 
> Once a DAT reply is received the asking node must check if the MAC
> address for which the IP address has been asked is local. If it is, the
> node must drop the ARP reply bceause the client should have replied on
> its own locally.
> 
> Forwarding this reply means fooling any L2 bridge (e.g. Ethernet
> switches) lying between the batman-adv node and the LAN. This happens
> because the L2 bridge will think that the client sending the ARP reply
> lies somewhere in the mesh, while this node is sitting in the same LAN.
> 
> Reported-by: Simon Wunderlich <sw@simonwunderlich.de>
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
> 
> Properly base this patch on top of maint.
> 
> 
>  distributed-arp-table.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)

Applied in revision 9bbd794.

Thanks,
Marek

--nextPart1567548.KQIehUXeRD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVdvz9AAoJEFNVTo/uthzADAkH/i21jUL7umMi6y0EgDSDahBU
+p98Rcj5QSkli4Dn34A8qFAGzmspM70VLA67+xZhh0fGZECIcSddQFh8LeZujXW1
3xz1zj5PpR7UUQew41gvqFsu4BLXuuKxdcr9UJnOxECqjHWPdCU2kN991Ac0TinL
QLi4UXXKG7V8tnj81BZGL9Ztci6Y1nuBBCg8FsqhgnNHM2zfOKmEPYWieFArJ01z
d/Mf8SxVjRjBFKTxnlJhUwFoiT4evk7zFSckAjpwqmRM2A5+C6sCRMGoSZoMqtEv
mDpqY3Tu1NWlFQxWvROgIJlX2gdZSGO2ngQyFfrOysplvif22hu4fhduQo+Xwgg=
=Tt2Q
-----END PGP SIGNATURE-----

--nextPart1567548.KQIehUXeRD--

