Message-ID: <45ED4460.6080603@gmx.net>
Date: Tue, 06 Mar 2007 11:37:20 +0100
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] How does BATMAN work?
References: <67D9DF1D-1ACF-4ACF-A1A8-02795AA18027@gmx.net>
In-Reply-To: <67D9DF1D-1ACF-4ACF-A1A8-02795AA18027@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Hello Hendrik -
>
> 1. What Fields are there in the OGM-Package/Header? As to this point I 
> got:
>     - TTL
>     - Seq.No.
>     - Orig.IP
>     - Unidrectional Flag
>   and as possible extension
>     - "Reachable Subnets"
>     - "Is willing to Serve as a gateway".
> Are there any others?
>
You have omitted gateway class. We use one byte to communicate gateway 
class and unidirectional flag.
> 2. Electra wrote:
> "A Originator will see others repeating its Originator messages if the 
> radio conditions provide a bidirectional link. This is the only case 
> when we send feedback to others [..] Of course a OGM with 
> unidirectional flag is only helpful for its Originator, to learn: Hey, 
> this node has seen me and I have seen it. So we have a bidirectional 
> link!" about retransmitting an OGM.
> Can the Originator of an OGM use this Information to put his direct 
> neighbor in his routingtable (since that is nessesary for knowing "So 
> we have a bidirectional link" ;o) ), or does it has to wait for the 
> OGM of his direct neighbor (neighbor is the originator) to arrive? (I 
> guess waiting is the answer, I just want to be sure)
It doesn't have to wait - since a working bidirectional radio link is 
already verified. We don't have to wait for our neighbor to add 
ourselves into his routing table since a single hop neighbor is link 
local anyway. However in our implementation we wait for incoming OGMs 
from the neighbor. There is no harm doing it this way it is just a tiny 
bit slower when establishing a route to a single hop neighbor. But don't 
forget: Only if the single hop neighbor is the best ranking neighbor to 
route traffic to itself it will be added as a gateway to itself into the 
routing table. A node may have a weak but direct link to a single hop 
neighbor, while we get more OGMs re-broadcasted from another single hop 
neighbor.

Would you send us your work, even if it is written in German?

cu elektra
