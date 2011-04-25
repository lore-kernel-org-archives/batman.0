Return-Path: <gollab@interia.pl>
Message-ID: <4DB5DB65.6070706@interia.pl>
Date: Mon, 25 Apr 2011 22:36:53 +0200
From: =?UTF-8?B?S3J6eXNpZWsgR2/FgsSZYmlld3NraQ==?= <gollab@interia.pl>
MIME-Version: 1.0
References: <201104251055.17370.onelektra@gmx.net>
In-Reply-To: <201104251055.17370.onelektra@gmx.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
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
To: onelektra@gmx.net, b.a.t.m.a.n@lists.open-mesh.org

I tried to change my settings as you have wroten, elektra.

So I:

1. Changed the settings on client and now I have:

 >config 'interface' 'ath0'
 >option 'ifname' 'ath0'
 >option 'proto' 'static'
 >option 'ipaddr' '10.130.1.3'
 >option 'netmask' '255.255.255.0'
 >option 'dns' '8.8.8.8'

There is no gateway now and there is new dns server.

2. Rebooted router (client) and then typed:
 >> iptable -F .
3. I started batmand with command below:
 >> batmand -d 3 -r 2 -a 192.168.4.0/24 --disable-client-nat ath0

4. On the gateway I also used
 >> iptables -F

and then I typed:

>>  iptables -t nat -A POSTROUTING -o eth0.1 -j MASQUERADE

and after it I started batmand, command below:

>>  batmand -d 3 -g 1000 -a 192.168.3.0/24 ath0

I changed also speed of gateway connection. Here, at home I have only 1Mbit.

>  (I am assuming that you have the uplink connected to the WAN port of the Asus)

Yes, you`re right. Port eth0.1 (wan) is my port to the next router (my home router with normal access to Internet and Asus is connected to it`s one of lan ports).
It`s got an address (192.168.2.2) from DHCP.


Now situation is:

On the client router - connected by ssh - putty:
I can ping f.e. www.google.com and I have a reply (ping works).
I can ping 192.168.2.1 (gateway at home router).
I can ping 10.130.1.1 (address of interface ath0 on gateway).
I can`t ping 192.168.2.2 (port wan on Asus, why?). -> results 100% loss.
I can`t ping 169.254.0.0 (end of tunnel gate0 on the gateway). -> 
results 100% loss.

On the gateway:
I can ping Internet address (www.google.com).
I can ping 10.130.1.3.
I can ping 169.254.0.1.
I can ping 192.168.2.2.
I can ping 192.168.2.1.

On the gateway all look correctly.

On PC connected to Router Client (by LAN eth0.0) I can ping almost 
nothing...
ping 192.168.4.1 (gateway PC-Router client) working.
ping 10.130.1.3 working.
ping 10.130.1.1 not working -> Request time out.
Any other address doesn`t reply.

On PC connected to Router Gateway (by LAN eth0.0):
ping www.google.com not working
ping 10.130.1.1 working
ping 10.130.1.3 working
ping 192.168.2.2 working
ping 192.168.2.1 not working.

And... messenger works properly... despite it I can`t ping gateway.

Maybe it depends on routing table, but here is another problem.

>  The command

>  route -n

>  is not helpful when working with batmand. The route command is a outdated
>  legacy from Linux 2.2 and older. Use the
>  ip command instead, to see the policy routing tables.

>  ip r ls table all

>  will list all tables.


Yes... I am associating this command but some minuts ago I would like to 
check my routing table and these commands: ip route and ip rule are not 
recognized for my router.

root@Asus4:~# ip r ls table all
-ash: ip: not found

I thought I didn`t install it but in list of packages available for my 
Backfire I couldn`t find something suitable. From where can I download it?


Any more suggestions?
Thanks,
Krzysiek.


---------------------------------------------
Ksiegowa radzi: Jak załozyc firme w 15 minut?
http://linkint.pl/f2968

