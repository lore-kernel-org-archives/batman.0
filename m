Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 16 Jun 2011 12:16:09 +0200
References: <201106152056.18072.lindner_marek@yahoo.de>
	<1308177145-21191-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1308177145-21191-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201106161216.10561.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: the skb has not to be
	freed in recv_roam_adv()
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

On Thursday, June 16, 2011 12:32:24 AM Antonio Quartulli wrote:
> In recv_roam_adv(), in case of error the skb is freed and then
> NET_RX_DROP is returned. This makes the caller function wrongly invoke
> kfree_skb() again. To avoid this double free recv_tt_query() has to
> always return NET_RX_DROP and not to free the skb.

Applied in revision ad0432c.

Thanks,
Marek
