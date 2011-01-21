Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 21 Jan 2011 16:09:20 +0100
References: <1295500975-3884-1-git-send-email-sven@narfation.org>
	<1295500975-3884-2-git-send-email-sven@narfation.org>
In-Reply-To: <1295500975-3884-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201101211609.21268.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Silence checkpatch
	warnings about spinlocks
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

On Thursday 20 January 2011 06:22:55 Sven Eckelmann wrote:
> @@ -353,7 +353,7 @@ static void _purge_orig(struct bat_priv *bat_priv)
>         struct hlist_node *walk, *safe;
>         struct hlist_head *head;
>         struct element_t *bucket;
> -       spinlock_t *list_lock;
> +       spinlock_t *list_lock; /* spinlock to protect write access */
>         struct orig_node *orig_node;
>         int i;

Applied in version 1911.

Thanks,
Marek
