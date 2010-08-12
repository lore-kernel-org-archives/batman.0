Return-Path: <djb31st@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201008121329.29995.sven.eckelmann@gmx.de>
References: <mailman.375.1281525844.17951.b.a.t.m.a.n@lists.open-mesh.org>
	<201008121250.07216.lindner_marek@yahoo.de>
	<AANLkTimnri5HYfhPWEhvwGsoaKzhSn6d2MvrRjV8KVQg@mail.gmail.com>
	<201008121329.29995.sven.eckelmann@gmx.de>
Date: Thu, 12 Aug 2010 14:41:14 +0300
Message-ID: <AANLkTinxbdLuASJexuNerq2tyW4dzEHpSEWpik01ZXgE@mail.gmail.com>
From: David Beaumont <djb31st@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Nat Question
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

It does appear that i have got somewhat confused with my ip ranges and
addresses, let me try and clear that up now as ath0 and bat0 certainly
doesn't need an ip address.

Sorry for my oversight on this, i've gotten myself in a bit of a mess
trying to resolve this by the looks of things.

Ah, sorry i missed the nat information here it is

mesh_

Chain PREROUTING (policy ACCEPT)
target     prot opt source               destination

Chain POSTROUTING (policy ACCEPT)
target     prot opt source               destination
MASQUERADE  all  --  anywhere             anywhere

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination

Chain luci_splash_leases (1 references)
target     prot opt source               destination
REDIRECT   tcp  --  anywhere             anywhere            tcp
dpt:80 redir ports 8082
DROP       all  --  anywhere             anywhere

Chain luci_splash_portal (0 references)
target     prot opt source               destination
RETURN     udp  --  anywhere             anywhere            udp
dpts:33434:33523
RETURN     icmp --  anywhere             anywhere
RETURN     udp  --  anywhere             anywhere            udp dpt:53
luci_splash_leases  all  --  anywhere             anywhere

Chain luci_splash_prerouting (0 references)
target     prot opt source               destination

Chain natfix_ath0 (0 references)
target     prot opt source               destination
ACCEPT     all  --  10.0.0.0/8           10.0.0.0/8

Chain natfix_br-lan (0 references)
target     prot opt source               destination
ACCEPT     all  --  10.2.4.0/24          10.2.4.0/24

Chain natfix_br-wan (0 references)
target     prot opt source               destination
ACCEPT     all  --  192.168.1.0/24       192.168.1.0/24


net_

Chain PREROUTING (policy ACCEPT)
target     prot opt source               destination
zone_wan_prerouting  all  --  anywhere             anywhere
zone_lan_prerouting  all  --  anywhere             anywhere
prerouting_rule  all  --  anywhere             anywhere

Chain POSTROUTING (policy ACCEPT)
target     prot opt source               destination
postrouting_rule  all  --  anywhere             anywhere
zone_wan_nat  all  --  anywhere             anywhere

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination

Chain postrouting_rule (1 references)
target     prot opt source               destination

Chain prerouting_lan (1 references)
target     prot opt source               destination

Chain prerouting_rule (1 references)
target     prot opt source               destination

Chain prerouting_wan (1 references)
target     prot opt source               destination

Chain zone_lan_nat (0 references)
target     prot opt source               destination
MASQUERADE  all  --  anywhere             anywhere

Chain zone_lan_prerouting (1 references)
target     prot opt source               destination
prerouting_lan  all  --  anywhere             anywhere

Chain zone_wan_nat (1 references)
target     prot opt source               destination
MASQUERADE  all  --  anywhere             anywhere

Chain zone_wan_prerouting (1 references)
target     prot opt source               destination
prerouting_wan  all  --  anywhere             anywhere



On Thu, Aug 12, 2010 at 2:29 PM, Sven Eckelmann <sven.eckelmann@gmx.de> wro=
te:
> David Beaumont wrote:
>> Hopefully attachments come though ok?
>>
>> net_ is from the router connected to the internet
>> mesh_ is the other side of the mesh
>
> to the mesh thing:
>
> =A0* Why has ath0 an IP... which also conflicts with the ip range of bat0=
 and
> =A0 br-lan?
>
> =A0* Why has bat0 an ip when it is part of br-wan.
>
> =A0* Why has the ath0 device iptables entries?
>
> to the net thing:
>
> =A0* why has bat0 an ip when it is part of br-lan?
>
>
> Why don't I see masquerade anywhere in the iptables output (-t nat)?
>
> Best regards,
> =A0 =A0 =A0 =A0Sven
>
