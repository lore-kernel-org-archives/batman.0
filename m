Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 16 Jul 2012 12:19:28 +0200
References: <1341760395-16909-1-git-send-email-sven@narfation.org>
In-Reply-To: <1341760395-16909-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201207161219.28406.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Don't break statements after
	assignment operator
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

On Sunday, July 08, 2012 17:13:15 Sven Eckelmann wrote:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> This patch assumes that "Split batadv_priv in sub-structures for features"
> was accepted
> 
>  bat_iv_ogm.c            |   39 +++++++++++++++++++++------------------
>  bridge_loop_avoidance.c |    7 +++----
>  send.c                  |    8 ++++----
>  soft-interface.c        |    5 +++--
>  unicast.c               |   11 ++++++-----
>  vis.c                   |    4 ++--
>  6 files changed, 39 insertions(+), 35 deletions(-)

Applied in revision aae6678.

Thanks,
Marek
