Return-Path: <andrew@lunn.ch>
Date: Wed, 23 Jun 2010 18:12:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100623161221.GN15420@lunn.ch>
References: <201006231620.11058.lindner_marek@yahoo.de>
	<1277302839-20197-1-git-send-email-lindner_marek@yahoo.de>
	<20100623150913.GJ15420@lunn.ch>
	<201006231758.40146.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201006231758.40146.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: add routing debug log
 accessible via debugfs
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Wed, Jun 23, 2010 at 05:58:39PM +0200, Marek Lindner wrote:
> On Wednesday 23 June 2010 17:09:13 Andrew Lunn wrote:
> > There will be a ring buffer per mesh. When debugging problems between
> > meshes it is likely both logs will be combined performing a merge
> > based on the timestamp. However at this point you have lost
> > information about which line belongs to which mesh. Could we maybe
> > include the soft interface name in the output?
> 
> Actually, this information is (indirectly) present, since each log file resides 
> inside debugfs/batman_adv/$mesh_if/log. It would be a little bit redundant to 
> add this on every line, wouldn't you agree ? If someone merges 2 mesh files it 
> still can be added ?

It can be done, its just more complex. If it was in the line already, i could
probably just do cat /debugfs/batman_adv/bat?/log | sort | less

Alternatively, batctl could add the interface name after the time
stamp. But there is then no easy way with pipes to combine the output
from two batctls and pass it to sort. So maybe batctl has to do it
all?

> You are right - we could leave it as jiffies. Might be the best solution.

O.K.

	Andrew
