Return-Path: <ff@jluehr.de>
Message-ID: <539E0DEF.90703@jluehr.de>
Date: Sun, 15 Jun 2014 23:19:43 +0200
From: =?ISO-8859-15?Q?Jan_L=FChr?= <ff@jluehr.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] DHCP-Monitoring of Gateways
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hello,

we're running batman 2013.4, having multiple Gateways. For doing so,
we'd like to monitor the availability of every dhcp-server on each Gateway.

I noticed: If DHCP-Packages (even unicast ones) that unicast
DHCP-Requests / Discovery are unanswered, if
-> they're sent locally on a gateway
-> sent to a gateway not "chosen" (according to batctl gwl) by the
monitoring host.

What's the best way of monitoring all DHCP-Servers? Is there a way to
set up a monitoring node, that can reach all DHCP-Servers?
If not, how can request an ip address locally?


Thanks,
Greetz, Jan
