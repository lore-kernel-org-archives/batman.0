Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <20120704091225.GA10142@pandem0nium>
References: <CAHD-aqKoP3NDSWNHv=vOUCF_ANTRkVWGyXq-v=WC8iRPHJkdhQ@mail.gmail.com>
	<20120704091225.GA10142@pandem0nium>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Wed, 4 Jul 2012 09:43:13 -0300
Message-ID: <CAHD-aqKo=uzeu6_oc4BXj2WRWObMADyWCHp0sNFn8cJDX8sdjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] BLAII + gw_mode, DHCP sometimes gets dropped
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

On Wed, Jul 4, 2012 at 6:12 AM, Simon Wunderlich
<simon.wunderlich@s2003.tu-chemnitz.de> wrote:
> Hello Guido,
>
> On Tue, Jul 03, 2012 at 05:07:17PM -0300, Guido Iribarren wrote:
>> Hello there again,
>> I have observed a problem since updating to 2012.2 and enabled BLAII
>>
>> I'm compiling logs to understand what's happening, but as always,
>> reading logs only gets me more lost :(
>> So here i am again begging for help
>
> There are some debug levels for BLA as well, and you can now get the
> claimlist with batctl (which is basically the list of clients a gateway
> feels responsible for) - this may help for debugging. But first,
> we should clarify some more details for your setup.
Yes, I've seen the cl command, but didn't completely understand how to
interpret it. For example, right now I see the clients claimed in the
cl of mesh nodes, and even the same client claimed in different nodes.

( when I say mesh nodes, and in the rest of the email, i'm referring
to http://www.open-mesh.org/wiki/batman-adv/Bridge-loop-avoidance-II#Definitions
)

i.e. sample mesh-nodes:
root@charly:~# batctl cl
Claims announced for the mesh bat0 (orig            charly, group id 6412)
   Client               VID      Originator        [o] (CRC )
 * 00:25:d3:f5:93:76 on    -1 by            charly [x] (77f9)
 * f8d1113b6e66_eth0 on    -1 by            charly [x] (77f9)

root@hquilla:~# batctl cl
Claims announced for the mesh bat0 (orig           hquilla, group id 82cb)
   Client               VID      Originator        [o] (CRC )
 * 00:25:d3:f5:93:76 on    -1 by           hquilla [x] (c72e)
 * 00:24:81:4b:ea:6d on    -1 by           hquilla [x] (c72e)

maybe that's fine because they have different group ids? (??)
is there any documentation on the cl output?
as far i could interpret, CRC "identifies" a particular version of a table,
[o] = [x] means "this is claimed by myself"
group id identifies different backbones (like in this case:)
http://www.open-mesh.org/wiki/batman-adv/Bridge-loop-avoidance-Testcases#Two-LANs-connected-by-one-mesh

and VID, is always set to -1 :P
oh, maaaaybe it's vlan id (?) since i'm not using VLANs

>>
>> the setup is the same I described in yesterday's attachment, but
>> what's not pictured is an ethernet cable between colmena-casa and
>> f8d11504758.
>> f8d11504758 is the only router that connects to the internet (through
>> WAN cable), and it's also the only one that has dnsmasq running and
>> gw_mode=server.
>> All the other nodes have gw_mode=client
>>
>> All of the nodes have bridge_loop_avoidance=1
>> (even though there are no other utp connections, so it could in fact
>> be enabled only on colmena-casa and f8d11504758)
>>
>> with this setup, dhcp requests from the mesh sometimes get "lost",
>> either they don't reach f8d11504758 or the reply doesn't get out
>
> Questions:
>  * which node runs the DHCP server? colmena-casa, f8d11504758 or something else?
Only the node f8d11504758 runs a DHCP server (dnsmasq) on its interface br-lan
no other dhcp server is running on the network

>  * at which point is DHCP getting lost? is the DISCOVER/REQUEST from the client
>    getting lost, or the reply from the server?

Well, I just managed to get a clarifying tcpdump!
hquilla sent a select (REQUEST) that reached the wlan0-2 (mesh)
interface of f8d11504758 and it was silently dropped (didn't appear on
a batctl td of bat0)
this repeated several times, until a lucky REQUEST managed to pass
through, was sniffed at bat0, and got a reply from dnsmasq

I couldn't see any difference between the unlucky and lucky REQUESTs
or DISCOVERs,
but running a "batctl cl -w1" did the trick:
when the client is currently claimed by f8d11504758 as in
 *      hquilla_eth0 on    -1 by      f8d11504758 [x] (d38b)

both the REQUESTs and DISCOVERs reach dnsmasq fine

but if the client is currently claimed by colmena-casa as in
 *      hquilla_eth0 on    -1 by      colmena-casa [ ] (3d7f)
these discover/requests get dropped by batman when they arrive through wlan0-2

>  * Can you specify "sometimes" a little bit more? What are the circumstances, how
>    often does it happen?
Well, most of the time :) dhcp clients keep trying and eventually they
get the lease, but in unlucky times that might even take hours :(
at any point in time, there are "lucky" clients who can get a lease
and renew it without problem, and other "unlucky" that can't get a
reply at all.

from what i've just seen at the "batctl cl", this luck is related to
being claimed by the "right" backbone node.

>
>>
>> this didn't happen with batman 2012.1 , setup as indicated by the BLAI
>> wiki page (batctl if add br-lan)
>> furthermore, with batman 2012.2 , BLAII activated, but gw_mode=off in
>> all nodes, DHCP also works fine.
>
> Mhm, that's rather strange ... we had a similar problem when ap isolation
> was activated. Do you have this feature turned on?
Nope

>
> So DHCP is only having problems when gw-mode is turned on colmena-casa
> and f8d11504758?

gw-mode is activated in all mesh nodes, not only in colmena-casa and
f8d11504758
it's set to client on every node except f8d11504758, which has gw_mode=server

As far as i can recall, disabling gw_mode=client in every mesh node,
solved the problem.
But now that i found out about this "batctl td" thing, i'm in doubt
about the validity of the previous statement :(
i should check again and report.

>>
>> So, a few questions arise:
>> is it a problem to activate bridge_loop_avoidance=1 in all nodes,
>> regardless of the fact that they "need" it or not? (that is, it is
>> activated on nodes that don't have any ethernet cables connected and
>> couldn't possibly create a bridge loop)
>
> No, that it is not a problem - you can activate it everywhere. It will
> just send some additional control packets on bat0, but won't do anything
> as long as it does not detect other gateways.
>
>>
>> would it make a difference, if I add br-lan to bat0 (batctl if add
>> br-lan) the way I used to do with batman 2012.1 ?
>
> That won't help, because the design of BLA changed and the old BLA has been
> removed. Please keep the bridge out of bat0. :)
Ok, thanks a lot for the clarifications!

Have a great day,

Gui
