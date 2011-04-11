Return-Path: <ryan@iheartryan.com>
Date: Sun, 10 Apr 2011 23:01:27 -0400 (EDT)
From: Ryan Hughes <ryan@iheartryan.com>
Message-ID: <alpine.DEB.2.00.1104102257050.17976@drawesome>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Subject: [B.A.T.M.A.N.] batman-adv coexisting with olsr?
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

Hi.  Is it possible to get batman-adv to coexist with olsr, working with 
different network prefixes?

Cuz it seems to me that the olsr traffic would all get routed by batman, 
and every node would think it could see every other node, and olsr would 
add all kinds of nonsense to the routing table.

Thanks.
--Ryan
