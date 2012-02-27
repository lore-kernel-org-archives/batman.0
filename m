Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 27 Feb 2012 19:03:55 +0800
References: <1330267182-15607-1-git-send-email-ordex@autistici.org>
	<1330267182-15607-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1330267182-15607-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201202271903.56270.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: skip the window
	protection test when the originator has no neighbours
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

On Sunday, February 26, 2012 22:39:42 Antonio Quartulli wrote:
> When we receive an OGM from from a node for the first time, the
> last_real_seqno field of the orig_node structure has not been initialised
> yet. The value of this field is used to compute the current ogm-seqno
> window and therefore the protection mechanism will probably drop the
> packet due to an out-of-window error. To avoid this situation this patch
> adds a check to skip the window protection mechanism if no neighbour nodes
> have already been added. When the first neighbour node is added, the
> last_real_seqno field is initialised too.

Applied in revision a85b0bc.

Thanks,
Marek
