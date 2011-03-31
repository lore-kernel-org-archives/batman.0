Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 31 Mar 2011 17:48:53 +0200
References: <20110323121503.GK6239@lunn.ch>
In-Reply-To: <20110323121503.GK6239@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201103311748.54166.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] [batman-adv] Set the txqueuelen to zero
	when creating soft interface.
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

On Wednesday 23 March 2011 13:15:03 Andrew Lunn wrote:
> Like other virtual interfaces, e.g. br0, we don't need a transmit
> queue. Packets should only be queued on real interfaces which are
> underneath. In practice this patch makes little difference since the
> virtual interfaces can accept packets as fast as they come, but the
> patch will avoid bufferbloat questions to the mailling lists in the
> future.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Linus Luesing <linus.luessing@web.de>

Applied in revision ga2f8a49.

Thanks,
Marek
