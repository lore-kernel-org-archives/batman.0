Return-Path: <gabriel@kerneis.info>
Date: Fri, 9 Mar 2012 12:12:03 +0100
From: Gabriel Kerneis <kerneis@pps.jussieu.fr>
Message-ID: <20120309111203.GE15059@kerneis.info>
References: <4F4F6D18.3070403@ninux.org>
	<201203070156.51341.lindner_marek@yahoo.de>
	<20120306193643.GM12778@kerneis.info>
	<201203070552.33850.lindner_marek@yahoo.de>
	<7i62egijym.fsf@lanthane.pps.jussieu.fr>
	<20120307144709.GA19891@ritirata.org>
	<7ieht4mnnp.fsf@lanthane.pps.jussieu.fr>
	<20120307171751.GC1389@ritirata.org>
	<20120307221847.GR12778@kerneis.info>
	<20120309085636.GA9018@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20120309085636.GA9018@pandem0nium>
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

Hey Simon,

On Fri, Mar 09, 2012 at 09:56:36AM +0100, Simon Wunderlich wrote:
> 1) The detection part is batman-specific, we use the the PRIMARIES_FIRST_HOP flag
> to do that. As a reminder (that might be documented somewhere else):
> 
>  * OGMs from the primary interface are broadcasted on ALL interfaces and are spread over
>    the mesh (big TTL) --> these get the PRIMARIES_FIRST_HOP flag, which is cleared
>    when forwarded by other nodes
>  * OGMs from the secondary interfaces are only broadcasted on their respective interface
>    and are only used for local link sensing (TTL = 1)
> 
> When we receive OGMs with PRIMARIES_FIRST_HOP flags on different interfaces, we know
> that it came from the same neighbor, just from different interfaces. We have two
> links to this neighbor.

I think my primary misunderstanding comes from this concept of “primary
interface”.  It might be due to my lack of knowledge about Batman, but it
definitely looks like a hack to me: why do you need this symmetry breaking in
the first place?

I believe the rest is only implementation details layered on top of this
assumption.

Maybe there is some explanation that I have overlooked in the wiki?  I have not
found, for instance, how the primary interface is chosen.

Best regards,
-- 
Gabriel
