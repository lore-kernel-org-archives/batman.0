Return-Path: <djb31st@gmail.com>
MIME-Version: 1.0
In-Reply-To: <AANLkTinxbdLuASJexuNerq2tyW4dzEHpSEWpik01ZXgE@mail.gmail.com>
References: <mailman.375.1281525844.17951.b.a.t.m.a.n@lists.open-mesh.org>
	<201008121250.07216.lindner_marek@yahoo.de>
	<AANLkTimnri5HYfhPWEhvwGsoaKzhSn6d2MvrRjV8KVQg@mail.gmail.com>
	<201008121329.29995.sven.eckelmann@gmx.de>
	<AANLkTinxbdLuASJexuNerq2tyW4dzEHpSEWpik01ZXgE@mail.gmail.com>
Date: Thu, 12 Aug 2010 16:14:08 +0300
Message-ID: <AANLkTikZe=V_5MmaazhCD3+bgtmDSKKZrFK8FMMkNTxe@mail.gmail.com>
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

I have removed the extra ip addresses that where not needed and tried
to simplify a few other things, however i am still in the same
position where i can ping but not transfer.

Can anybody see anything wrong with my NAT rules that could be causing this=
?

On Thu, Aug 12, 2010 at 2:41 PM, David Beaumont <djb31st@gmail.com> wrote:
> It does appear that i have got somewhat confused with my ip ranges and
> addresses, let me try and clear that up now as ath0 and bat0 certainly
> doesn't need an ip address.
>
> Sorry for my oversight on this, i've gotten myself in a bit of a mess
> trying to resolve this by the looks of things.
>
> Ah, sorry i missed the nat information here it is
>
> mesh_
>
> Chain PREROUTING (policy ACCEPT)
> target =A0 =A0 prot opt source =A0 =A0 =A0 =A0 =A0 =A0 =A0 destination
>
> Chain POSTROUTING (policy ACCEPT)
> target =A0 =A0 prot opt source =A0 =A0 =A0 =A0 =A0 =A0 =A0 destination
> MASQUERADE =A0all =A0-- =A0anywhere =A0 =A0 =A0 =A0 =A0 =A0 anywhere
>
> Chain OUTPUT (policy ACCEPT)
> target =A0 =A0 prot opt source =A0 =A0 =A0 =A0 =A0 =A0 =A0 destination
>
> Chain luci_splash_leases (1 references)
> target =A0 =A0 prot opt source =A0 =A0 =A0 =A0 =A0 =A0 =A0 destination
> REDIRECT =A0 tcp =A0-- =A0anywhere =A0 =A0 =A0 =A0 =A0 =A0 anywhere =A0 =
=A0 =A0 =A0 =A0 =A0tcp
> dpt:80 redir ports 8082
> DROP =A0 =A0 =A0 all =A0-- =A0anywhere =A0 =A0 =A0 =A0 =A0 =A0 anywhere
>
> Chain luci_splash_portal (0 references)
> target =A0 =A0 prot opt source =A0 =A0 =A0 =A0 =A0 =A0 =A0 destination
> RETURN =A0 =A0 udp =A0-- =A0anywhere =A0 =A0 =A0 =A0 =A0 =A0 anywhere =A0=
 =A0 =A0 =A0 =A0 =A0udp
> dpts:33434:33523
> RETURN =A0 =A0 icmp -- =A0anywhere =A0 =A0 =A0 =A0 =A0 =A0 anywhere
> RETURN =A0 =A0 udp =A0-- =A0anywhere =A0 =A0 =A0 =A0 =A0 =A0 anywhere =A0=
 =A0 =A0 =A0 =A0 =A0udp dpt:53
