Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 22 Aug 2012 02:03:50 +0200
References: <1343736871-7131-1-git-send-email-ordex@autistici.org>
 <1344638599-31985-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1344638599-31985-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201208220203.50737.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH v3] batman-adv: pass the WIFI flag from
	the local to global entry
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

On Saturday, August 11, 2012 00:43:19 Antonio Quartulli wrote:
> +static void __batadv_tt_local_remove(struct batadv_priv *bat_priv,
> +                                    struct batadv_tt_local_entry
> *tt_local, +                                    const char *message, bool
> roaming) +{
> +       uint16_t flags;
> +
> +       flags = BATADV_TT_CLIENT_DEL;
> +       if (roaming)
> +               flags |= BATADV_TT_CLIENT_ROAM;
> +
> +       batadv_tt_local_set_pending(bat_priv, tt_local, flags, message);
> +}

How about adding some kernel documentation ?  :)

Cheers,
Marek
