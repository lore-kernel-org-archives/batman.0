Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 8 Aug 2013 19:41:05 +0800
References: <1375892936-3602-1-git-send-email-ordex@autistici.org>
 <1375892936-3602-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1375892936-3602-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201308081941.05857.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: make the TT global
	purge routine VLAN specific
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Thursday, August 08, 2013 00:28:55 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> Instead of unconditionally remove all the TT entries
> served by a given originator, make tt_global_orig_del()
> remove only entries matching a given VLAN identifier
> provided as argument.
> 
> If such argument is negative then all the global entries
> served by the originator are removed.
> 
> This change is used into the BLA code to purge entries
> served by a newly discovered Backbone node, but limiting
> the operation only to those connected to the VLAN where the
> backbone has been discovered.
> 
> Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  bridge_loop_avoidance.c |  4 ++--
>  originator.c            |  2 +-
>  routing.c               |  2 +-
>  translation-table.c     | 17 ++++++++++++++++-
>  translation-table.h     |  2 +-
>  5 files changed, 21 insertions(+), 6 deletions(-)

Applied in revision 8944ede.

Thanks,
Marek
