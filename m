Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 13 Feb 2011 22:11:05 +0100
References: <201102031802.52134.lindner_marek@yahoo.de>
	<1296832896-30081-8-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1296832896-30081-8-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201102132211.05700.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 7/7] batman-adv: Increase orig_node
	refcount before releasing rcu read lock
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

On Friday 04 February 2011 16:21:36 Linus L=C3=BCssing wrote:
> When unicast_send_skb() is increasing the orig_node's refcount another
> thread might have been freeing this orig_node already. We need to
> increase the refcount in the rcu read lock protected area to avoid that.

Applied in revision 1943.

Thanks,
Marek
