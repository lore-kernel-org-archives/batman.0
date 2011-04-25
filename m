Return-Path: <onelektra@gmx.net>
From: elektra <onelektra@gmx.net>
Date: Mon, 25 Apr 2011 10:55:17 +0200
References: <4DB49ECD.8040808@interia.pl>
In-Reply-To: <4DB49ECD.8040808@interia.pl>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201104251055.17370.onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] Batmand - ping 169.254.0.0 from client is not
	working.
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

Hello Krzysiek -

from your long post I can see that batmand is actually working. Both nodes see each other and the gateway is 
announced from the gateway side and selected from the client side. You are using the --disable-client-nat option 
and you announce individual subnets with batmand's HNA option. All good.

On the client side, in /etc/config/network:
 
> config 'interface' 'ath0'
>      option 'ifname' 'ath0'
>      option 'proto' 'static'
>      option 'ipaddr' '10.130.1.3'
>      option 'netmask' '255.255.255.0'
>      option 'gateway' '10.130.1.1'
>      option 'dns' '10.130.1.1'

1/ Get rid of the gateway setting. Setting up the gateway is the job of batmand. I suppose you copied the settings 
of the Mesh-Potato, right? The Mesh-Potato uses a fake gateway entry to make the Asterisk PBX happy. It didn't 
actually create harm, since batmand performs policy routing. But it may have added to confusion on your side.

The command 

route -n

is not helpful when working with batmand. The route command is a outdated legacy from Linux 2.2 and older. Use the 
ip command instead, to see the policy routing tables.

ip r ls table all 

will list all tables.

2/ Are you really running a DNS server / DNS forwarder on 10.130.1.1? When testing Internet access, I prefer to 
ping a IP first, to rule out DNS issues. Something easy to remember like 8.8.8.8. That IP is also a reliable public 
DNS server. If you don't need to resolve local IPs, a public DNS server setting like 141.1.1.1 or 8.8.8.8 will work 
reliably.
 
3/ With regards to the firewall - you don't need it. At least not for testing. My recommendation is to stop the 
firewall until you get the system running as expected and then enable the firewall again. If the system breaks after 
enabling the firewall, you know where to look at.

So, a simple

iptables -F 

on the client side will save you additional headaches. That change is not permanent, so only stops the firewall 
manually until you reboot. You can do this in all the clients. 

On the gateway side you need just one simple firewall setting:

iptables -F 
iptables -t nat -A POSTROUTING -o eth0.1 -j MASQUERADE

(I am assuming that you have the uplink connected to the WAN port of the Asus)

The advanced way to set up the batmand gateway is to set up routing in the subnet gateway (thats where the WAN port 
of the batmand gateway gets its DHCP lease from) and eliminate NAT here. This way you can eliminate the need to 
apply several layers of NAT everywhere. But this is causing additional challenges so I won't cover it for now. 

 
> I added also a registration to iptable (on the gateway and on the client
> the same)
> iptables -t nat -I POSTROUTING -o gate0 -j MASQUERADE

Don't.
 
> 
> So, nodes can see each other, and the gateway is broadcasting (client
> can see it).
> I can ping from gateway to client by tunnel -> ping 169.254.0.0 but I
> can`t ping from client to gateway -> ping 169.254.0.0 , what`s wrong?

ping 10.130.1.X or 192.168.X.X instead.

> Unfortunately, I can`t get internet too.

You will be there in no time ;)

Cheers,
Elektra


-- 
Viral meme of radical freedom

The fact that you talk in your head doesn't mean that you think.

The best way to lose control over yourself is trying to control yourself.

Most people experience themselves as a voice in their head, telling them 
who they are, what they think and what they have to do.
