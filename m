Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 30 Jun 2012 14:21:37 +0200
References: <1340828898-12352-1-git-send-email-sven@narfation.org>
	<1340877413-18434-1-git-send-email-sven@narfation.org>
In-Reply-To: <1340877413-18434-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201206301421.37747.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/1] batman-adv: Don't leak information
	through uninitialized packet fields
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

On Thursday, June 28, 2012 11:56:52 Sven Eckelmann wrote:
> The reserved fields in batman-adv packets are not set to a constant value.
> The content of these memory regions is leaked unintentionally to the
> network.
> 
> This regression was introduced in c7fb529996cbc47bc8243d6860dac716ae70af82
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Based on next and fixed commit title
> 
>  soft-interface.c    |    1 +
>  translation-table.c |    1 +
>  vis.c               |    2 ++
>  3 files changed, 4 insertions(+)

Applied in revision 4aae804.

Thanks,
Marek
