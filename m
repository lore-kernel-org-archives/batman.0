Return-Path: <antonio@meshcoding.com>
Message-ID: <531F061A.2030401@meshcoding.com>
Date: Tue, 11 Mar 2014 13:48:26 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <CAOyZXpRP_3vJ0SiHP40BreTaqOzkS9tsp-zVWBjThdzpFJxiPQ@mail.gmail.com>
In-Reply-To: <CAOyZXpRP_3vJ0SiHP40BreTaqOzkS9tsp-zVWBjThdzpFJxiPQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wh10oaReoS5GLekpN4weO6fsOxjsWA7El"
Subject: Re: [B.A.T.M.A.N.] [B.A.T.M.A.N.A.D.V] Deploy batman-adv using
 Station - Access Point mode?
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
To: trandatnh@gmail.com
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wh10oaReoS5GLekpN4weO6fsOxjsWA7El
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 11/03/14 09:06, Le Tran Dat wrote:
> For example: What I am trying to do right now is to connect those
> devices by using Station <-> Access Point mode. But I have no ideas
> how the OGM message transmit between the Mesh Node so I worry that the
> Station <-> Access Point can not take advance of batman-adv.
>=20

What you have to keep in mind is that everytime if a generic node A
receives an OGM where the Ethernet MAC address is the same as the
originator address then A thinks that there is a direct link between
itself and the source (simplistic explanation).

Therefore, to prevent the nodes from making wrong assumptions, you have
to enable the isolation on the Access Point.

If you don't do so then you can end up in the following situation:
1) STA1 sends an OGM as broadcast packet
2) the AP rebroadcasts such packet as per 802.11 standard (to ensure
that all the associated STAs can receive it)
3) a generic STA2 receives the OGM and erroneously thinks to be directly
connected to STA1, while this is not true because the packets must
travel through the AP[1].

However, even if the isolation makes batman-adv work reasonably you will
not have a nice setup because you cannot exploit direct links between
nodes that may hear each other due to the AP-STA constraint.

Moreover you need to decide which node has to act as AP and which as STA
before deploying them, thus limiting the "dynamic part" of the mesh netwo=
rk.


I hope this clarified the problem.


Cheers,


[1] you could have direct links if you are use TDLS, but most of the
drivers out there do not implement it.

--=20
Antonio Quartulli


--wh10oaReoS5GLekpN4weO6fsOxjsWA7El
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTHwYiAAoJEEKTMo6mOh1V2xAP/3gyMMOM5XDzrx9aCic0SlEM
qhRNESXufsn7/2PEEMTfMMnpL45fXeqWWbuPXt8jHwEUDKHfLKZPkXRm/3YQ+8cS
rqS6qfnW6PuCtEf8sdGs/XHWLagDrZ71zuw+rtFQHYYD6k3edy7SeEDQjFixvEPl
F10y/gymSCsEKH5WraBhjOAYNxdE1VOEZiBllmqeDZTSShKCJHqxW4i0ap8rg9w2
yH5vHEDXsPFYN7aWcVMeS2sqKBTrtAglFuFWeXPA7lwBsrDFpAJ7wFvRT6NpbHNF
F/MEIh4nqnoLyHxmr7WuZDqRoweIZ44vxTUUc1uI2FWOXgkfjcyC1z0JO9xNV22d
+2glL251uQzxjm0y/JkwwWOtySy5xoVOLvAkPKwWYu5GSaYOzVLJ4D2aBmzkfuRa
NxB85HgSUO2XG09/++j+2Y2Dt5B1POABecEixVU7ngDVrE9J/8MdtzUDcBUDuINU
685kANDMZlXQM8En5FEVj2PTVTCG48jf2PTD0/1JBE4RFGbPf2SfCmN/yrorHtzb
Z8znEqPpzEJPkcJqvVtbPpEIBXzbzlfe3xGOhEr8ABXEROLaQMNgbvdgmIeXXtM4
B+X876Kw4a04L0QRTW2d27c37SkeuSu6EJO+WN4wkygemic19hfI2/6too+5dRP6
4u5Y0rXIXxK3FSpdG+jW
=eiXd
-----END PGP SIGNATURE-----

--wh10oaReoS5GLekpN4weO6fsOxjsWA7El--
