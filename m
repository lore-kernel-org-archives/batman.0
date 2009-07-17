Return-Path: <andrew.lunn@ascom.ch>
Date: Fri, 17 Jul 2009 19:46:10 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090717174610.GD4656@ma.tech.ascom.ch>
References: <20090717172521.GB4656@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090717172521.GB4656@ma.tech.ascom.ch>
Subject: Re: [B.A.T.M.A.N.] [batman-adv] packet.h coding style cleanup
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

On Fri, Jul 17, 2009 at 07:25:21PM +0200, Andrew Lunn wrote:
> Make packet.h clean with respect to the 2.6.29 checkpatch script.
> Also adds one macro, BAT_PACKET_LEN, which is used in other patches
> to follow.

Arg, please ignore this patch. There is something extra in there which
should not be.

       Andrew
