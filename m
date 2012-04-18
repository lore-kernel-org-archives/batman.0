Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 18 Apr 2012 17:27:40 +0800
References: <1334734840-816-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1334734840-816-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201204181727.40612.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use real error codes instead
	of meaningless -1
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

On Wednesday, April 18, 2012 15:40:40 Antonio Quartulli wrote:
> Reported-by: David Miller <davem@davemloft.net>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> This patch is for *next*. This patch fixes a problem pointed out by David
> S. Miller.
> 
> Actually the idea is to use real error codes instead of meaningless -1,
> even if this codes are only used internally to the batman-adv code. IMHO
> it is a good idea. Most of the times we convert -1 to real error codes
> later, but I think it is better to user real code directly. This patch
> will be squashed with a patch which is going to be sent in the next pull
> request.

Applied in revision a9f3b78.

Thanks,
Marek
