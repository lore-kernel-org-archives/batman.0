Return-Path: <feanpg@gmail.com>
Message-ID: <52022858.3030105@gmail.com>
Date: Wed, 07 Aug 2013 12:58:32 +0200
From: Fernando Pizarro <feanpg@gmail.com>
MIME-Version: 1.0
References: <52020C25.9080705@gmail.com> <20130807090941.GK2943@ritirata.org>
In-Reply-To: <20130807090941.GK2943@ritirata.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] DAT issue
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

El 07/08/13 11:09, Antonio Quartulli escribió:
> On Wed, Aug 07, 2013 at 10:58:13AM +0200, Fernando Pizarro wrote:
>> Hi all!
>>
>> I'm playing with OpenWRT and BATMAN advance and I had configured one
>> essid to serve dynamic vlans via freeradius reply attributes.
>>
>> I have a bridge (br0) with bat0, wireless and ethernet interface, and
>> hostapd creates a new bridge by vlan (brvlanX) with vlanX and wlan1.X
>> succefully. Br0 has configured a VLAN and IP to connect with every other
>> nodes. There is the same explanation, but schematic:
>>
>> Wireless:
>>
>> phy0 -> wlan0 -> bat0
>> phy1 -> wlan1 -> wlan1.1
>>                        \ --> wlan1.N
>>
>> Hostapd bridge:
>>
>> wlan1 -> brvlan1 -> {wlan1.1; vlan1}
>>         \ --> brvlanN -> {wlan1.N; vlanN}
>>
>> Ethernet bridge:
>>
>> br0 -> {bat0; eth0; wlan1}
>>      \ --> br0.X == IP/NETMASK
>>
>> When I look at batman dat table there aren't any registry, but variuos
>> stations are connected. Why is that? What's wrong in my config?
>
> Hello Fernando,
>
> I have to say that your setup is not the easiest I've ever seen :)
> However, the initial version of DAT was not made to work with VLANs, but I'm not
> entirely sure if this should lead to an empty table.
>
> First of all, where are all your clients connected? to wlan1?
> Why did you put wlan1 into br0 and not wlan1.X?
> When your clients are doing traffic, can you see ARP Req/Resp on wlan1 (which is
> the interface in br0 that will inject then the data into bat0)?
>
> Cheers,
>
Hi Antonio, thanks for your answer.

I explain a bit more my stage... I have a server with DHCP that is the 
default gateway of all BATMAN nodes and clients, and BATMAN gateways are 
connected to it fisically. For roamming, I won't have IPs of VLANs in 
BATMAN nodes and all default gateways of VLANs are configured in the FW.

Clients connects to wlan1.X, but that interface is created by hostapd 
when radius allows access to the network of that client (default dynamic 
vlan behaviour). As hostapd creates this interface on demand and 
destroys it when is killed, I can't add wlan1.X to the bridge (br0). 
However, there is arp traffic on wlan1.

Greetings.
Fernando
