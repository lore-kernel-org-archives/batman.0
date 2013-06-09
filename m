Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 9 Jun 2013 21:50:42 +0800
References: <1370340711-1399-1-git-send-email-ordex@autistici.org>
 <1370340711-1399-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1370340711-1399-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201306092150.42770.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 01/13] batman-adv: add the VLAN ID
	attribute to the TT entry
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <ordex@autistici.org>

On Tuesday, June 04, 2013 18:11:39 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> To make the translation table code VLAN-aware, each entry
> must carry the VLAN ID which it belongs to. This patch adds
> such attribute to the related TT structures.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  bridge_loop_avoidance.c |  35 +++----
>  distributed-arp-table.c |  11 ++-
>  gateway_client.c        |   3 +-
>  main.c                  |  30 +++++-
>  main.h                  |   9 +-
>  packet.h                |  14 ++-
>  routing.c               |  26 ++++--
>  send.c                  |   8 +-
>  send.h                  |  16 ++--
>  soft-interface.c        |  33 ++++---
>  translation-table.c     | 239
> +++++++++++++++++++++++++++++++++++++-----------
> translation-table.h     |  19 ++--
>  types.h                 |   2 +
>  13 files changed, 312 insertions(+), 133 deletions(-)

Applied in revision 580d791.

Thanks,
Marek
