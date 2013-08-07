Return-Path: <ordex@autistici.org>
Date: Wed, 7 Aug 2013 14:05:27 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130807120527.GL2943@ritirata.org>
References: <52020C25.9080705@gmail.com> <20130807090941.GK2943@ritirata.org>
 <52022858.3030105@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UnaWdueM1EBWVRzC"
Content-Disposition: inline
In-Reply-To: <52022858.3030105@gmail.com>
Subject: Re: [B.A.T.M.A.N.] DAT issue
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


--UnaWdueM1EBWVRzC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2013 at 12:58:32PM +0200, Fernando Pizarro wrote:
> El 07/08/13 11:09, Antonio Quartulli escribi=C3=B3:
> > On Wed, Aug 07, 2013 at 10:58:13AM +0200, Fernando Pizarro wrote:
> >> Hi all!
> >>
> >> I'm playing with OpenWRT and BATMAN advance and I had configured one
> >> essid to serve dynamic vlans via freeradius reply attributes.
> >>
> >> I have a bridge (br0) with bat0, wireless and ethernet interface, and
> >> hostapd creates a new bridge by vlan (brvlanX) with vlanX and wlan1.X
> >> succefully. Br0 has configured a VLAN and IP to connect with every oth=
er
> >> nodes. There is the same explanation, but schematic:
> >>
> >> Wireless:
> >>
> >> phy0 -> wlan0 -> bat0
> >> phy1 -> wlan1 -> wlan1.1
> >>                        \ --> wlan1.N
> >>
> >> Hostapd bridge:
> >>
> >> wlan1 -> brvlan1 -> {wlan1.1; vlan1}
> >>         \ --> brvlanN -> {wlan1.N; vlanN}
> >>
> >> Ethernet bridge:
> >>
> >> br0 -> {bat0; eth0; wlan1}
> >>      \ --> br0.X =3D=3D IP/NETMASK
> >>
> >> When I look at batman dat table there aren't any registry, but variuos
> >> stations are connected. Why is that? What's wrong in my config?
> >
> > Hello Fernando,
> >
> > I have to say that your setup is not the easiest I've ever seen :)
> > However, the initial version of DAT was not made to work with VLANs, bu=
t I'm not
> > entirely sure if this should lead to an empty table.
> >
> > First of all, where are all your clients connected? to wlan1?
> > Why did you put wlan1 into br0 and not wlan1.X?
> > When your clients are doing traffic, can you see ARP Req/Resp on wlan1 =
(which is
> > the interface in br0 that will inject then the data into bat0)?
> >
> > Cheers,
> >
> Hi Antonio, thanks for your answer.
>=20
> I explain a bit more my stage... I have a server with DHCP that is the=20
> default gateway of all BATMAN nodes and clients, and BATMAN gateways are=
=20
> connected to it fisically. For roamming, I won't have IPs of VLANs in=20
> BATMAN nodes and all default gateways of VLANs are configured in the FW.
>

if I understood correctly you have many nodes all connected with a cable to=
 the
same GW? so all the nodes are in the same LAN?

> Clients connects to wlan1.X, but that interface is created by hostapd=20
> when radius allows access to the network of that client (default dynamic=
=20
> vlan behaviour). As hostapd creates this interface on demand and=20
> destroys it when is killed, I can't add wlan1.X to the bridge (br0).=20
> However, there is arp traffic on wlan1.
>=20

I guess the traffic you see on wlan1 is VLAN traffic which is going to be
delivered to any of your wlan1.x.

I have the feeling in this way none of the client is really bridged into
batman-adv because you bridged wlan1 but the clients are connected to wlan1=
=2Ex.
can you please report what "batctl tl" is saying?

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--UnaWdueM1EBWVRzC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSAjgHAAoJEADl0hg6qKeOcmIP/AoZcKI9YuaJzgb7KwdHLcQq
OeyWdT2ErLfucTdlHc++7GmYNmBlpCzKFGdsbKTSyeERwqIAsw55Ytb0TSNBb3Dc
NbB597vfIT6tKFxcuuTeWYjU3pcUUdh2z8JQHO9yvpLLwBATNXmDmYvYoIMV5Mm8
SFxAAq8pX9+nW3btJQJa5UYrMaFQIvjfvqTsbQRLFNfjfBTdIDqaNzyUhh4Hz0g7
SB2X8CwFcNWYHSDKl5f04clPVXwDuj6wRtdSenANwYKV/4yp6/hpi3zt2NgSFFVu
193RFZx1HVeZvEL34qBM/GoKZUFIOIllPqybtX+A24lpv0MVSFPqxKQuAA3dj1xo
5LzPIso19TteVVKHZ6usVKPUWJLuQ0I1F2ZFG/XaEMXTaa40U/BxSXcRswgIyAlB
y/iKSGBxMOxdpdzHZduDSFX7giSEa1qeTCbbyUe2HrqsEu0sECpwaP0hj1G9yKMM
OgVllZwILLWoc1dUd4aqg9MM3+GzGg+vKlh8s3mdDwH0dovLIIMXXuSVFk9btuRP
LYZvLv1Ocsz0qss0DZvRVYuoKQBY3JPb2VLxllL2NEfmG89lo7RffDTBf98aGOhZ
lWyrr4V4ZzOsm2JujomWHwhD1pdrJNoFYf2WWpGUekiyCoodxZJ9ULH/Ta+FhJ+A
ZE4nsJPJPF9vUzlxFDyw
=I+SV
-----END PGP SIGNATURE-----

--UnaWdueM1EBWVRzC--
