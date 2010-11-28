Return-Path: <hlabishik@gmail.com>
MIME-Version: 1.0
Date: Sun, 28 Nov 2010 23:28:52 +0200
Message-ID: <AANLkTikcyFFxvoyR1WiBNN95j2TS04wgkNGE6pSxz3Cn@mail.gmail.com>
From: hlabishi kobo <hlabishik@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] BATMAN routing
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
To: b.a.t.m.a.n@lists.open-mesh.org

I am doing a research on routing in a hybrid (combination of static
and mobile dynamic routers) mesh. I want to use the mesh potatoes as
well as the batphone (android version of batman) to create a mesh
model. due to the mobility and stability we want to add another factor
in the route ranking on the batman, thus the routing decisions not to
be solely based on the OGM's.thus we want to take the current
situation of the network into consideration when routing.
First we say the recently received OGMs will give a clear indication
on the reliability on the link, so we give the recently received OGMs
from the sliding window a priority in deciding the best next hop link
towards a destination. We want to count and add the indexes were an
OGM was recorded in an interval (seconds), (hence the recently
received OGM will have more weight). At the end the link with more
recent OGMs will have more weight and hence become the current best
link. I went through the source code so many times and I got few
questions about this:

1. What structure is used to keep track of the sliding window?  If its
the has how does it get updated based on the sliding packet range?
2. How are the OGM's recorded, is in a form of binary where 1 will
represent the received OGM and 0 otherwise?
3. I looked in the source and still not sure of where the ranking
decisions are made, can you enlighten me on that?

On the second approach we want to use mac layer stats to estimate the
signal strength and probably the congestion rate of the top N ranked
links. We acknowledge the fact that usually links with lower signal
strength will loose more OGM's which results in an automatic low rank,
however in a frequently changing topology, current signal strength is
crucial. We plan to use SNR or RSSI in this case.

1. How can i get the RSSI/LQI of th neighbor links?
I would really appreciate your opinions and advices in this regard
more specially how to go about implementing changes in BATMAN
protocol.
Thanks
Kind Regards
