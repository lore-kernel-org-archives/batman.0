Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 1 Jun 2012 14:37:06 +0800
References: <1337896854-13300-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1337896854-13300-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201206011437.06457.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: beautify tt_global_add()
	argument list
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

On Friday, May 25, 2012 06:00:54 Antonio Quartulli wrote:
> Instead of adding a new bool argument each time it is needed, it is better
> (and simpler) to pass an 8bit flag argument which contains all the needed
> flags
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> changes in v2:
> - rebased on top of the last patches for code restyling
> 
>  routing.c           |    4 ++--
>  translation-table.c |   24 +++++++++---------------
>  translation-table.h |    4 ++--
>  3 files changed, 13 insertions(+), 19 deletions(-)

Applied in revision 5b2b9b2.

Thanks,
Marek
