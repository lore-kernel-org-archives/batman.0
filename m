Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH maint v3 1/3] batman-adv: mcast: fix duplicate mcast packets in BLA backbone from LAN
Date: Mon, 14 Sep 2020 20:12:01 +0200
Message-ID: <2021746.X5qYlJs30q@sven-edge>
In-Reply-To: <20200914012136.5278-2-linus.luessing@c0d3.blue>
References: <20200914012136.5278-1-linus.luessing@c0d3.blue> <20200914012136.5278-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2073953.michYkKeb4"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>

 
--nextPart2073953.michYkKeb4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Monday, 14 September 2020 03:21:34 CEST Linus L=C3=BCssing wrote:
> Scenario:
> * Multicast frame send from a BLA backbone (multiple nodes with
>   their bat0 bridged together, with BLA enabled)
>=20
> Issue:
> * BLA backbone nodes receive the frame multiple times on bat0
>=20
> For multicast frames received via batman-adv broadcast packets the
> originator of the broadcast packet is checked before decapsulating and
> forwarding the frame to bat0 (batadv_bla_is_backbone_gw()->
> batadv_recv_bcast_packet()). If it came from a node which shares the
> same BLA backbone with us then it is not forwarded to bat0 to avoid a
> loop.
>=20
> When sending a multicast frame in a non-4-address batman-adv unicast
> packet we are currently missing this check - and cannot do so because
> the batman-adv unicast packet has no originator address field.
>=20
> However, we can simply fix this on the sender side by only sending the
> multicast frame via unicasts to interested nodes which do not share the
> same BLA backbone with us. This also nicely avoids some unnecessary
> transmissions on mesh side.
>=20
> Note that no infinite loop was observed, probably because of dropping
> via batadv_interface_tx()->batadv_bla_tx(). However the duplicates still
> utterly confuse switches/bridges, ICMPv6 duplicate address detection and
> neighbor discovery and therefore leads to long delays before being able
> to establish TCP connections, for instance. And it also leads to the Linux
> bridge printing messages like:
> "br-lan: received packet on eth1 with own address as source address ..."
>=20
> Fixes: 405cc1e5a81e ("batman-adv: Modified forwarding behaviour for multi=
cast packets")
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> ---


Sorry, but doesn't build cleanly:

    make[1]: Leaving directory '/home/build_test/build_env/linux-build/linu=
x-5.6'
    /home/build_test/build_env/tmp.3Iw5SQ84oz/net/batman-adv/soft-interface=
=2Ec:367:31: error: undefined identifier 'batadv_mcast_forw_send_orig'
    /home/build_test/build_env/tmp.3Iw5SQ84oz/net/batman-adv/soft-interface=
=2Ec: In function =E2=80=98batadv_interface_tx=E2=80=99:
    /home/build_test/build_env/tmp.3Iw5SQ84oz/net/batman-adv/soft-interface=
=2Ec:367:10: error: implicit declaration of function =E2=80=98batadv_mcast_=
forw_send_orig=E2=80=99; did you mean =E2=80=98batadv_mcast_forw_send=E2=80=
=99?
     [-Werror=3Dimplicit-function-declaration]
        ret =3D batadv_mcast_forw_send_orig(bat_priv, skb, vid,
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
              batadv_mcast_forw_send
    cc1: some warnings being treated as errors
    make[3]: *** [scripts/Makefile.build:268: /home/build_test/build_env/tm=
p.3Iw5SQ84oz/net/batman-adv/soft-interface.o] Error 1
    make[2]: *** [scripts/Makefile.build:505: /home/build_test/build_env/tm=
p.3Iw5SQ84oz/net/batman-adv] Error 2
    make[1]: *** [Makefile:1683: /home/build_test/build_env/tmp.3Iw5SQ84oz]=
 Error 2
    make: *** [Makefile:74: all] Error 2

It was tried to build with:

    /usr/bin/make -C /home/build_test/build_env/linux-build/linux-5.6 M=3D/=
home/build_test/build_env/tmp.3Iw5SQ84oz PWD=3D/home/build_test/build_env/t=
mp.3Iw5SQ84oz REVISION=3D CONFIG_BATMAN_ADV=3Dm CONFIG_BATMAN_ADV_DEBUG=3Dy=
 CONFIG_BATMAN_ADV_DEBUGFS=3Dn CONFIG_BATMAN_ADV_BLA=3Dn CONFIG_BATMAN_ADV_=
DAT=3Dy CONFIG_BATMAN_ADV_NC=3Dy CONFIG_BATMAN_ADV_MCAST=3Dn CONFIG_BATMAN_=
ADV_SYSFS=3Dn CONFIG_BATMAN_ADV_TRACING=3Dn CONFIG_BATMAN_ADV_BATMAN_V=3Dn =
INSTALL_MOD_DIR=3Dupdates/    modules

Kind regards,
	Sven
--nextPart2073953.michYkKeb4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl9fsnEACgkQXYcKB8Em
e0b5gA/+L04wl7zgaT2tXLSVg+KdTmRmEN/8r3sMVRmbiWJUiyjfNdfA07JOaQlp
tV5ktKS3+DV3MN2YEcpph30MlJewVFg5ovbBAZi9d703nFLiTtgwq152mc2zy03Q
8kcOw+p21Vw+CAm3ZY1Hf+rFDJc75p15uN82A3Bs69af4UD9eUOnpChCCyWB5EcD
1GvACXoCiCGVUjkyCPqr4bSxmEBQn+4QijbCSiO4sqeRq26in5TAOjJSdPowkhh3
YylVODexa8F87cdfZgz4o/bPAJeDNlESmYVEm03V7INn4oEfCbb3SdMc3qaye0IF
wyPY0KWOmlsXv8Um/+Eela/FrSN9M140BO1lV3WFZa5kLcNmT+OB5ttnwLTDEC2l
lksbcdptkaJlpVZLsX/Wqu5eSnmnR/D8d17eCRw9TSVp1PT2skfVfUsmCjbIS5zU
aebI5L/zw7HY45mcW4ZC2hI4SLc+ACpRZG7IqxmwaJuZDvoIBE2xWhzRu65IgcYE
Qs5nnj10CsDSLL5f7XQ0IvWWm2+WmlrFpbGE/vtWciaFO7jrzcuqoA1z7djmAnnl
Xb7lmFzCmaTIp6Uyx3KwZh6+TZj0NOsu4GezQJ8mqlseJHion7rd6C97edz4YKzt
hzDWHq8ZsIyumHc2RfJR569aZiErKv8RbOU4A/19QeSoxpJKjMo=
=5Ra/
-----END PGP SIGNATURE-----

--nextPart2073953.michYkKeb4--


