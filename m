Return-Path: <antonio@meshcoding.com>
Date: Fri, 1 Nov 2013 15:39:03 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131101143903.GX970@neomailbox.net>
References: <20131101075558.GI6252@medion.lan>
 <20131101123610.GR970@neomailbox.net>
 <20131101143305.GO6252@medion.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="U7NLafZe7Bh9OCap"
Content-Disposition: inline
In-Reply-To: <20131101143305.GO6252@medion.lan>
Subject: Re: [B.A.T.M.A.N.] lost connection to a client / Q:
	transglobal-table
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--U7NLafZe7Bh9OCap
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2013 at 03:33:05PM +0100, Bastian Bittorf wrote:
> * Antonio Quartulli <antonio@meshcoding.com> [01.11.2013 13:53]:
> > > here the transglobal-table in the master, my laptop is '00:21:6a:32:7=
c:1c'
> >=20
> > what is master?
>=20
> the node which has internet connectitvity / default gateway.
>=20
> >=20
> > > the interesting thing is, that my laptop seems to be reachable via
> > > *:02:22 and *:00:13 - the 2nd entry has no hash (?), but 'batctl t 00=
:21:6a:32:7c:1c'
> > > outputs *:00:13 as originator. from the topology, it is impossible to=
 be
> > > near this node, so no roaming can happen AND i can see on my laptop,
> > > that there was no roaming. the situation recovers without interaction=
 after some
> > > minutes. the transglobal table does not change, but 'batctl t 00:21:6=
a:32:7c:1c'=20
> > > outputs the correct *:02:22
> > >=20
> >=20
> > Here[1] you have an explanation about the translation table output.
>=20
> thanks, this help: so [.W.] means:
> "this client is connected to the node through a wireless device"

It also explains why you have more than one entry for the same client and w=
hy.

>=20
>       Client        (TTVN)       Originator      (Curr TTVN) (CRC   )   F=
lags
> * 00:21:6a:32:7c:1c  (  4) via 02:00:ca:b1:02:22     (  5)   (0x6456) * [=
=2EW.]
> + 00:21:6a:32:7c:1c  (  5) via 02:00:ca:b1:00:13     (  5)   [.W.]
>=20
> but i can be sure, that may laptop "00:21:6a:32:7c:1c" was never connecte=
d to '02:00:ca:b1:00:13'.
> both nodes are not connected via cable and are nodes in hybrid-mode (ap+a=
dhoc).
> no special tricks, 'only' macvlan. BLA2 is active on all nodes.
>=20
> the again: why does batman-adv think, that the client (my laptop) is/was
> reachable over 02:00:ca:b1:00:13 - the laptop was never there? a hash-col=
lision?

No. This happens when bat0 on one node and bat0 on the other are bridged
together. The common scenario for this is that you have the two nodes conne=
cted
to an Ethernet switch and you have bat0 bridged into this LAN. At this poin=
t the
"two bat0s" will get in touch with each other. Like the first picture in th=
is
page[1].

The "only" macvlan thing is probably something we should try to investigate
further :-)
You are the first reporting strange issues like this and the fact that this
happens quite often means that there is something in the network setup that=
 is
triggering this problem.

Do you mind explaining a bit more in details how you structured the node? (=
which
interface is bridged with what, where macvlan is connected).

Can you also provide the output of "batctl bbt" ?

>=20
> what i also see now:
> a laptop is connected via wifi to NodeA, but i ask the 'transglobal'
> table, batman-adv says it is on another location and 'batctl tr $lapop'
> also works. explaining it:
>=20
> NodeA =3D 192.168.99.1/16   ~~~ Laptop with 192.168.222.51/16
>=20
> (air)
>=20
> NodeB =3D 192.168.222.1/16
>=20
> The Laptop is connected to Node A, but has an IP from Node B.
> batman-adv thinks that the Laptop is on NodeB, but in fact it
> is on NodeA. Why is this? On Node A 'wlan0' is bridged to bat0.
>=20

I guess you roamed from NodeB to NodeA ? Is the entry in the global table
followed by a "R"

Cheers,

[1] http://www.open-mesh.org/projects/batman-adv/wiki/Bridge-loop-avoidance=
-II

--=20
Antonio Quartulli

--U7NLafZe7Bh9OCap
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSc70HAAoJEADl0hg6qKeOWlsP/3a1ntvK1jPqQbZfiZG4Wpi/
Tnm/uXK5JIzPpltOjcPVNHv1JPYlf6qaf+1CBYkMF5MpF6yQmn8mWqs1nrQQJXk+
RSgC/H+IPJkZhuDxAuHZ0OikacnZH+PXBvNLRdh1WxfLcTL6RcID+F2VkIarD/fv
RPng83bS2PAnxUva00vQ9q+9rBkanPA0c0GgDRPVmrGWYXbx3CmJago9sucsxwd7
himS4+m3oymTSbA0jdVpV8ogNDPLPTJVbVzBYtM1lC+bns61TxHQcRt1kBTkj4D7
6ghlWsRk6w9mzQxbvovNNoYoeUuWMsTp3hh6He4la7ZMF7T6iU/eXRQqoWredMTg
NOhPvAgeMErZFXH0vNgkp1Q4lJrGspwOCdLxpjygNlIdoRzdpQBNUu6xLhJNlT30
BK7POo4/czede5aJ9iUXIU25smEr2LdLz3oyTb6vy/Z18+bS/QWqoa5mfyoquXFB
2yumbCerDVCu57L88VYctswL2TcpnmILAr7sp478+EshETvrGKU9sEEGIhd+YDfd
UdnmDKRNbbRO5HP9tB3NPJZT3FhO+8kxmLHySd7rO8mVPfy6t3CHQheDjP5nXaJT
JSWTeVHGhg3OIk8dXEriuKd7KFF36DV9r9obKdskvExPhoZhw3kYvH4TcQXaYa4n
Qg5w9eekuBN0u0xlv8wS
=tQYP
-----END PGP SIGNATURE-----

--U7NLafZe7Bh9OCap--
