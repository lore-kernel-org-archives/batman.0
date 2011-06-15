Return-Path: <fboehm@aon.at>
Message-ID: <4DF90276.8050701@aon.at>
Date: Wed, 15 Jun 2011 21:05:26 +0200
From: fboehm <fboehm@aon.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Linux bridge-code for something like BATMAN
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi,

I know bridging is not routing but I was thinking since some time if it 
is possible to modify the linux bridge-code for forwarding layer2 
packets according to the rules of some routing algorithm. This means the 
bridge would not learn mac addresses from ARP protocol any longer but 
from a daemon. The result would be a layer2 mesh routing like BATMAN does.

OLSR is doing quite the same one layer above by manipulating the routing 
table with the OLSR daemon. Of course it's much easier to manipulate a 
routing table because there are interfaces for doing this.

It's just an idea and I would like to hear your expert opinions.

Kind regards,
Franz
