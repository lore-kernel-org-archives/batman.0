Return-Path: <jj.sarton@t-online.de>
References: <32cfb197-7944-7b9c-0d1c-6f6267d355de@t-online.de>
 <2562442.4W30obIVjL@lafayette>
From: Jean-Jacques Sarton <jj.sarton@t-online.de>
Message-ID: <0b99a1f3-aa99-eb62-46cf-f959011a05e6@t-online.de>
Date: Sat, 5 Nov 2016 22:29:19 +0100
MIME-Version: 1.0
In-Reply-To: <2562442.4W30obIVjL@lafayette>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mBgkofEiIULJFejoNrjfFsBW5FdVok2QB"
Subject: Re: [B.A.T.M.A.N.] Batman an more than one Gateway
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mBgkofEiIULJFejoNrjfFsBW5FdVok2QB
Content-Type: multipart/mixed; boundary="DLfoXvXMC99uBclhIWSVrOSnTDlV14OSB";
 protected-headers="v1"
From: Jean-Jacques Sarton <jj.sarton@t-online.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <0b99a1f3-aa99-eb62-46cf-f959011a05e6@t-online.de>
Subject: Re: [B.A.T.M.A.N.] Batman an more than one Gateway
References: <32cfb197-7944-7b9c-0d1c-6f6267d355de@t-online.de>
 <2562442.4W30obIVjL@lafayette>
In-Reply-To: <2562442.4W30obIVjL@lafayette>

--DLfoXvXMC99uBclhIWSVrOSnTDlV14OSB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Marek,


Am 05.11.2016 um 04:14 schrieb Marek Lindner:
> Hi,
>=20
>> I have take a look to the configuration of our gateways.
>> Inho there are some points which are not OK,
>> Broadcasts are rebroadecasted on a wired connection,
>=20
> please note that batman's payload reboradcast behavior is unrelated to =
the=20
> batman gateway feature. The effect of the batman gateway feature is exp=
lained=20
> here: https://www.open-mesh.org/projects/batman-adv/wiki/Gateways
>=20
This seem to work but for IPv6 there is nothing and the client get
RA's from all GW.

> Rebroadcast on an interface depends on the interface type. Generally, b=
atman=20
> runs on 3 different types of interfaces:
>=20
>  * WiFi: payload broadcasts are transmitted 3 times to increase the cha=
nces of=20
> a successful transmission
This wjat not the case, no WIFI connection or neighbors
>  * VPN / wired Ethernet: payload broadcast is transmitted once as most =
sane=20
> VPNs don't experience packet loss

This what the interface type used. This mean that the gateway send
a broadcast via wire and the node get it as if there where no VPN between=

GW and node. rebroadcasting is not OK here.

> Guessing from your interface names you are running VPNs and not wired=20
> Ethernet, is that correct ?
see above

>> this seem for me to be an issue.
>=20
> What exactly is the issue ?=20

A good question. If all node act in the same maner we will get
a lot of traffic which must be received ny the gateway.
>=20
>>       Gateway      (#/255)           Nexthop [outgoingIF]: advertised =
uplink
>> bandwidth ... [B.A.T.M.A.N. adv 2014.3.0, MainIF/MAC:
>> ftun-q1/12:e8:ef:7f:0d:c8 (bat0)] ca:b1:f2:63:f3:cf (251) ca:b1:f2:63:=
f3:cf
>> [   ftun-q1]: 50.0/50.0 MBit
>>
>> [B.A.T.M.A.N. adv 2016.4, MainIF/MAC: mesh0/92:fb:53:11:44:f1
>> (bat0/90:f6:52:11:44:f1 BATMAN_IV)] IF             Neighbor           =
 =20
>> last-seen
>>      mesh-vpn	  aa:ff:ca:ca:fe:03    3.342s
>=20
> It is recommended to run the same batman version on all nodes to avoid =

> unexpected behavior. These 2 versions are separated by 2 years of devel=
opment.

I agree the version on the GW and the node shall be the same.
On the other hand the older version and the version I used use the
same protocol so that I expect not problem.

I have made check with a Freifunk router and on the same time with
my network space router.
All router used what connected to the same GW. I have seen
rebroadcast on both router attached to the PC which what
configured as router for 2 different subnets.
On the Freifunk router there what less rebroadcasting.
The command batctl gwl shown an othter preferred gateway. This
may explain the differences in the number of rebroadcasting.

On a Gluon Freifunk node conneted to Q1:

# batctl gwl
      Gateway      (#/255)           Nexthop [outgoingIF]: advertised upl=
ink bandwidth ... [B.A.T.M.A.N. adv 2015.1, MainIF/MAC: mesh-vpn/16:d0:20=
:41:5a:72 (bat0)]
   12:e8:ef:7f:0d:c8 (238) aa:ff:ca:ca:fe:01 [  mesh-vpn]: 50.0/50.0 MBit=

=3D> ca:b1:f2:63:f3:cf (255) aa:ff:ca:ca:fe:01 [  mesh-vpn]: 50.0/50.0 MB=
it

Translated Interface/Location
   ftun-q1/Q0        (238) mesh-vpn/Q1       [  mesh-vpn]: 50.0/50.0 MBit=

=3D> ftun-q0/Q1        (255) mesh-vpn/Q1       [  mesh-vpn]: 50.0/50.0 MB=
it

I know the batman version on the FFF router is not so old as
the GW version.

Cheer,

Jean-Jacques


--DLfoXvXMC99uBclhIWSVrOSnTDlV14OSB--

--mBgkofEiIULJFejoNrjfFsBW5FdVok2QB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF0EARECAB0FAlgeTy8WHGpqLnNhcnRvbkB0LW9ubGluZS5kZQAKCRAz0luJHcLB
C4mcAJ93sZxwfskHnvfcN81k80PSnsvFAwCfYxW20XVJTrkgFx1lWUECr9HQCGA=
=7NY8
-----END PGP SIGNATURE-----

--mBgkofEiIULJFejoNrjfFsBW5FdVok2QB--
