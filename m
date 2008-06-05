Message-ID: <4847F23D.6010903@csp.it>
Date: Thu, 05 Jun 2008 16:03:41 +0200
From: cipollone <cipollone@csp.it>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Batman-Advanced Kernel land
References: <4846B27B.9020907@csp.it>	<200806041811.38881.sven.eckelmann@gmx.de>
	<200806051038.19094.lindner_marek@yahoo.de>
In-Reply-To: <200806051038.19094.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Reply-To: cipollone@csp.it,
	The list for a Better Approach To Mobile Ad-hoc Networking
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

I've tested B.A.T.M.A.N. Advanced Kernel Land version 6 with a different 
Linux OpenWRT Kernel Version. I've used the # 2.6.24.2 and , also in 
this case, I can't ping the other pc with the same kernel version.

Now, with kernel version 2.6.25.4, 2.6.22.2 and 2.6.24.2, Batman doesn't 
send packets. I think there is a problem passing in layer 3 because if I 
ping itself it answer at the request ( it is because it doesn't go in 
the layer 3, but stay at layer 2 with ARP).

I'm reading the log message in order to understand what's the problem 
and where is.

Now I have also putted vde switch in hub mode.

Regards

Paolo

