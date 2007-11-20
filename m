From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] single IP for multiple interfaces
Date: Tue, 20 Nov 2007 15:08:05 +0100
References: <47426F09.9060605@absorb.it>
	<200711201324.34421.lindner_marek@yahoo.de>
	<4742E4E6.1010802@absorb.it>
In-Reply-To: <4742E4E6.1010802@absorb.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711201508.06076.lindner_marek@yahoo.de>
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


> sure? (I'm in no way an expert, its an honest question.)
> root@OpenWrt:~# ip route
> 192.168.1.48 via 192.168.1.188 dev ath1  metric 7
> 192.168.2.40 via 192.168.1.188 dev ath1  metric 6
> 192.168.1.49 via 192.168.1.188 dev ath1  metric 4
> 192.168.2.42 via 192.168.1.188 dev ath1  metric 7
> 192.168.1.51 via 192.168.2.172 dev eth0  metric 2

> so there are interfaces shown in the routes, the kernel should recognize
> them, what else they are for?

As Axel already mentionned: These are the outgoing interfaces which you can 
specify but the problem arises if your neighbor node has 2 interfaces as 
well. How are you going to seperate these ? Normally you do so by using 2 
different IP addresses to send traffic to one or the other interface. But if 
you only have one address ...


> PS: Invited Sebastian Hagen who programmed the patch to join the
> discussion, hope he will help me/us with more details

Good idea. :-)

Greetings,
Marek

