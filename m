Return-Path: <antonio@meshcoding.com>
Message-ID: <52FE6BEE.1070902@meshcoding.com>
Date: Fri, 14 Feb 2014 20:18:06 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-19-git-send-email-antonio@meshcoding.com>
 <20140213105249.GH7193@lunn.ch> <52FCA639.9080204@meshcoding.com>
 <20140213114449.GI7193@lunn.ch> <52FDD2CB.70104@meshcoding.com>
 <20140214173841.GH17451@lunn.ch> <52FE5662.7000108@meshcoding.com>
 <20140214181850.GI17451@lunn.ch>
In-Reply-To: <20140214181850.GI17451@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WC7g9XoDtRKrIeG3E6nxaWF97D9UxoCTd"
Subject: Re: [B.A.T.M.A.N.] [RFC 18/23] batman-adv: ELP - use phydev to
 determine link characteristics
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
To: Andrew Lunn <andrew@lunn.ch>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WC7g9XoDtRKrIeG3E6nxaWF97D9UxoCTd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14/02/14 19:18, Andrew Lunn wrote:
>> Are you 100% sure that the NETDEV_UP event was sent within those 3
>> seconds and not after?
>> If you use a serial console you should see the kernel output mixed wit=
h
>> your test. (just to be 100% sure..)
>=20
> http://lxr.free-electrons.com/source/net/core/dev.c#L1286
>=20
> 1286 int dev_open(struct net_device *dev)
> 1287 {
> 1288         int ret;
> 1289=20
> 1290         if (dev->flags & IFF_UP)
> 1291                 return 0;
> 1292=20
> 1293         ret =3D __dev_open(dev);
> 1294         if (ret < 0)
> 1295                 return ret;
> 1296=20
> 1297         rtmsg_ifinfo(RTM_NEWLINK, dev, IFF_UP|IFF_RUNNING, GFP_KER=
NEL);
> 1298         call_netdevice_notifiers(NETDEV_UP, dev);
> 1299=20
> 1300         return ret;
> 1301 }
>=20
>=20
> So the NETDEV_UP is sent as soon as __dev_open() returns,
> i.e. ndo_open().

Yeah, I hoped that the negotiation was performed within dev_open() :-(

>=20
> What i do see is:
>=20
> half
> 1000
> half
> 1000
> half
> 1000
> half
> 1000
> half
> 1000
> half
> 1000
> mv643xx_eth_port mv643xx_eth_port.0 eth0: link up, 1000 Mb/s, full dupl=
ex, flowd
> full
> 1000
>=20
> The link up is from:
>=20
> http://lxr.free-electrons.com/source/drivers/net/ethernet/marvell/mv643=
xx_eth.c#L1990
>=20
> There is no sign of a call_netdevice_notifiers() here, but i think a
> netlink message will be sent to userspace because of the
> netif_carrier_on() call.

I tried to follow netif_carrier_on() but I couldn't find any particular
function firing any event.

Maybe I should simply make it simple and read the Ethernet card
properties inside get_throughput() upon ELP sending (like I do for the
wifi throughput)?

I did put it in iface_activate() because I expected this values to be
rather static, but now you convinced me that this is not the case :-)


Cheers,

--=20
Antonio Quartulli


--WC7g9XoDtRKrIeG3E6nxaWF97D9UxoCTd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS/mv1AAoJEEKTMo6mOh1VajEP/1g8Tl+tLkAnjURs5Pf+TEGp
LgTfKrmPs+9twzuGgKaIHIKs+AH7ojatZNEP0e7iilpbPVVMFvFZ6tRDNqqNFPcS
a5/6SwA7gNjzlmZadG62r8BvaV6OZvS1L15PYXJENbnKYtds/ibrieVIL8Jpfub4
7qXtnmAyABUanavgb8lQLyi4bngpTEKqBC4f/+mvubrJ85j3O2SITHthstvWX860
ogSEcQ5uDuBl0OhYUnafHa/v8DZVqHZT2dSE3nFryUfe3N0vi6D+Q49Igc1kEju6
2QTZhGyVoO4GGzlwgbzV6BfUHKnWc7L56h/dSKDNgzzJhR8KPRDYp9Jlea1gLIze
adndmqWgqqEugKUH6xcNoCE3/CMDTuPu03MQd30dbj3QWQzSTZjm2JykNgPBQqx4
8nPoKmm7yBoSxx41bxFTK5o0FuUmiEW7fkzpDsSNdK86Ajubkk6JYKDgJUg5V+GG
lKjpt599xdwyHV8M6vco8ZllASHm2nzSk6MsT9SC8jB8Ak7knMcJdvp3nokGfbOc
xTh9H2qW2P2FXnkYTVk8gOmElZIPpGCwc+80JeRlzZWyQs+lsQrdEi2e0+HLUgZw
Nun49JRYbsGh/J94oqlLZKgqSBjs+2MuD/G5d8PCOdnHJEUr6nlL606C0TmafLNQ
PbKb8KQai4jnRniEJkk6
=0BCn
-----END PGP SIGNATURE-----

--WC7g9XoDtRKrIeG3E6nxaWF97D9UxoCTd--
