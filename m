Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 22 Nov 2011 17:40:29 +0800
References: <1320680200-32024-1-git-send-email-ordex@autistici.org>
	<20111114164713.GB21063@ritirata.org>
In-Reply-To: <20111114164713.GB21063@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201111221740.29552.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add tt_initialised flag to
	the orig_node struct
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

On Tuesday, November 15, 2011 00:47:14 Antonio Quartulli wrote:
> On Mon, Nov 07, 2011 at 04:36:40PM +0100, Antonio Quartulli wrote:
> > (ttvn == 0) is currently used as initial condition. However this is not a
> > good idea because ttvn gets the vale zero each time after reaching the
> > maximum value (wrap around). For this reason a new flag is added in
> > order to define whether a node has an initialised table or not.
> > Moreover, after invoking
> > tt_global_del_orig(), tt_initialised has to be set to false
> > 
> > Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> 
> Reported-by: Alexey Fisher <bug-track@fisher-privat.net>
> Tested-by: Alexey Fisher <bug-track@fisher-privat.net>

Applied in revision 8ef201e.

Thanks,
Marek
