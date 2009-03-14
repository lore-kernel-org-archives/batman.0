Message-ID: <49BB7058.2070100@java-system.com>
Date: Sat, 14 Mar 2009 09:52:40 +0100
From: marco tozzini <lists@java-system.com>
MIME-Version: 1.0
References: <49B825BE.4040605@java-system.com>
	<200903112214.44339.onelektra@gmx.net>
In-Reply-To: <200903112214.44339.onelektra@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Unable to connect to internet
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

elektra wrote:
> Hi .
>
>   
>> Any Hints?
>>     
>
> sure: You are not announcing a default route.
>
> On mesh router connected to ADSL:
>
> batmand -g 1000 ath0
>
> On other mesh router:
>
> batmand -r 1 ath0
>
> You have to NAT towards the internet on the gateway.
>
> Cheers,
> elektra 
>   

After this hint I have
node 203 = batman node not connect to internet
node 200 = batman node gateway connect to wired lan and internet

 >From the batman node client 203 (not connected to internet)
root@OpenWrt:~# ping -c 2 192.168.2.200 (= ath0)
PING 192.168.2.200 (192.168.2.200): 56 data bytes
64 bytes from 192.168.2.200: seq=0 ttl=64 time=3.330 ms
64 bytes from 192.168.2.200: seq=1 ttl=64 time=2.902 ms
--- 192.168.2.200 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 2.902/3.116/3.330 ms

root@OpenWrt:~# ping -c 2 192.168.0.200 (= br-lan)
PING 192.168.0.200 (192.168.0.200): 56 data bytes
64 bytes from 192.168.0.200: seq=0 ttl=64 time=4.780 ms
64 bytes from 192.168.0.200: seq=1 ttl=64 time=2.944 ms
--- 192.168.0.200 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 2.944/3.862/4.780 ms

root@OpenWrt:~# ping -c 2 192.168.0.1 (= router ADSL)
PING 192.168.0.1 (192.168.0.1): 56 data bytes
--- 192.168.0.1 ping statistics ---
2 packets transmitted, 0 packets received, 100% packet loss

root@OpenWrt:~# ping -c 2 192.168.0.80 (= other openwrt station 
connected through lan cable)
PING 192.168.0.80 (192.168.0.80): 56 data bytes
--- 192.168.0.80 ping statistics ---
2 packets transmitted, 0 packets received, 100% packet loss


further; from GATEWAY batman node 200 (connected to wired lan and internet)
I can ping everything

So this means:

 From the CLIENT batman node 203 (not connected to wired lan and internet)
I can ping wireless interface of the batman node connected to wired lan
I can ping br-lan wired interface of the batman node connected to wired 
lan (so I think routing exist)
I CAN'T ping other nodes seen by br-lan wired interface of the batman 
node connected to wired lan

I suspect the problem could be elsewhere batman, isn't it?

thanks
Marco