> luci_splash_leases =A0all =A0-- =A0anywhere =A0 =A0 =A0 =A0 =A0 =A0 anywh=
ere
>
> Chain luci_splash_prerouting (0 references)
> target =A0 =A0 prot opt source =A0 =A0 =A0 =A0 =A0 =A0 =A0 destination
>
> Chain natfix_ath0 (0 references)
> target =A0 =A0 prot opt source =A0 =A0 =A0 =A0 =A0 =A0 =A0 destination
> ACCEPT =A0 =A0 all =A0-- =A010.0.0.0/8 =A0 =A0 =A0 =A0 =A0 10.0.0.0/8
>
> Chain natfix_br-lan (0 references)
> target =A0 =A0 prot opt source =A0 =A0 =A0 =A0 =A0 =A0 =A0 destination
> ACCEPT =A0 =A0 all =A0-- =A010.2.4.0/24 =A0 =A0 =A0 =A0 =A010.2.4.0/24
>
> Chain natfix_br-wan (0 references)
> target =A0 =A0 prot opt source =A0 =A0 =A0 =A0 =A0 =A0 =A0 destination
> ACCEPT =A0 =A0 all =A0-- =A0192.168.1.0/24 =A0 =A0 =A0 192.168.1.0/24
>
>
> net_
>
> Chain PREROUTING (policy ACCEPT)
> target =A0 =A0 prot opt source =A0 =A0 =A0 =A0 =A0 =A0 =A0 destination
> zone_wan_prerouting =A0all =A0-- =A0anywhere =A0 =A0 =A0 =A0 =A0 =A0 anyw=
here
> zone_lan_prerouting =A0all =A0-- =A0anywhere =A0 =A0 =A0 =A0 =A0 =A0 anyw=
here
> prerouting_rule =A0all =A0-- =A0anywhere =A0 =A0 =A0 =A0 =A0 =A0 anywhere
>
> Chain POSTROUTING (policy ACCEPT)
> target =A0 =A0 prot opt source =A0 =A0 =A0 =A0 =A0 =A0 =A0 destination
> postrouting_rule =A0all =A0-- =A0anywhere =A0 =A0 =A0 =A0 =A0 =A0 anywher=
e
> zone_wan_nat =A0all =A0-- =A0anywhere =A0 =A0 =A0 =A0 =A0 =A0 anywhere
>
> Chain OUTPUT (policy ACCEPT)
> target =A0 =A0 prot opt source =A0 =A0 =A0 =A0 =A0 =A0 =A0 destination
>
> Chain postrouting_rule (1 references)
> target =A0 =A0 prot opt source =A0 =A0 =A0 =A0 =A0 =A0 =A0 destination
>
> Chain prerouting_lan (1 references)
> target =A0 =A0 prot opt source =A0 =A0 =A0 =A0 =A0 =A0 =A0 destination
>
> Chain prerouting_rule (1 references)
> target =A0 =A0 prot opt source =A0 =A0 =A0 =A0 =A0 =A0 =A0 destination
>
> Chain prerouting_wan (1 references)
> target =A0 =A0 prot opt source =A0 =A0 =A0 =A0 =A0 =A0 =A0 destination
>
> Chain zone_lan_nat (0 references)
> target =A0 =A0 prot opt source =A0 =A0 =A0 =A0 =A0 =A0 =A0 destination
> MASQUERADE =A0all =A0-- =A0anywhere =A0 =A0 =A0 =A0 =A0 =A0 anywhere
>
> Chain zone_lan_prerouting (1 references)
> target =A0 =A0 prot opt source =A0 =A0 =A0 =A0 =A0 =A0 =A0 destination
> prerouting_lan =A0all =A0-- =A0anywhere =A0 =A0 =A0 =A0 =A0 =A0 anywhere
>
> Chain zone_wan_nat (1 references)
> target =A0 =A0 prot opt source =A0 =A0 =A0 =A0 =A0 =A0 =A0 destination
> MASQUERADE =A0all =A0-- =A0anywhere =A0 =A0 =A0 =A0 =A0 =A0 anywhere
>
> Chain zone_wan_prerouting (1 references)
> target =A0 =A0 prot opt source =A0 =A0 =A0 =A0 =A0 =A0 =A0 destination
> prerouting_wan =A0all =A0-- =A0anywhere =A0 =A0 =A0 =A0 =A0 =A0 anywhere
>
>
>
> On Thu, Aug 12, 2010 at 2:29 PM, Sven Eckelmann <sven.eckelmann@gmx.de> w=
rote:
>> David Beaumont wrote:
>>> Hopefully attachments come though ok?
>>>
>>> net_ is from the router connected to the internet
>>> mesh_ is the other side of the mesh
>>
>> to the mesh thing:
>>
>> =A0* Why has ath0 an IP... which also conflicts with the ip range of bat=
0 and
>> =A0 br-lan?
>>
>> =A0* Why has bat0 an ip when it is part of br-wan.
>>
>> =A0* Why has the ath0 device iptables entries?
>>
>> to the net thing:
>>
>> =A0* why has bat0 an ip when it is part of br-lan?
>>
>>
>> Why don't I see masquerade anywhere in the iptables output (-t nat)?
>>
>> Best regards,
>> =A0 =A0 =A0 =A0Sven
>>
>
