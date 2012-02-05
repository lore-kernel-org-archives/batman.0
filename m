Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 6 Feb 2012 01:58:54 +0800
References: <1327953557-26774-1-git-send-email-ordex@autistici.org>
	<1849513.Y59H6HZGp2@sven-laptop.home.narfation.org>
In-Reply-To: <1849513.Y59H6HZGp2@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201202060158.54427.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use ETH_ALEN instead of
	hardcoded numeric constants
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

On Saturday, February 04, 2012 23:33:30 Sven Eckelmann wrote:
> On Monday 30 January 2012 20:59:17 Antonio Quartulli wrote:
> > In packet.h the numeric constant 6 is used instead of the more portable
> > ETH_ALEN define. This patch substitute any hardcoded value with such
> > define.
> 
> Acked-by: Sven Eckelmann <sven@narfation.org>

Applied in revision 24a6289.

Thanks,
Marek
