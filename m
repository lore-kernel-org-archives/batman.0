Return-Path: <ordex@autistici.org>
Date: Mon, 11 Apr 2011 08:33:07 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110411063254.GA23526@ritirata.org>
References: <alpine.DEB.2.00.1104102257050.17976@drawesome>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1104102257050.17976@drawesome>
Subject: Re: [B.A.T.M.A.N.] batman-adv coexisting with olsr?
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

On dom, apr 10, 2011 at 11:01:27 -0400, Ryan Hughes wrote:
> Hi.  Is it possible to get batman-adv to coexist with olsr, working with 
> different network prefixes?
> 
> Cuz it seems to me that the olsr traffic would all get routed by batman, 
> and every node would think it could see every other node, and olsr would 
> add all kinds of nonsense to the routing table.

Are you running olsr on bat0? You should run olsr on the phy device
(i.e. eth0, the same you added with batctl for batman-adv)

> 
> Thanks.
> --Ryan

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
