Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 09 Feb 2017 10:38:30 +0100
Message-ID: <3144822.pnbq1OJLDA@prime>
In-Reply-To: <20170209074417.GG11922@prodigo.lan>
References: <CAA_JP8VHB3amFyjwfTtJdc-2E1DgDU5q4NdmVJ6HGVL5g97cZg@mail.gmail.com>
 <1505249.1X2o3mks0n@bentobox> <20170209074417.GG11922@prodigo.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6222057.Q2OYxxpaCI";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] bat0 trunk vlans?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart6222057.Q2OYxxpaCI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, February 9, 2017 3:44:17 PM CET Antonio Quartulli wrote:
> On Thu, Feb 09, 2017 at 08:33:13AM +0100, Sven Eckelmann wrote:
> > On Mittwoch, 8. Februar 2017 16:40:38 CET dan wrote:
> > > Assuming MTU is great enough (1528 right? 1500+24 batman-adv+4 VLAN),
> > > can the bat0 interface act as trunk for VLANs?
> > > 
> > > 2 Nodes:
> > > bat0:
> > > eth1
> > > 
> > > bridge0:
> > > eth0|bat0
> > > 
> > > 
> > > 
> > > device connected to node1-eth0 tags vlan20, does that traverse the
> > > bat0 mesh and come out node2-eth0 with tag in-tact?  Does it traverse
> > > node1-eth0 at all?
> > 
> > Afaik, the VLANs not on configured on batX will be rejected since TT was
> > made VLAN aware [1]. I think Simon and Antonio can clarify this.
> 
> I agree with Sven. The Translation Table (TT) component should complain by
> printing the message that you can see in the link.
> 
> This happens because TT needs to know about all the VLANs in order to learn
> the MAC addresses of the clients.
> 
> However, TT gets to know a new VLAN only when this is actually created (i.e.
> by creating bat0.X).
> 
> 
> The solution would be to create a VLAN on top of bat0 (i.e. bat0.20) and let
> the tagging happen at the node.

To be a bit more precise, do something like this on each node:

vconfig add bat0 20
vconfig add eth0 20
brctl addbr bridge-vlan20
brctl addif bat0.20
brctl addif eth0.20

repeat those steps for other VLANs you want to use.

We are aware that this is not "proper trunking" - I would think it would be 
better to let batman-adv automatically detect and handle VLANs in the TT code. 
But this isn't done currently, so you need to cope with this workaround.

Cheers,
     Simon

--nextPart6222057.Q2OYxxpaCI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlicOJcACgkQoSvjmEKS
nqFokBAAuwk9ZdUvlRdNqI1JzWB4/iDTxovzv+NOmEGPDaFD/D/eEMygnMFstV4Q
aj/bWZyXAUveYLrYClTndGoSStPLZRsM3/Ctxtv9j/z2Dfj2LalYWsLgxRezZD2u
mYqD+W2O4CRGToCk7qZWzkpjL4vrqt7g5szuFuCZgleajsN4m9hF/YLOiZv7CBhd
FhwEQ8bW6O6w0gSAljpqzDl8pkxmo6Y887aNDPno86Mfd2dk5dzaOj3PgBRnKwdA
RvYuTANF5MRdm/0N+af4pijRlCIYd2VFyAtBhmtQE8waRFAbiFOie48kColFm6U9
MZchg94aE8ajvV7ay4wcHuT1f3x2LvysK2YI1ia/pEU/TGONhFXUS3mNY7orzjgF
j7tHaZjSBsrMiWneZO7PBA13IhSl+NVXGpM+hTK+ZmAw9RiZ+6oY7emLfOKdH1zh
Jhva6npvAC74ERZuj5rCQT3idwKNckhozH7Mt+ONaIWjJkzwwnfXxc9xXHaU9qX/
xxuD5b/w26fJ4LclqFBOAU0U6YSubD+LIEsl2ZzRe7W1SeBJOlUxpHw4EokRTwNN
1/GEfWEHH5LpxVbbjLLsxsVestgnnio4QXjrVV/w/zwtTMplHpG03CcKZNCAkXdN
5ChqjqzPFHJ4+Es9jmVS6nE2wCsnTxJEerbqm6G0WnURoL0SeQw=
=95Kk
-----END PGP SIGNATURE-----

--nextPart6222057.Q2OYxxpaCI--

