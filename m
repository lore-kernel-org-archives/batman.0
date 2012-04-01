Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 2 Apr 2012 00:32:37 +0300
References: <CAA_JP8UrWSzLYoUEhrzbT1fjeedp28B0dr7dMB_TizLkr+4RNg@mail.gmail.com>
	<20120331204322.GA31423@ritirata.org>
	<CAA_JP8VjODMM-znsQLM-GyxWjXDJ70Y5yjh_EhgokEY3O+iKAg@mail.gmail.com>
In-Reply-To: <CAA_JP8VjODMM-znsQLM-GyxWjXDJ70Y5yjh_EhgokEY3O+iKAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201204020032.37555.lindner_marek@yahoo.de>
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

On Sunday, April 01, 2012 05:02:02 dan wrote:
> An easy way might be to just pull the info from ifconfig on a timer:
> 
> eth0
>           RX bytes:2841699391 (2.6 GiB)  TX bytes:2681928474 (2.4 GiB)
> + 5 seconds
>           RX bytes:2842069649 (2.6 GiB)  TX bytes:2682282969 (2.4 GiB)
> 
> =RX of 361.5Kb, TX of 346.2Kb
> 
> just update a value for the MAX of both as they change
> 
> Compare the stored value to the last 5 second interval so see what
> amount of the connection is available.  In my case, I have a 20Mb/10Mb
> connection so I have 19.3Mb/9.3Mb available.  If I know the connection
> speed (reliably) then I should be able to statically assign this.
> Otherwise it should just be based on historical observations.
> Wireless links are unpredictable so we have to rely on observation
> while wired or higher end backhaul links are more predictable so it
> may be best just use a set value.
> 
> It would be better if we could get total throughput on the wireless
> link if possible.

This approach bears some drawbacks: We can only assess the maximum throughput 
by saturating the link. Saturating the link isn't what we really want to do 
because it means nobody else can use the link to transfer data.
Furthermore, what if nobody transmits anything whithin your interval ? The 
counters won't increase and the link will be considered "bad" ?

Regards,
Marek
