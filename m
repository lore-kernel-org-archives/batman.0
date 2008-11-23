From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] BATMAN routing (via gate0)
Date: Sun, 23 Nov 2008 11:37:10 +0800
References: <57356.149.5.32.200.1227370855.squirrel@www.rivertowermail.com>
	<200811230035.05534.lindner_marek@yahoo.de>
	<35921.149.5.32.200.1227387936.squirrel@www.rivertowermail.com>
In-Reply-To: <35921.149.5.32.200.1227387936.squirrel@www.rivertowermail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200811231137.11082.lindner_marek@yahoo.de>
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

On Sunday 23 November 2008 05:05:36 Derek C wrote:
> Does this mean that the mesh nodes cannot ping all the other nodes?   This
> is if there is no routing to allow the nodes talk to "far-away" nodes not
> within their own AdHoc single-hop network?

May be I was not clear enough:
* You can ping every batman node in range.
* Too far away nodes (out of range) obviously can't be pinged. 
* If you have multiple subnetworks which could ping each other but are routed 
differently you just have to make sure the routing is ok. Using HNA is one 
possible solution.

Does this answer you question ? Please give a sample scenario if not.

Regards,
Marek

