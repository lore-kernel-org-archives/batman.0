Return-Path: <antonio@meshcoding.com>
Message-ID: <550A683F.30001@meshcoding.com>
Date: Thu, 19 Mar 2015 07:10:07 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <OFC7CC1C02.68EA7DC9-ONC1257E07.00275710-C1257E07.002916EB@phoenixcontact.com>
 <5502CF6D.3030408@meshcoding.com>
 <OFF07BA093.8D744C20-ONC1257E07.004BE977-C1257E07.00503089@phoenixcontact.com>
 <OF67DD2D01.84CED6E1-ONC1257E0C.0039329E-C1257E0C.003B181B@phoenixcontact.com>
In-Reply-To: <OF67DD2D01.84CED6E1-ONC1257E0C.0039329E-C1257E0C.003B181B@phoenixcontact.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8MvD10SqwMGAWi4BvmB7ws5FUoJ1TBQic"
Subject: Re: [B.A.T.M.A.N.] DAT broken in 2014.4.0?
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8MvD10SqwMGAWi4BvmB7ws5FUoJ1TBQic
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 18/03/15 11:45, Andreas Pape wrote:
> In the meantime I digged a little deeper into this. DAT as such works b=
ut=20
> has some side effects on the backbone network in a setup like mine with=
=20
> several mesh nodes connected to the same backbone network and bla enabl=
ed.=20
> I see two main issues:
>=20
> 1. The original broadcast ARP request sent by the PC is looping back in=
to=20
> the backbone network. As far as I have figured out this comes from the =

> encapsulation of the original ARP broadcast into a BATADV_UNICAST_4ADDR=
=20
> frame, which is not handled by the bla code responsible for preventing =

> looping broadcasts as for bla this is a unicast frame.

Good point.

> 2. All ARP replies are forwarded into the backbone by all possible=20
> gateways. If a gateway gets responses of up to 3 remote dat candidates,=
=20
> the total number of seen arp replies becomes 3 times the number of=20
> gateways used.
>=20

This is probably a consequence of point 1, right ?

> I am not sure, if this is specific to the old kernel version I used, bu=
t I=20
> tried to overcome the two mentioned points with the following measures:=

> 1. drop BATADV_UNICAST_4ADDR DHT_GET frames received from another gatew=
ay=20
> as long as we cannot answer the forwarded arp request.
> 2. make sure, that only a gateway which has claimed the src mac of an a=
rp=20
> reply forwards this reply to the backbone network
> 3. drop received arp replies as soon as we have a local dat entry for t=
he=20
> src mac of the arp reply. In this case it is most likely that the devic=
e=20
> has already sent a reply.
>=20
> With these measures I see a "clean" arp request / reply behaviour in th=
e=20
> backbone network. As a further improvement I added the snooping of all =

> incoming IP traffic on the mesh soft interface. I use the src mac and s=
rc=20
> IP to update the local dat cache. I wanted to achieve as low arp=20
> request/reply and connected broadcast traffic in the mesh as possible.
>=20
> If there is interest I could send a patch file to the mailing list with=
=20
> the changes based on the batman-adv git master. But I warn you in front=
: I=20
> am not a very skilled kernel programmer nor do I have any experience in=
=20
> using git ;-)=20

I am not I understand 100% your proposed solution, but a patch is worth
thousand words :)
Please do send it..and don't worry about your skill, everybody has to sta=
rt!

Regards,

--=20
Antonio Quartulli


--8MvD10SqwMGAWi4BvmB7ws5FUoJ1TBQic
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVCmhDAAoJEJgn97Bh2u9etikP/0qEgX3gEBj5Wf/Y+oo7RlZ3
9gxWGBpQx1akFWM0eWUQzU6ymaB7mulH+BhnlxwyAVz5/GyiPFaEMucJmatdIa+m
H/LFqtCph46k89itJg2iLXLW9bA0dm5/kisVsU4LvHO020e44N1fXvDHWLsAyPBJ
lpbyheWBNm3Zhi8P8TUzDW0JWs+tdleO1T34Cmw+E7cAeNb8B28Y2WWXejlm0FUP
v/vs8BvfDpfe92jCjME26mSS7l/hEeizSaDzTCd4E0r3Q+h892oTXulZ2hPZediN
kx6J3ZP9HVQA287oD+K4vKeUy0z87swQZg5Kvb7J+Svd200Cad36xG72vxcyop9E
dn5oRhnNYus9/GR3ozCZT2s3nGl0qWaEzLxT5KZRvLbFpqBTZ6nAr35rxkx/Rl8+
hzADSXASCSOUAcX9CQn0cvTmlORjwuHnCUbb3A3lFbjKey3j8x2tGUYkr1KZ0O6b
C+4DjyQzxLzSWJFlsUJAztUiMkhi3RicCJ00uDIWpzGtJpHdDFqjQObkiC6be2hZ
kA1yqIW3nGhs59q76Txa9FgCSouCWT1yKg0o+HsOp1qBmRvaJDXZd2qHmwLXSbju
ScUnOHmfJ51NbpZDdQqMcKL3eiCXF6XbdLVoCaoDvS5th+IdDzlDlivAQi5MqRzD
zaTyLCucIvkUSgNfg6h3
=o9kn
-----END PGP SIGNATURE-----

--8MvD10SqwMGAWi4BvmB7ws5FUoJ1TBQic--
