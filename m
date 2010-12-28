Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 28 Dec 2010 15:09:39 +0100
References: <1292320696-11983-1-git-send-email-linus.luessing@ascom.ch>
	<1292320696-11983-7-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1292320696-11983-7-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201012281509.39786.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 06/10] batman-adv: Purge outdated ndp
	neighbours
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?utf-8?q?L=C3=BCssing?= <linus.luessing@ascom.ch>

On Tuesday 14 December 2010 10:58:12 Linus L=C3=BCssing wrote:
> +               list_for_each_entry_safe(neigh_node, neigh_node_tmp,
> +                                        &batman_if->neigh_list, list) {
> +                       if (time_before(jiffies,
> +                           neigh_node->last_valid + PURGE_TIMEOUT * HZ))
> +                               continue;

We should continue to use msecs_to_jiffies() for readability reasons.

Cheers,
Marek
