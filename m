Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20120331204322.GA31423@ritirata.org>
References: <CAA_JP8UrWSzLYoUEhrzbT1fjeedp28B0dr7dMB_TizLkr+4RNg@mail.gmail.com>
	<20120331204322.GA31423@ritirata.org>
Date: Sat, 31 Mar 2012 20:02:02 -0600
Message-ID: <CAA_JP8VjODMM-znsQLM-GyxWjXDJ70Y5yjh_EhgokEY3O+iKAg@mail.gmail.com>
From: dan <dandenson@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] any throughput mechanism or plans?
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

>
> Hello Dan,
>
> there is not such mechanism in batman-adv right now. It is a really good idea
> and we already started to think about that during WBMv5. Personally, I'm
> applying to the GSOC2012 and I'm proposing something similar.
>
> I also think that packet loss is not the correct way to go.
>
> Regarding your idea, how would you measure the maximum throughput?

An easy way might be to just pull the info from ifconfig on a timer:

eth0
          RX bytes:2841699391 (2.6 GiB)  TX bytes:2681928474 (2.4 GiB)
+ 5 seconds
          RX bytes:2842069649 (2.6 GiB)  TX bytes:2682282969 (2.4 GiB)

=RX of 361.5Kb, TX of 346.2Kb

just update a value for the MAX of both as they change

Compare the stored value to the last 5 second interval so see what
amount of the connection is available.  In my case, I have a 20Mb/10Mb
connection so I have 19.3Mb/9.3Mb available.  If I know the connection
speed (reliably) then I should be able to statically assign this.
Otherwise it should just be based on historical observations.
Wireless links are unpredictable so we have to rely on observation
while wired or higher end backhaul links are more predictable so it
may be best just use a set value.

It would be better if we could get total throughput on the wireless
link if possible.

I would think it would be useful to identify 1/2 duplex vs full
duplex.  1/2 duplex should be the aggregate of the rx and tx with some
ratio applied (70/30 by default for dl vs ul, this should be tunable)
and full duplex wouldn't have a ratio applied..

devices like an SAF freemile or Ubiquiti AirFibre are full duplex, so
SAF = 100Mb FD and AirFibre could be 700Mb FD.

I am assuming that each node knows which direction is upload and which
is download but that might not be true unless the gateway config was
used...  I'm not sure if that would be another type of advertisement
or what.
