Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 16 Jul 2012 11:51:56 +0200
References: <1341766146-21037-1-git-send-email-sven@narfation.org>
 <1342384011-9611-1-git-send-email-sven@narfation.org>
In-Reply-To: <1342384011-9611-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201207161151.56627.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Split batadv_priv in
	sub-structures for features
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

On Sunday, July 15, 2012 22:26:51 Sven Eckelmann wrote:
> The structure batadv_priv grows everytime a new feature is introduced. It
> gets hard to find the parts of the struct that belongs to a specific
> feature. This becomes even harder by the fact that not every feature uses
> a prefix in the member name.
> 
> The variables for bridge loop avoidence, gateway handling, translation
> table and visualization server are moved into separate structs that are
> included in the bat_priv main struct.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
> * Fix some comments that were wrong since a long time
> * Change some variables names for batadv_priv_tt
> 
>  bat_iv_ogm.c            |    4 +-
>  bridge_loop_avoidance.c |  115 +++++++++++++-------------
>  gateway_client.c        |   32 ++++----
>  hard-interface.c        |    5 +-
>  main.c                  |   24 +++---
>  routing.c               |    6 +-
>  soft-interface.c        |   17 ++--
>  translation-table.c     |  208
> ++++++++++++++++++++++++-----------------------
> types.h                 |  113 ++++++++++++++-----------
>  vis.c                   |  130 ++++++++++++++---------------
>  10 files changed, 343 insertions(+), 311 deletions(-)

Applied in revision fa49b57.

Thanks,
Marek
