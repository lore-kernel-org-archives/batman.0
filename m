Message-ID: <51340.149.5.32.200.1226967080.squirrel@www.rivertowermail.com>
In-Reply-To: <20081118000636.GA11646@pandem0nium>
References: <56963.149.5.32.200.1226966194.squirrel@www.rivertowermail.com>
	<20081118000636.GA11646@pandem0nium>
Date: Tue, 18 Nov 2008 00:11:20 -0000 (UTC)
Subject: Re: [B.A.T.M.A.N.] MASQUERADING on the gate0 NIC
From: "Derek C" <derekbatman@hssl.ie>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi Simon,

thanks very much - this is fine

Derek


On Tue, November 18, 2008 12:06 am, Simon Wunderlich wrote:
> Hello Derek,
>
>
> BATMAN will only open one gate0, so this should be fine. The tunnel is
> always pointing to the currently selected gateway. Make sure that you add
> something like "--source 192.168.100.0/24" to your iptables line,
> otherwise other packets might make into in your NAT which you don't want
> there (e.g. from wifi interfaces). Only the packets from your local
> ([V]AP?) network should be there.
>
>
> regards, Simon
>
>
>
> On Mon, Nov 17, 2008 at 11:56:34PM -0000, Derek C wrote:
>
>> Hi again,
>>
>>
>> I'm currently testing with a few openwrt boards - generally its going
>> well and I'm connected to the Internet via a BATMAN node thats talking
>> to a gateway node - pretty good stuff.
>>
>> I've noticed something.  On my (non gateway) node the traffic is going
>> out the "gate0" tunnel NIC.  My notebook is connected wirelessly to an
>> [V]AP
>> on the node so I need to have a MASQUERADE rule on the gate0 NIC to
>> allow my local AP subnet (192.168.100.0/24) Internet access.
>>
>> In a live network, with lots of nodes, will there still only ever be
>> one gateX NIC ? - is it enough to just have an "iptables -t nat -A
>> POSTROUTING
>> -o gate0 -j MASQUERADE" rule ?
>>
>>
>> thanks very much for all the help
>>
>> Derek
>>
>>
>>
>> --
>> Derek C
>>
>>
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@open-mesh.net
>> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>>
>>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>


-- 
Derek C

