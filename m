Return-Path: <gabriel@kerneis.info>
Date: Fri, 9 Mar 2012 13:04:55 +0100
From: Gabriel Kerneis <kerneis@pps.jussieu.fr>
Message-ID: <20120309120455.GF15059@kerneis.info>
References: <4F4F6D18.3070403@ninux.org> <20120309085636.GA9018@pandem0nium>
	<20120309111203.GE15059@kerneis.info>
	<201203091926.54899.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201203091926.54899.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [Battlemesh] Battlemesh v5 tests
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
Cc: Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>

On Fri, Mar 09, 2012 at 07:26:54PM +0800, Marek Lindner wrote:
> The concept of a primary interface goes back into the early days of batman and 
> primarily is an optimization to reduce overhead. At some point we realized 
> that it is not necessary to flood the mesh with OGMs from each and every 
> interface we have. Nearby nodes might want to know about all interfaces to 
> select the best one. Nodes that are far away don't care which interface is 
> connected to what other interface. They only care about a route to their 
> destination. This concept is briefly explained here[1] (section 2.1.6 and 
> 2.1.7).

Thanks for the pointer.

Does that mean that it is impossible to announce a route on some interfaces
only?  It looks like a rather arbitrary limitation.

In case I misunderstood and it is actually possible, I fail to see ĥow the
alternating algorithm takes this into account: it seems to assume that a node
will accept to route any packet on any interface.  Did I miss something?

Best regards,
-- 
Gabriel

