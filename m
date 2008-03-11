Message-ID: <47D63219.3020603@gmx.net>
Date: Tue, 11 Mar 2008 08:17:45 +0100
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] b.a.t.m.a.n. + wrt54gl + OpenWrt Kamikaze +  
	X-wrt]
References: <52469.70.253.200.118.1205190931.squirrel@webmail.reglue.org>
In-Reply-To: <52469.70.253.200.118.1205190931.squirrel@webmail.reglue.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

I wrote: Use individual IPs for each interface! If you want to use 
batman on all interfaces, assign IPs out of the mesh IP subnet range for 
each interface.

I don't see that here:

ifconfig eth0.0 *103.0.0.3* netmask 255.0.0.0 broadcast 103.255.255.255
ifconfig eth0.1 *103.0.0.3* netmask 255.0.0.0 broadcast 103.255.255.255
ifconfig eth0 *103.0.0.3* netmask 255.0.0.0 broadcast 103.255.255.255
ifconfig wl0 *103.0.0.3* netmask 255.0.0.0 broadcast 103.255.255.255

And: Ports 4305-4307 are for the new versions of batman - which one are 
you using?





> I got batmand working with this startup script:
> (but I lost internet connectivity, even setting the gateway to 103.0.0.3)
>
>
> killall batmand
> iwconfig wl0 channel 10 essid project mode Ad-Hoc
> ifconfig eth0.0 103.0.0.3 netmask 255.0.0.0 broadcast 103.255.255.255
> ifconfig eth0.1 103.0.0.3 netmask 255.0.0.0 broadcast 103.255.255.255
> ifconfig eth0 103.0.0.3 netmask 255.0.0.0 broadcast 103.255.255.255
> ifconfig wl0 103.0.0.3 netmask 255.0.0.0 broadcast 103.255.255.255
> iptables -t filter -I INPUT 2 -p udp --dport 4305 --sport 4305 -j ACCEPT
> iptables -t filter -I INPUT 2 -p udp --dport 4306 --sport 4306 -j ACCEPT
> iptables -t filter -I INPUT 2 -p udp --dport 4307 --sport 4307 -j ACCEPT
> iptables -t filter -I OUTPUT 2 -p udp --dport 4305 --sport 4305 -j ACCEPT
> iptables -t filter -I OUTPUT 2 -p udp --dport 4306 --sport 4306 -j ACCEPT
> iptables -t filter -I OUTPUT 2 -p udp --dport 4307 --sport 4307 -j ACCEPT
> batmand eth0.0 eth0.1 wl0 eth0 br-lan &
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>   

