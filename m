Message-ID: <4742E4E6.1010802@absorb.it>
Date: Tue, 20 Nov 2007 19:15:10 +0530
From: rene <batman@absorb.it>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] single IP for multiple interfaces
References: <47426F09.9060605@absorb.it>	<200711201159.15845.lindner_marek@yahoo.de>	<4742C4FF.4010307@absorb.it>
	<200711201324.34421.lindner_marek@yahoo.de>
In-Reply-To: <200711201324.34421.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=iso-8859-1
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

Hi,

Marek Lindner wrote:
> - More important: The routing table operates on IP addresses and not on 
> interface names. Even if olsrd can distinguish your interfaces by name the 
> kernel can't.
sure? (I'm in no way an expert, its an honest question.)
root@OpenWrt:~# ip route
192.168.1.48 via 192.168.1.188 dev ath1  metric 7
192.168.2.40 via 192.168.1.188 dev ath1  metric 6
192.168.1.49 via 192.168.1.188 dev ath1  metric 4
192.168.2.42 via 192.168.1.188 dev ath1  metric 7
192.168.1.51 via 192.168.2.172 dev eth0  metric 2
192.168.1.53 via 192.168.1.188 dev ath1  metric 6
192.168.1.56 via 192.168.1.188 dev ath1  metric 6
192.168.2.32 via 192.168.1.188 dev ath1  metric 7
192.168.1.57 via 192.168.1.188 dev ath1  metric 6
192.168.2.33 via 192.168.1.188 dev ath1  metric 8
192.168.1.58 via 192.168.1.188 dev ath1  metric 3
192.168.1.60 via 192.168.1.188 dev ath1  metric 7
....

so there are interfaces shown in the routes, the kernel should recognize
them, what else they are for?

> Imagine: You have a node A with 2 Interfaces and node B can hear both 
> interfaces but one better than the other. The routing table entry would look 
> like that "<destination> via IP_of_node_A" whereas the kernel can't send the 
> packet to a distinct interface of A.
see above...

regards,
Rene

PS: Invited Sebastian Hagen who programmed the patch to join the
discussion, hope he will help me/us with more details

