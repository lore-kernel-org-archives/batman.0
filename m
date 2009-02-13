Date: Fri, 13 Feb 2009 15:18:46 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20090213141846.GA17394@pandem0nium>
References: <2ced936d0902121842k7ff76dc8o7c7d303a685a78bd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <2ced936d0902121842k7ff76dc8o7c7d303a685a78bd@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N L2 over a Bluetooth PAN
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Breno,

as far as i know, for 802.11 the SNAP protocol is used to encapsulate
the complete Ethernet Frame [1]. This means that the Ethernet header is
completly preserved and can be decapsulated on the receiver side.
The BNEP protocol on the other hand seems to cut off the Ethernet header
instead of encapsalutating it when i understand the specification=20
correctly [2, page 13]. However the examples [2, page 15 and page 41]=20
suggest that the Ethernet Header is encapsulated completly within BNEP.

For batman-adv a correct Ethernet Header, especially correct MAC Addresses=
=20
to identify the peers and support for our specific Ethernet Type is=20
needed. If these fields are not (re-)generated correctly, it won't work.

So the question is: is BNEP even transporting arbitrary frames with
Ethertypes other than IP (0x0800)? Maybe there are some filters
preventing the BATMAN frames (type 0x4305) to be transported=20
[2, page 42]?

I guess a good starting point would be to use some bluetooth dump tools
or tcpdump, inject packets and see if they are received on the peer
site. Maybe just some filter is preventing batman-adv from operation. :)

best regards,
	Simon


[1] http://osnet.inm.nchu.edu.tw/powpoint/seminar/802.11/802.11MAC.pdf (sli=
de 28)
[2] http://grouper.ieee.org/groups/802/15/Bluetooth/BNEP.pdf

On Thu, Feb 12, 2009 at 11:42:44PM -0300, Breno Jacinto wrote:
> Hello,
>=20
>     I'm experimenting on heterogeneous ad hoc networks, which today
> are still very restricted in terms of hardware availability for
> off-the-shelf devices. Actually, the two most common technologies
> available today are 802.11 and Bluetooth, being this last one able to
> form simple personal area networks in the form of piconets.
>=20
>      In practical terms, the BlueZ stack of the Linux allows the
> formation of Bluetooth PANs consisting of up to 8 nodes, but it's an
> incredibly difficult process - actually, the piconet master needs to
> bridge connections so that all other devices in the network, which
> depend on this master, are able to reach it other directly - or at
> least feel like they are doing that. In fact, everything is just an
> emulation, since Bluetooth is a connection-oriented technology.
>=20
>      BNEP (Bluetooth Network Encapsulation Protocol) is the piece
> responsible for emulating an Ethernet network over Bluetooth, and
> theoretically any IP and above protocols can be used. Trying with
> simple IP broadcasts over a Bluetooth network shows that it works, but
> the problem comes when I try to do "straight" layer 2 broadcasts (not
> coming from the IP layer), such as the ones that BATMAN L2 does.
>=20
>     I tried to run BATMAN and add the interfaces used on each device -
> pan0 for the master, which is a bridge device, and bnep0 for the
> slave, but the frame dont seem to reach any destination on the
> network. The originators table remains empty on both sides of the
> connection. Running Wireshark shows the frame being generated, but
> never reaching anyone.
>=20
>     So, I still cannot figure out why this is happening. I'd like to
> know if anyone has adventured in doing something similar and
> succeeded.
>=20
>=20
> best regards,
>=20
> --=20
> --=20
> :: Breno Jacinto ::
> :: breno - at - gprt.ufpe.br ::
> :: FingerPrint ::
>    2F15 8A61 F566 E442 8581
>    E3C0 EFF4 E202 74B7 7484
> :: Persistir no dif=C3=ADcil =C3=A9 a =C3=BAnica maneira de torn=C3=A1-lo=
 f=C3=A1cil algum dia.  ::
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJlYFGrzg/fFk7axYRAmIEAJwN2joajajVtRo2bw8vv5x3EImdbwCg21WU
iyolzJNbEPn7tMKMutqVaQc=
=Sq9K
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
