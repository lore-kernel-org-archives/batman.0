Return-Path: <alx@dd19.de>
Message-Id: <0EA2B96C-69B9-49DD-98B3-FF7156712C42@dd19.de>
From: Alex Morlang <alx@dd19.de>
In-Reply-To: <201004030008.21717.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Apple Message framework v936)
Date: Fri, 2 Apr 2010 19:36:49 +0200
References: <201004021744.01077.clemens-john@gmx.de>
	<201004030008.21717.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Batman Advanced Internet Gateway
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


Am 02.04.2010 um 18:08 schrieb Marek Lindner:

>
> Hi,
>
>> We are testing Batman Advanced as described in my other thread and =20=

>> I want
>> to share my Internetconnection on our network. How do I do this with
>> Batman Advanced?
>>
>> Is there already a working Batman Advanced version that supports =20
>> Internet
>> connection sharing (Maybe Trunk? Which revision?)?
>> In Olsr there was the dyn_gateway_plugin. How can I have something =20=

>> like
>> it=B4s functionality in Batman Advanced?
>
> I'm not familiar with the dyn_gateway_plugin plugin - what is it =20
> good for ?
>
in olsr, an internet uplink announced as a 0.0.0.0/0 HNA. As we can =20
announce a 10.23.42.0/24, we can announce the whole ipv4 or ipv6 =20
internet, that is  basically an uplink.

Trouble starts, when some node is annoncing a 0.0.0.0/0 HNA without =20
actually providing internet uplink, like when DSL is down, etc. Then, =20=

the node will bekome a blackhole for outbound traffic.

the dyn_gateway plugin tests for a defaultroute and pings over the =20
defaultroute to check for internet connectivity and does the =20
announcement of the 0/0 HNA.

batman3 has integrated tunnel, so everybody can choose their gateway. =20=

in this case, a failing gateway is not as disturbing as in olsr.

Now, Henning&Markus are introducing smartgateways, which is basically =20=

the same thing as batman3 does, announcing tunnelpartner and setting =20
up an ipip interface.

Combined with the dyn_gw plugin, any node can automatically choose its =20=

gateway based on bandwith, distance and reliability.

This clearly shows, how much we all can learn from each other, soon as =20=

we start listening.


> The "advanced gateway handling" tries to deal with multiple gateways =20=

> in the
> same mesh network in a smart way. AFAIK olsrd never had this =20
> functionality, so
> it is unlikely that you will miss it.  :-)

actually, finding a defaultroute is one of the main tasks for all =20
routing protocols in the last 30 years except for batman-adv and =20
netsukkuku.

>
> As soon as your router has an internet connection and "shares" it =20
> (firewall,
> NAT, etc) everybody will be able to use it. You can do this with all =20=

> batman-
> adv versions out there - no need to go to the trunk.
>
> Regards,
> Marek
Gruss, Alex=
