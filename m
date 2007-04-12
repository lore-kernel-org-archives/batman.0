Message-ID: <461E4D53.5080200@yahoo.gr>
Date: Thu, 12 Apr 2007 18:16:35 +0300
From: Acinonyx <acinonyxs@yahoo.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-7; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] BATMAN tests on BGP confederations
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

Greetings from Athens,

we are planning to test BATMAN as an IGP protocol on BGP confederations 
in AWMN.

AWMN is massive but not excactly a mobile network. It is a network 
consisted of nodes with many point-to-point links where each node is a 
BGP AS by itself. Some of us saw the limitations of BGP routing and 
created BGP confederation to be able to run a faster and smarter 
protocol among ourselves without disrupting the operation of the rest of 
the network. Until now we have been using OLSR as IGP with much success. 
We believe that BATMAN will perform better because it has the ability to 
measure not only packet loss but link latency and does not create 
routing loops. Originator Message overhead doesn't concern us at all 
cause our links have a capacity of more than 30Mbps.

So, the tests are going to be made on a small confederation of 12-30 
peers. When we have the first results/problems I'll report them to you. 
Thank you in advance... :-)

Best Regards,
Vassilis T.

