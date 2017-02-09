Return-Path: <a@unstable.cc>
Date: Thu, 9 Feb 2017 15:44:17 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20170209074417.GG11922@prodigo.lan>
References: <CAA_JP8VHB3amFyjwfTtJdc-2E1DgDU5q4NdmVJ6HGVL5g97cZg@mail.gmail.com>
 <1505249.1X2o3mks0n@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vSsTm1kUtxIHoa7M"
Content-Disposition: inline
In-Reply-To: <1505249.1X2o3mks0n@bentobox>
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--vSsTm1kUtxIHoa7M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 08:33:13AM +0100, Sven Eckelmann wrote:
> On Mittwoch, 8. Februar 2017 16:40:38 CET dan wrote:
> > Assuming MTU is great enough (1528 right? 1500+24 batman-adv+4 VLAN),
> > can the bat0 interface act as trunk for VLANs?
> >=20
> > 2 Nodes:
> > bat0:
> > eth1
> >=20
> > bridge0:
> > eth0|bat0
> >=20
> >=20
> >=20
> > device connected to node1-eth0 tags vlan20, does that traverse the
> > bat0 mesh and come out node2-eth0 with tag in-tact?  Does it traverse
> > node1-eth0 at all?
>=20
> Afaik, the VLANs not on configured on batX will be rejected since TT was =
made
> VLAN aware [1]. I think Simon and Antonio can clarify this.

I agree with Sven. The Translation Table (TT) component should complain by
printing the message that you can see in the link.

This happens because TT needs to know about all the VLANs in order to learn=
 the
MAC addresses of the clients.

However, TT gets to know a new VLAN only when this is actually created (i.e=
=2E by
creating bat0.X).


The solution would be to create a VLAN on top of bat0 (i.e. bat0.20) and le=
t the
tagging happen at the node.

Cheers,



--=20
Antonio Quartulli

--vSsTm1kUtxIHoa7M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYnB3OAAoJEJ6F1zG2JyOsxA0P/1rKiJPrLy3ItKWsiX6+EFdn
CAXqcC+gBapFBtxbxhbKppnkIgEEVes7Kw0c3agzI0s2Jht/NlWJim1RKBbl6I/+
a2NXvrqEvftYil/xFw065mXK1yLAiHBc4OcE6jdPXevUVGRaMlgQHAITEjoqprAa
s/JU54RL9lOV2bim/fjSFSbcTYWcoq8onJVS5OxRR8ffgV0vwbiFGP+p91KfhxYr
LB7j3UFMUi3gJ8ZL96cleF37PdbxpredxqNcK8AvOZbrVjAu41K1gfGbCObZlDyO
0aIjoz5POL7cS32vA39Z6MnUl4xpPAK+RPnUSr0ol6ICSC9Ifrbs49mfpDd0V13H
/QS1NhUcxmMaMVYkaqYtrFdfW4JWpHhpDRn4NZgDRIW4JmpX5TXmnUTlq8i3eK3g
umbAG5lgke8Bq3KVSzHaaQYP4UVXmjt/+7PpvilsvA/9mSstQcY58mp5bjuSvBGJ
q+FNMoolPWVdVTpyflNC3E1D50+rgXTbxeTHEhyJqdo+oktkuATjNBbt2suqmTTi
kEajFaweZGR/GDlP3gmS2981H2kmZCGcmsJmDxhOiGadn53kJ8cAJlPB1TwUpnBY
+2TRjVJgITQzeDa5phujklPJ04QkAysjVHuwjxHZVAwm+oz9W83Bh8uavRJHiMdR
8w1Lr1D+OckmOkIU7DYz
=dMTm
-----END PGP SIGNATURE-----

--vSsTm1kUtxIHoa7M--
