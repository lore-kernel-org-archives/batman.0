Return-Path: <gtolon@inti.gob.ar>
Message-ID: <4F0C39BE.3000209@inti.gob.ar>
Date: Tue, 10 Jan 2012 10:14:38 -0300
From: gtolon@inti.gob.ar
MIME-Version: 1.0
References: <mailman.1.1326193201.4676.b.a.t.m.a.n@lists.open-mesh.org>
In-Reply-To: <mailman.1.1326193201.4676.b.a.t.m.a.n@lists.open-mesh.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] problem with mesh network
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

Hi Marek, thanks for the reply.


El 10/01/2012 08:00 a.m., b.a.t.m.a.n-request@lists.open-mesh.org escribi=
=F3:
> Date: Mon, 9 Jan 2012 20:22:37 +0800
> From: Marek Lindner<lindner_marek@yahoo.de>
> To: "The list for a Better Approach To Mobile Ad-hoc Networking"
> 	<b.a.t.m.a.n@lists.open-mesh.org>
> Subject: Re: [B.A.T.M.A.N.] problem with mesh network
> Message-ID:<201201092022.37637.lindner_marek@yahoo.de>
> Content-Type: Text/Plain;  charset=3D"iso-8859-1"
>
>
> Hi,
>
>> >  We are using batman-adv 2011.2.0 with Openwrt Backfire-rc6 on D-Link
>> >  Dir-615 routers (2 Antennas, 1 single radio), each router with an adh=
oc
>> >  interface managed by batman-adv for the mesh network and an Acces Poi=
nt
>> >  interface bridged with bat0 and ethernet to allow non batman-adv clie=
nts
>> >  to connect. The problem is that sometimes all works fine, but sometim=
es
>> >  we get very poor bitrates between routers, even using just two router=
s,
>> >  testing with iperf. We don't know where the problem is, specially
>> >  because it's a very erratic behavior. If any of you have used this
>> >  configuration with openwrt and ath9k driver we'd really appreciate so=
me
>> >  help.
> this does not sound like a batman issue. Did you try contacting the
> ath9k/linux-wireless/openwrt developers ?

Yes, we suspected it could be a TX dma problem, because occasionally we=20
found that error in the logs, so we followed some openwrt tickets=20
related with that, but we're not sure that's the problem, and anyway it=20
has not been solved yet. We've also asked on ath9k list about the driver=20
debug files in case we could find something there, but they did't=20
answered, I guess it's hard to explain in a mail list. We haven't asked=20
to linux-wireless, maybe it would be better, since it could be something=20
on top of the driver.

>
>> >  By the way, the D-Link Dir-615 is an n router, but for some reason
>> >  related with hostapd the ap vif gets configured in g mode, and the ad=
hoc
>> >  in n mode, no matter what we set in the uci files. So in case the
>> >  problem were related with the adhoc and ap virtual interface, we were
>> >  thinking about the possibility of setting the mesh network without us=
ing
>> >  adhoc mode. In that case each router should have one ap for non
>> >  batman-adv clients, and two additional interfaces, one in ap and the
>> >  other managed, these two used to connect with other routers via
>> >  batman-adv, would that be correct? In that case, you think this
>> >  configuration could be more or less stable than the other using adhoc
>> >  mode?
> batman-adv does not care how you configure your interfaces. Using managed=
/AP
> with batman-adv on top works as well. However, you will need to configure=
 each
> managed/AP setup manually which will be cumbersome in a larger network an=
d has
> no failover. A single failure in your managed/AP chain will bring down all
> nodes depending on it.
We were thinking in a script that managed the stations to connect to the=20
different APs to avoid configuring each router manually. However we=20
realized that with just one managed interface, each router could connect=20
to only one AP, so if we wanted that every router could connect=20
bidirectionally to others we should use a number of managed interfaces=20
enough to connect to all neigbours,  shouldn't we?
In any case it would be just another test to see if the results are=20
different.

Gabriel


