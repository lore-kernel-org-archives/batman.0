Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 28 May 2013 15:25:49 +0800
References: <1369683792-531-1-git-send-email-ordex@autistici.org>
 <1369683792-531-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1369683792-531-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305281525.49326.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 01/12] batman-adv: implement
	batadv_tt_entries
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

On Tuesday, May 28, 2013 03:43:01 Antonio Quartulli wrote:
> +/**
> + * batadv_tt_entries - compute the number of entries fitting in tt_len
> bytes + * @tt_len: available space
> + *
> + * Return the number of entries.
> + */
> +static uint16_t batadv_tt_entries(uint16_t tt_len)
> +{
> +       return tt_len / sizeof(struct batadv_tvlv_tt_change);
> +}

For the sake of consistency, wouldn't it be better to call batadv_tt_len(1) 
instead of sizeof(struct batadv_tvlv_tt_change) ?

Cheers,
Marek
