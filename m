Return-Path: <gollab@interia.pl>
Message-ID: <4DB720B8.2040309@interia.pl>
Date: Tue, 26 Apr 2011 21:44:56 +0200
From: =?UTF-8?B?S3J6eXNpZWsgR2/FgsSZYmlld3NraQ==?= <gollab@interia.pl>
MIME-Version: 1.0
References: <201104260142.24934.onelektra@gmx.net>
In-Reply-To: <201104260142.24934.onelektra@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello again,

I can say that it`s propably work now!

 > With regards to the PC connected to the batman gateway client - did 
you set up
 > a default route in the PC? Without a
 > route you can only ping those IPs that are link local. Don't forget 
to add a
 > DNS server, too.

I have had a default route on my PC computer so far. (I checked it with 
route print command).

I have noticed that when I stop my firewall I will have Internet on 
computer PC (on the gateway) and batmand is not working properly. After 
my firewall was started, batmand works properly but I can`t use the 
Intenet then. I have solved it by changing rule forward from REJECT to 
ACCEPT (on router gateway and on the router client) in firewall 
settings. My firewall is working at the moment and I can start batmand 
and it works properly. I can browse websites in my internet browser and 
ping hosts. Ping from the PC connected to router client works too.

 > The package you are missing is iproute2.

Ok, finally I found it. I was looking for a iproute package but it was 
named simply "ip" - this package contains ip route, ip rule, ip link and 
others.

>  Don't bother about pinging the tunnel endpoint IP. The tunnel is merely
>  required as a means of transport which
>  allows batman gateway-clients to select a batmand gateway when sending traffic
>  *to* the gateway. And it is a half-way
>  (one-way!) tunnel.

Of course you are right one more time. It is precisly visible thanks to ifconfig in statistics. Tx in gate0 is growing all the time and Rx not.


Thanks again Elektra,
Cheers,
Krzysiek.





-------------------------------------------------
Lubisz Interie?
Ustaw jako strone startowa! >> http://linkint.pl/f297f

