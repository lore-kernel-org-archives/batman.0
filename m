Return-Path: <cmsv@wirelesspt.net>
Message-ID: <50F6ECE5.90802@wirelesspt.net>
Date: Wed, 16 Jan 2013 13:09:41 -0500
From: cmsv <cmsv@wirelesspt.net>
MIME-Version: 1.0
References: <50F68D22.7090709@wirelesspt.net>
 <CAHD-aqJrdXNJeVEti+HTFkSg47B642gJ7wUDvFGrNNp6merjkw@mail.gmail.com>
In-Reply-To: <CAHD-aqJrdXNJeVEti+HTFkSg47B642gJ7wUDvFGrNNp6merjkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] dns/routing/ issue (batman-adv mesh)
Reply-To: cmsv@wirelesspt.net,
 The list for a Better Approach To Mobile Ad-hoc Networking
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
To: Gui Iribarren <gui@altermundi.net>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

just like you ; i would like to have the mesh working even if a gateway 
dies.
http://dpaste.com/hold/879202/

cable connected clients on the client routers can access the wan
just not wirelessly connected.

On 01/16/13 12:31, Gui Iribarren wrote:
> You posted only one set of configurations, but it's not clear to me
> whether that belongs to router 1 or 2.
> Could you please repost (maybe in a pastebin.com link)
> /etc/config/network
> /etc/config/dhcp
> /etc/config/wireless
> for router 1
>
> and the same, clearly labeled , for router 2
>
> On Wed, Jan 16, 2013 at 8:21 AM, cmsv<cmsv@wirelesspt.net>  wrote:
>> # cat /etc/openwrt_release
>> DISTRIB_ID="OpenWrt"
>> DISTRIB_RELEASE="Attitude Adjustment"
>> DISTRIB_REVISION="r35153"
>> DISTRIB_CODENAME="attitude_adjustment"
>> DISTRIB_TARGET="ar71xx/generic"
>> DISTRIB_DESCRIPTION="OpenWrt Attitude Adjustment 12.09-rc1"
>>
>> Batman-adv 2012.3.0
>>
>> Scenario:
>> router 1 is the internet gateway
>> router 2 is a client router of that gateway
>> Both routers in vap mode with 2 diff ssid's
>> one dhcp pool for 'lan'
>>
>> config dnsmasq
>> option domainneeded     1
>> option boguspriv        1
>> option filterwin2k      0  # enable for dial on demand
>> option localise_queries 1
>> option rebind_protection 1  # disable if upstream must serve RFC1918
>> addresses
>> option rebind_localhost 1  # enable for RBL checking and similar services
>> #list rebind_domain example.lan  # whitelist RFC1918 responses for domains
>> option local    '/lan/'
>> option domain   'wirelesspt.net'
>> option expandhosts      1
>> option nonegcache       0
>> option authoritative    1
>> option readethers       1
>> option leasefile        '/tmp/dhcp.leases'
>> option resolvfile       '/tmp/resolv.conf.auto'
>> #list server            '/mycompany.local/1.2.3.4'
>> #option nonwildcard     1
>> #list interface         br-lan
>> #list notinterface      lo
>> #list bogusnxdomain     '64.94.110.11'
>> #list dns               208.67.222.222
>> #list dns               208.67.220.220
>> #list dns               8.8.8.8
>>
>> config dhcp lan
>> option interface        lan
>> option start    50
>> option limit    254
>> option leasetime        24h
>> #option force   1
>>
>> config dhcp wan
>> option interface        wan
>> option ignore   1 # 0 for non gw
>>
>>
>> Problem:
>> router 1 clients (people with computers) can connect to it either with cable
>> or wirelessly and ping/access the wan. router 1 works well this way
>>
>> router 1 can ping router 2 either on layer 2 or layer 3
>>
>> router 2 can ping router 1 either on layer 2 or layer 3
>> router
>>
>> clients (connected to router 2 via cable) are able to access and ping the
>> wan.
>> clients connected to router 2 wirelessly are NOT able to access the wan.
>> Seems a routing/dns issue
>>
>> # ping yahoo.com
>> ping: bad address 'yahoo.com
>>
>> both /etc/resolv.com contain 127.0.0.1 as nameserver
>>
>> # cat network
>> config interface 'loopback'
>>          option ifname 'lo'
>>          option proto 'static'
>>          option ipaddr '127.0.0.1'
>>          option netmask '255.0.0.0'
>>
>> config interface 'lan'
>>          option ifname 'eth0 bat0'
>>          option type 'bridge'
>>          option proto 'static'
>>          option ipaddr '192.168.1.2'
>>          option netmask '255.255.255.0'
>>
>> config 'interface' 'mesh'
>>          option ifname 'wlan0-1'
>>          option 'proto' 'none'
>>          option 'mtu' '1528'
>>
>> config interface 'wan'
>>          option ifname 'eth1'
>>          option proto 'dhcp'
>>
>> config switch
>>          option name 'eth0'
>>          option reset '1'
>>          option enable_vlan '1'
>>
>> config switch_vlan
>>          option device 'eth0'
>>          option vlan '1'
>>          option ports '0 1 2 3 4'
>>
>> # cat batman-adv
>> config 'mesh' 'bat0'
>>          option 'interfaces' 'mesh'
>>          option 'aggregated_ogms' '1'
>>          option 'ap_isolation' '0'
>>          option 'bonding' '0'
>>          option 'fragmentation' '1'
>>          option 'gw_bandwidth' '3mbit/384kbit'
>>          option 'gw_mode' 'client'
>>          option 'gw_sel_class' '20'
>>          option 'orig_interval' '1000'
>>          option 'vis_mode' 'client'
>>          option 'bridge_loop_avoidance' '1'
>>          #option 'log_level'
>>
>>
>> /etc/firewall contains openwrt default settings and i have questioned myself
>> if some rules need to be set there.
>>
>> i tried this:
>> http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2012-May/007131.html and no
>> success.
>>
>> and read this which is somewhat related tp my issue too.
>> www.mail-archive.com/b.a.t.m.a.n@lists.open-mesh.org/msg07643.html
>>
>> what am i missing ? iptables forward rules ?
>>
>>
>>
>>
>>
>>
>>
>> --
>>
>>
>>
>>
>>
>>
>> Redes wireless
>> http://wirelesspt.net
>
