Return-Path: <baantunes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
From: Bruno Antunes <baantunes@gmail.com>
In-Reply-To: <26865236.GIsAj78OZH@diderot>
Date: Tue, 1 Apr 2014 11:01:16 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <6EA59799-2CB9-4B60-83A9-C0F1893B70B1@gmail.com>
References: <0643725B-CC5E-4AAA-8908-C6A0EA4CE631@gmail.com>
 <26865236.GIsAj78OZH@diderot>
Subject: Re: [B.A.T.M.A.N.] Batman-adv 2014.1.0 and 2014.0.0 issues with
	3.10 and 3.8 kernels
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

Hi,

On 31 Mar, 2014, at 14:02 , Marek Lindner <mareklindner@neomailbox.ch> =
wrote:

> On Monday 31 March 2014 12:23:52 Bruno Antunes wrote:
>> root@Laguna1:/etc/config# wifi
>> [37620.920000] batman_adv: bat0: Interface deactivated: adhoc0
>> [37621.140000] batman_adv: bat0: Removing interface: adhoc0
>> [37621.250000] br-mesh: port 2(bat0) entered disabled state
>> [37621.250000] device bat0 left promiscuous mode
>> [37621.260000] br-mesh: port 2(bat0) entered disabled state
>> [37631.340000] unregister_netdevice: waiting for adhoc0 to become =
free.
>> Usage count =3D 1 [37641.390000] unregister_netdevice: waiting for =
adhoc0 to
>> become free. Usage count =3D 1 [37651.410000] unregister_netdevice: =
waiting
>> for adhoc0 to become free. Usage count =3D 1
>=20
> This is a known 2014.1.0 regression which recently has been fixed. You =
can=20
> either update your openwrt package to fetch these fixes or extract the =
patches=20
> from our batman-adv git repository or wait for the next release.

Compiled with the latest update (31 Mar) and up until now it's working =
fine on both devices.

>=20
>=20
>> And only restarting is possible to get the device back to work.
>>=20
>> Going back to 2014.0.0 it's worst with the system being very unstable =
and
>> continuously restarting.
>>=20
>> After following the instructions from cmsv <cmsv@wirelesspt.net>
>> and replacing the feeds.conf with
>> src-git routing =
https://github.com/libre-mesh/openwrt-routing-packages
>=20
> Note that this is not the official openwrt-routing repository but a =
fork=20
> maintained by 'people on the internet'. If you do experience problems =
with the=20
> code coming from this repository, please contact the people =
maintaining this=20
> fork.

Didn't found any problems with this fork.

But has Gui commented I could have used the official repository to =
compile previous versions.
We are always learning...

Thanks,
Bruno
>=20
>=20
> Cheers,
> Marek

