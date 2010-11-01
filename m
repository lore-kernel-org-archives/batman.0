Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 1 Nov 2010 12:34:56 +0100
References: <1288450858-14753-1-git-send-email-sven.eckelmann@gmx.de>
	<1288450858-14753-3-git-send-email-sven.eckelmann@gmx.de>
	<201011011226.21697.lindner_marek@yahoo.de>
In-Reply-To: <201011011226.21697.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1291762.8uhzWkv65t";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201011011234.57230.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/6] batctl: Remove unused variables
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart1291762.8uhzWkv65t
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> On Saturday 30 October 2010 17:00:55 Sven Eckelmann wrote:
> > -static void dump_arp(unsigned char *packet_buff, ssize_t buff_len, int
> > time_printed) +static void dump_arp(unsigned char *packet_buff, ssize_t
> > buff_len) {
> >=20
> >         struct ether_arp *arphdr;
> >        =20
> >         LEN_CHECK((size_t)buff_len, sizeof(struct ether_arp), "ARP");
> >=20
> > -       if (!time_printed)
> > -               time_printed =3D print_time();
> > -
> >=20
> >         arphdr =3D (struct ether_arp *)packet_buff;
> >        =20
> >         switch (ntohs(arphdr->arp_op)) {
> >=20
> > @@ -111,7 +108,7 @@ static void dump_arp(unsigned char *packet_buff,
> > ssize_t buff_len, int time_prin }
> >=20
> >  }
>=20
> I don't understand why you want to remove the time_printed stuff. Maybe it
> is not so clear what this is good for ? At the beginning of each line
> batctl tcpdump prints a timestamp by caling print_time(). The various
> functions to analyze the headers (e.g. ARP) can be called under different
> conditions: Either after the encapsulating batman-adv header had been
> printed (including the timestamp) or without any prior prints in which
> case we want to output the timestamp.

It is not used anywhere in the functions - so why keep it?

Best regards,
	Sven

--nextPart1291762.8uhzWkv65t
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJMzqXgAAoJEF2HCgfBJntGF2IQAIcDChFRCWyWG05I9VqkCebN
I1lcxfYnS1Mi7URoAxv+blskdnJjxoaU9xbO2Kl5ivVnqB/ifLA6B4f+8es0n8Mu
bUXgqr3P/u6VD02k8rIKszvH8OmZlZ3/zb7+kLOqQ3MrgEt7kzJhhUianJ6Kcy+z
ey120fI6+5vB6Uf/Gz4s/NRiLvCxLkOtuGojwsuuUdFzwoLIKvUwfb7enKZ/GCPx
HWR6+L/3UgsM1eWVhd/0NAcQxKwwtAbWG7XUMqhVPEDuNYhQxX1EUMAfcX6pzZy+
Rl/oLfCPOMsdZNeBse224aMZZuRKaF7SzaIcWsRN4vuHVNW1FPkHkQiOlu0MCkwA
WUk/S5UNsjpuIkZWCCCnGxZ7HBxNgfiAOyZCJHKWg7ewcsssvI6ZogdAAJ3AwpZE
oSzhFQQb/Rx08bCb/m5XIpObNd9UGIoYHLngRpNq4Fww9BslbF1QJpKY58AOM2eF
YDsjkeMr0vV0dEKW9J5hbONQ78igEaF10oPX5Iw4Rv/D/WbjZhj2c9Z9jv0gxb/e
r/FvB+Mhno5sH527d/f0c1dxvqhd3dtb1FOfDL9r7i4zOIv5nqmDAtDzfB3zM8fr
LQTs5OBVrdr/+fJaeUY14DK7LFOZv1zSC2KAAbYSATUrKKRKE+GkDtEd/5GpAZGX
zuqWpYntJrw7EpUZrcOe
=1FIk
-----END PGP SIGNATURE-----

--nextPart1291762.8uhzWkv65t--
