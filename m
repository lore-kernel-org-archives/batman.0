Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 13 Apr 2012 22:32:50 +0200
References: <1334214449-3996-1-git-send-email-ordex@autistici.org>
	<1334214449-3996-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1334214449-3996-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201204132232.50346.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/3] batman-adv: fix comments ending
	style
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

On Thursday, April 12, 2012 09:07:27 Antonio Quartulli wrote:
> All multiline comments must end with "*/" on a newline.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> Reviewed-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
>  bridge_loop_avoidance.c |  102
> +++++++++++++++++++++++++----------------------
> packet.h                |    3 +-
>  routing.c               |    6 ++-
>  soft-interface.c        |    6 ++-
>  translation-table.c     |   16 +++++---
>  5 files changed, 74 insertions(+), 59 deletions(-)

Applied in revision 3784ac8.

Thanks,
Marek
