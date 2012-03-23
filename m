Return-Path: <andrew@lunn.ch>
Date: Fri, 23 Mar 2012 07:32:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120323063206.GA5662@lunn.ch>
References: <201203222250.31309.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201203222250.31309.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC] ELP
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

On Fri, Mar 23, 2012 at 05:50:30AM +0800, Marek Lindner wrote:
> 
> Hi,
> 
> after numerous infrastructure changes in the past weeks ELP[1] slowly
> approaches the state in which it can be tested and later merged into the
> master branch.

Hi Marek

Great to see this work going forward.

Something that Linus and I discussed was using unicast packets as
well. We didn't do anything at the time, project deadlines looming
etc... It is also a while ago, so maybe i'm remembering this wrong...

The problem with broadcasting the ELP packets is that they are always
sent with the most robust coding rate. So ELP gives you an idea how
good the 1Mbps broadcast channel is, not how good the unicast channel
the automatic rate selection algorithm is using is. I think we
discussed mixing in some unicast packets in the forward direction. The
ELP packets containing the reports would stay the same, and so
function as node detection. But a node could also send out unicast ELP
packets to its known neighbours and they would be included into the
LQ.

There are obvious drawbacks. More overhead, especially in dense
networks. It is also not clear if the measurements would be
better. Unicast packets get a number of retries with fast ACKs, where
as multicast does not. So multicast might actually give a better
measure of the link at 1Mbps.

Do you know if Linus had chance to explore these ideas during his
GSOC?

	Thanks
		Andrew
