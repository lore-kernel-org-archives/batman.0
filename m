Return-Path: <davem@davemloft.net>
Date: Wed, 09 May 2012 20:41:11 -0400 (EDT)
Message-Id: <20120509.204111.1931607501484626500.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1336561976-16088-8-git-send-email-ordex@autistici.org>
References: <1336561976-16088-1-git-send-email-ordex@autistici.org>
	<1336561976-16088-8-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 07/14] batman-adv: split neigh_new
 function into generic and batman iv specific parts
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
To: ordex@autistici.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, lindner_marek@yahoo.de

From: Antonio Quartulli <ordex@autistici.org>
Date: Wed,  9 May 2012 13:12:49 +0200

> From: Marek Lindner <lindner_marek@yahoo.de>
> 
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> Acked-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>

The namespace pollution of the batman-adv code needs to improve,
and I'm putting my foot down starting with this change.

If you have a static function which is therefore private to a
source file, name it whatever you want.

But once it gets exported out of that file, you have to give it
an appropriate name.  Probably with a "batman_adv_" prefix or
similar.

Otherwise, for one thing, if this code is statically built into
the tree it can conflict with symbol names elsewhere and break
the build.
