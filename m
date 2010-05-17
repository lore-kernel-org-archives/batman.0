Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 17 May 2010 21:58:00 +0800
References: <1274014932-2792-1-git-send-email-sven.eckelmann@gmx.de>
	<1274090330-22874-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1274090330-22874-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201005172158.01056.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: remove all rcu head
	initializations
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

On Monday 17 May 2010 17:58:50 Sven Eckelmann wrote:
> From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> Remove all rcu head inits. We don't care about the RCU head state before
> passing it to call_rcu() anyway. Only leave the "on_stack" variants so
> debugobjects can keep track of objects on stack.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> Cc: Marek Lindner <lindner_marek@yahoo.de>
> Cc: Sven Eckelmann <sven.eckelmann@gmx.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>

Ok, applied in revision 1659.

Thanks,
Marek
