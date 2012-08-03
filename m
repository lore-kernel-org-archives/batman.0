Return-Path: <emunicio@gmail.com>
MIME-Version: 1.0
In-Reply-To: <12564988.U0eif3lDW2@bentobox>
References: <CAMVTf1hm9Q8Ppu2Lq6h4+7OpvZ9meLYhxFKHFLhudD3LCTNXmg@mail.gmail.com>
 <12564988.U0eif3lDW2@bentobox>
From: Esteban Municio <emunicio@gmail.com>
Date: Fri, 3 Aug 2012 11:54:30 -0500
Message-ID: <CAMVTf1hncmbgHS9PL0uEuRA8TL+8rp1cX_iv+iiO6NHzFTU4cA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] Problems with internet connection in a
 mesh-network, (and dhcp and wireless access)
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

More information:

This is the diagram of my network:

http://i49.tinypic.com/iy3guh.png

When I make ping from the laptop to 8.8.8.8, the result is nothing.
root@orion:/home/emunicio# ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
^C

I mean there is not a 'host/net unreachable' message, that makes me
think that maybe the ping can get there, but it does not know how to
came back to my laptop.It is the reason for I think is only a Nat problem.
Can be?

I seem that the problem is in L3, no in batman-adv configuration,
because the connectivity between nodes and laptos works well.
Any idea or advice?

Thanks you

Regards

Esteban

2012/8/3 Sven Eckelmann <sven@narfation.org>:
> On Thursday 02 August 2012 19:35:34 Esteban Municio wrote:
>> Hi all
>>
>> I wrote recently about problems with our batman-adv mesh
>> implementation in a development proyect in Peru:
>>
>> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2012-August/007820.html
>>
>> Now we are having problems again.
>> Our mesh-network are formed with Ubiquiti nanostation M5 nodes running
>> OpenWRT(10.03.x, r32751)+ Batman-adv 2.6.32.
>
> batman-adv was not included in 2.6.32. We had our first version in 2.6.33. So,
> this information is bogus. Please update to a recent version (for example
> 2012.2.0 + the updates from the maint branch; or just batman-adv-devel).
>
>> In one of the nodes, the wan gate is connected with Public IP to
>> internet and I can access to internet from there.
>>
>> But from a laptop(without batman-adv), I can make ping to all the
>> nodes of the mesh, but i can't make ping to 8.8.8.8 neither the Ip
>> public gateway. However, I can make ping to my Ip Public, in the
>> interface wan of my gateway node.
>>
>> What am I doing wrong? I have tried to write static routes, but I
>> think that the problem is about the mesh-bridge.
>> Is it beacuse of i need do NAT?
>
> It is hard to understand what you are doing and what you want. All you are
> doing here is L3 stuff... so out of scope for batman-adv. batman-adv provides
> only the l2 stuff (+ a dhcp routing hack when you enable the gateway stuff).
>
> So you need to do the same stuff you are doing when you want to configure an
> "internet gateway" for your private network. That usually includes
> masquerading, dhcp, dns, ...
>
>> All the nodes of the mesh can see themselves, and I set the node with
>> the gateway to internet like the gateway of the mesh, but it does not
>> work.
>>
>> Any help or comment?
>
> Sry, my parser failed. Maybe someone else can help.
>
>> That is my /etc/rc.local and /etc/config/network in the gateway node:
>>
>> /etc/rc.local
>>
>> wifi up
>> ifconfig wlan0 mtu 1528
>> batctl if add wlan0
>> ifconfig wlan0 up
>> ifconfig bat0 up
>> brctl addbr mesh-bridge
>> brctl addif mesh-bridge eth0
>> brctl addif mesh-bridge bat0
>> ifconfig eth0 up
>> ifconfig bat0 up
>> ifconfig mesh-bridge inet 1.1.1.1 netmask 255.255.255.0
>> ifconfig mesh-bridge up
>> exit 0
>>
>> /etc/config/network
>>
>> config 'interface' 'loopback'
>>     option 'ifname' 'lo'
>>     option 'proto' 'static'
>>     option 'ipaddr' '127.0.0.1'
>>     option 'netmask' '255.0.0.0'
>>
>> config 'interface' 'lan'
>>     option 'ifname' 'eth0'
>>     option 'proto' 'static'
>>     option 'ipaddr' '192.168.1.2'
>>     option 'netmask' '255.255.255.0'
>>
>> config 'interface' 'wan'
>>     option 'ifname' 'eth1'
>>     option 'proto' 'static'
>>     option 'ipaddr' my Ip public
>>     option 'netmask' '255.255.255.192'
>>     option 'gateway' my ip public gateway
>>     option 'dns' '8.8.8.8'
>>
>> config 'route'
>>
>> And some offtopic questions...
>>
>> What should i do for permit to others laptops without batman-adv can
>> connect by wireless to the mesh, make another wlan interface with
>> another ssid in ap mode and add it to the mesh-bridge?
>
> Didn't you say that you are already doing something like that? At least you've
> mentioned that that you are can connect with you non-mesh laptop. But yes,
> you should have a second interface configured as AP attached to your mesh-
> bridge to allow wireless clients connected to this interface to work like the
> ethernet clients. It doesn't make much sense to have a non-batman-adv-aware
> client connected on a interface that is attached as slave (hard) interface to
> batman-adv.
>
> At least the configuration looks a little bit like you are trying to do
> something like this.
>
> Kind regards,
>         Sven



-- 
Esteban
