Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <CAHD-aqKo=uzeu6_oc4BXj2WRWObMADyWCHp0sNFn8cJDX8sdjA@mail.gmail.com>
References: <CAHD-aqKoP3NDSWNHv=vOUCF_ANTRkVWGyXq-v=WC8iRPHJkdhQ@mail.gmail.com>
	<20120704091225.GA10142@pandem0nium>
	<CAHD-aqKo=uzeu6_oc4BXj2WRWObMADyWCHp0sNFn8cJDX8sdjA@mail.gmail.com>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Wed, 4 Jul 2012 10:12:51 -0300
Message-ID: <CAHD-aqJYXy_Y1vnzHqV6yyrTPAZCHOshGK2HboeYuEzx8i0xNA@mail.gmail.com>
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

On Wed, Jul 4, 2012 at 9:43 AM, Guido Iribarren
<guidoiribarren@buenosaireslibre.org> wrote:
> On Wed, Jul 4, 2012 at 6:12 AM, Simon Wunderlich
> <simon.wunderlich@s2003.tu-chemnitz.de> wrote:
>> Hello Guido,
>>

> gw-mode is activated in all mesh nodes, not only in colmena-casa and
> f8d11504758
> it's set to client on every node except f8d11504758, which has gw_mode=server
>
> As far as i can recall, disabling gw_mode=client in every mesh node,
> solved the problem.
> But now that i found out about this "batctl td" thing, i'm in doubt
> about the validity of the previous statement :(
> i should check again and report.

I can now confirm this.

if i set gw_mode=off in a particular mesh node, DHCP requests
originating from that node work correctly, even when the mesh node
client is claimed by the "wrong" backbone node.

in this scenario:
 *         ruth_eth0 on    -1 by      colmena-casa [ ] (7a27)
 *      hquilla_eth0 on    -1 by      colmena-casa [ ] (7a27)

root@ruth:~# batctl gw off
root@ruth:~# /sbin/udhcpc -t 0 -i br-lan:ipv4 -f -R
udhcpc (v1.19.4) started
Sending discover...
Sending select for 10.254.0.131...
Lease of 10.254.0.131 obtained, lease time 600

root@hquilla:~# batctl gw client
root@hquilla:~# /sbin/udhcpc -t 0 -i br-lan:ipv4 -f -R
udhcpc (v1.19.4) started
Sending discover...
Sending discover...
Sending discover...^C

when hquilla sends the request, this is received at f8d11504758
interface wlan0-2
BAT colmena-casa > f8d11504758: UCAST.......
and gets dropped (doesn't reach dnsmasq)

when ruth (gw_mode=off) sends the request, this is received at
f8d11504758 interface wlan0-2
BAT colmena: BCAST, orig ruth, ......
(then rebroadcasted several times)
and it reaches dnsmasq properly.


If you prefer the raw "batctl td" for some eye-injuring reason, here you go:
http://pastebin.com/HNBg01hR

hope that helps!

Gui
