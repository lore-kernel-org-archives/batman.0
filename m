Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 16 Nov 2014 14:08:43 +0800
Message-ID: <3113299.290J3YiqPU@diderot>
In-Reply-To: <CAN0ArPdRDXrriSfHMbnYErRVPPsb+=mTymnYxnXEOCT5Ye7k+g@mail.gmail.com>
References: <CAN0ArPdRDXrriSfHMbnYErRVPPsb+=mTymnYxnXEOCT5Ye7k+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1552012.rIisWV2ht0";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] wired only 10 gigabit batman-adv mesh
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
To: Mehul Sharma <mehulksharma@gmail.com>, 'The list for a Better Approach To Mobile Ad-hoc Networking' <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart1552012.rIisWV2ht0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"


Hi,

>                  Good Afternoon from Boston. I really love Batman-Adv=
 ...
> brilliant layer 2 functionality.
>=20
> I want to use batman-adv in a wired (gigabit and 10-gigabit) only mes=
h and
> wanted to know your insights.

makes me happy to hear you love our project. Typically, we communicate =
via our=20
public mailing list allowing various sources to chime in at any point. =
Since I=20
don't see any reason for privacy I am cc'ing the mailing list in my ans=
wer.


> The example case scenario is as follows:
>=20
> 1)     4 to 6 AMD servers with 6 10-Gigabit NICs each.
>=20
> 2)     2 or 3 10-Gigabit NICs used for batman-adv, which are then con=
nected
> in ring or torus topology directly (no external switch involved)
>=20
> 3)     the remaining interfaces on the server are connected to the LA=
N
> (switches, routers etc)
>=20
> 4)     the virtual machine (qemu-kvm) tap interfaces, the physical
> non-batman-adv ethernet and bat0 interfaces are put in a bridge (brct=
l), so
> now we have the ability for virtual machines, wired hosts on the lan =
to go
> via batman-adv and talk to each other.
>=20
> Is there any, down size to doing this? I see at the most 2 - 100 serv=
ers in
> one network....
>=20
> From what i understand:
>=20
> 1)  that the live migration of virtual machines (qemu-kvm) will be se=
en
> just as a migrating non-mesh client so my assumption is that live mig=
ration
> should work from that perspective. Also, what if the tap interfaces o=
f the
> virtual machines are given to bat0 itself (if it might help in live
> migration / increasing throughput) ?
>=20
> 2) The MTU if set for 1500 or 9000 or higher (eg barman-adv reads --
> "define ETHERMTU ETH_DATA_LEN") would be taken automatically by batma=
n-adv
> and anything below 1500 would be fragmented, which gives me the idea =
that
> higher MTUs would not be a problem for batman-adv to handle.
>=20
> 3)  There is no restriction to the number of clients in batman-adv.
>=20
> am i somewhat close in understanding batman-adv? .... apologies if no=
t...
>=20
> Also would layer 2 forwarding by batman-adv would be close, same or b=
etter
> when compared to bridge (linux brctl) packet forwarding?
>=20
> I have built converged-unified distributed qemu-kvm system (all metad=
ata
> less design, with web-interface and cli, quite the opposite of vmware=
 and
> open-stack type centralized approaches) and was in the preliminary st=
age of
> looking at the possibility of integrating batman-adv into the design.=

>=20
> Your input will be valuable for me to give server and desktop
> virtualization a mesh architecture on top of already distributed desi=
gn.

I keep your description intact to allow other people to comment as well=
.

Before we dive into the batman-adv details I'd like to understand what=20=

advantage batman-adv brings to the table in your scenario. The batman-a=
dv=20
project aims to facilitate layer2 routing in primarily wireless setups =
with=20
dynamically changing links due to link quality changes or links being m=
odified=20
in an uncontrolled fashion (community mesh network). While batman-adv a=
lso is=20
able to run on wired backbones this never was the main target and bears=
 a=20
number of drawbacks compared to other technologies. A simple example to=
=20
picture this: The standard Linux bridge (configurable via brctl) does n=
ot run=20
any link layer protocol to estimate the quality of one link compared to=
=20
another. This will give you huge advantages in terms of overhead with t=
he cost=20
of all links being treated equal. While this work fine on an all-wired =
setup=20
it represents an unacceptable trade-off for wireless networks.

From=20what I can gather you are not running wireless but high throughput=
 wired=20
links. What has brought you to batman-adv ?

Cheers,
Marek

--nextPart1552012.rIisWV2ht0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUaD9uAAoJEFNVTo/uthzA2+sH/2/V5mdy5SLrmP6xf2V878MV
F7UZueQQCY7GuwILpCVSX43L2bhVHXsLdIuagPMRgb33Ox5cFBXGzhgSbFppUcgJ
2Ct6bgbrQOT53vwfYSuRAv/uNxWerFehShYiv/A75TMnmKZ/52fo4DZd6Q14D57G
qWeSQxtEOqb31I82M1kNHxkDFxMG/qjtsQw9WQdwNTioM0u+nddVorqqjF3VrkSX
KG9h7TUDpRsoRf3vSPkRggVxQ1AR9i+Kx0FHdwXXvVZZP6oOdVYhFFCfI/BpQu4F
KsOTZ80Dx1wrJ4ihVlKGyuQltGnLGsd01dTz31UsNB4QNT5sphLQBpafLc2+pv4=
=CY5a
-----END PGP SIGNATURE-----

--nextPart1552012.rIisWV2ht0--

