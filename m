Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 5 Sep 2010 00:57:13 +0200
References: <1283639100-6506-1-git-send-email-sven.eckelmann@gmx.de>
	<1283640270-30498-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1283640270-30498-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201009050057.13644.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Don't double free unicast
	skb on failure
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

On Sunday 05 September 2010 00:44:30 Sven Eckelmann wrote:
> The soft-interface transmission function expects that the unicast skb is
> still available when a send failed. This is not true on failed search
> for a router. Thus we would try to free the skb twice and create many
> different and hard to debug memory access failures due to access on not
> (anymore) allocated memory.

Applied in revision 1786.

Thanks,
Marek
