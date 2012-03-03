Return-Path: <nicoechaniz@codigosur.org>
Message-ID: <4F51EF0B.5070501@codigosur.org>
Date: Sat, 03 Mar 2012 07:14:35 -0300
From: =?ISO-8859-1?Q?Nicol=E1s_Ech=E1niz?= <nicoechaniz@codigosur.org>
MIME-Version: 1.0
References: <4F51CA9D.2090404@codigosur.org>
	<201203031553.53565.lindner_marek@yahoo.de>
	<4F51D34F.9040204@codigosur.org>
	<201203031643.12912.lindner_marek@yahoo.de>
In-Reply-To: <201203031643.12912.lindner_marek@yahoo.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] routing loops on interconnected routers / adhoc
 + ethernet
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 03/03/2012 05:43 AM, Marek Lindner wrote:
> On Saturday, March 03, 2012 16:16:15 Nicol=E1s Ech=E1niz wrote:
>> Maerk thanks for your fast reply. In fact, that's how we started, that's
>> what I meant by:
>>
>> "We have also tried adding eth0 to bat0 and take it out of br-lan, which
>> also "works" but gives routing loops from time to time."
>>
>> but my english sometimes fails me :)
>=20
> Your English is quite good. To be honest I lost the overview about what=20
> interface is added where and what is connected how. Some people might be =
able=20
> to simply look at the uci config to understand the setup but I am not one=
 of=20
> those.  :-)
>=20
> Let me write down what I understood - feel free to correct me.=20
>=20
> some nodes -- node1 -- adhoc[wlan0-1] + ethernet[eth0] -- node2 -- more n=
odes
>=20
> Each node also has wlan0 for non-mesh clients but this is of no relevance=
 at=20
> this point. What is eth1 for ?


in the node marisa-mr, eth1 is the WAN port of the router, that is not
being used as wan but just as a non-batman ethernet interface to connect
to a router inside the house.

> You are saying that from time to time the packets loop between node1 and =
node2=20
> using adhoc & ethernet to fly forth and back ?

exactly so.

>> Is this a known issue or should this not happen in a setup where both
>> interfaces are added to batman?
>=20
> You should not have loops either way but it is easy to build loops in=20
> complicated setups. At first we should understand your setup and=20
> configuration. Drawing a little picture that shows what interface is conn=
ected=20
> to what other interface also can help.

alright, I'll try some ascii art, but I'm afraid you'll find out my
english is better :P


                                                   (non-batman)
                                                      wlan0
                                                        |
                                                  ------
                                                 | czuk |
                                                  ------
                                                /wlan1
                                               /
                                              /
                                             /
                                            /  1500m
                                           /
                                          /
                                         /
                                        wlan1
                            ---------- /
                           | cisterna |
                            ----------                  (batman enabled
                                |                        cabled clients)
                              wlan0                                |
                               / \                               eth0
                              /   \                                |
                             /     \                           -------
                            /       \                         | nogal |
                           /  350m   \          600m         / -------
                          /           \         --------wlan0
                         /             \      /
                        /               \    /
                  wlan0--------------wlan0-1
                 /                          \
    ------------                              ------------
   | marisa-mr  |            0m                | marisa-blt |
    ------------                              ------------ \
   |             \eth0__________________eth0/               wlan0
  eth1                                                    (non-batman)
(non-batman)
   |
   |
   |
[in-house router]




where not indicated otherwise, links are between interfaces added to batman.

I hope it's understandable!


... at the moment I've disabled marisa-mr_wlan0 and everything works fine.

The routing loop problem appears when marisa-mr_wlan0 is enabled, as
shown in the drawing.


The setup makes more sense when you add the antennae information.
marisa-blt has a panel/sector antena, but marisa-mr has a 24dbi grid
pointed at cisterna, which in turn has another grid pointed back (on
wlan0) and a second grid (on wlan1) points at czuk on the opposite side,
where a grid points back.


I've drawn the "desired" links; the wireless portion is ad-hoc, so there
are many more links present between the nodes, in fact cisterna, czuk
and both marisa's can all "see" each other.

cisterna_wlan1 has a reasonable link through the back lobe of the grid
antenna to both marisa-blt_wlan0-1 and marisa-mr_wlan0.


If you'd like me to send any more information just ask please; and if
you get bored, I'll understand!!



--
NicoEch=E1niz
