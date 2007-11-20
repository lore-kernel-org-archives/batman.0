From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] single IP for multiple interfaces
Date: Tue, 20 Nov 2007 13:24:34 +0100
References: <47426F09.9060605@absorb.it>
	<200711201159.15845.lindner_marek@yahoo.de>
	<4742C4FF.4010307@absorb.it>
In-Reply-To: <4742C4FF.4010307@absorb.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711201324.34421.lindner_marek@yahoo.de>
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

> Works perfect, we use for instance the WRAP-boards in our network with
> two WIFI- and one LAN-Interface, all three having the same IP.
> The related patch is at
> http://titan.www.opennet-initiative.de/olsrd_patches/mipip.patch, but
> its since a while part of olsrd.

I read the patch and without knowing the olsrd code I would say that you 
operate on interface names instead of IPs. But I see some problems here:
- How does this work in a mixed environment ?
- More important: The routing table operates on IP addresses and not on 
interface names. Even if olsrd can distinguish your interfaces by name the 
kernel can't.

Imagine: You have a node A with 2 Interfaces and node B can hear both 
interfaces but one better than the other. The routing table entry would look 
like that "<destination> via IP_of_node_A" whereas the kernel can't send the 
packet to a distinct interface of A. Whatever interface of A responds first 
to your ARP query will get all data packets and thus you may end up with 
using lossy links.

I don't see anything to solve that in this patch.

Regards,
Marek
