Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 15 Dec 2012 19:02:18 +0800
References: <1355568584-17154-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1355568584-17154-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201212151902.18318.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: postpone OGM preparation
	to sending time
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

On Saturday, December 15, 2012 18:49:44 Antonio Quartulli wrote:
> +static void batadv_iv_ogm_send(struct work_struct *work)
> +{
> +       struct delayed_work *delayed_work;
> +       struct batadv_hard_iface_bat_iv *bat_iv;
> +       struct batadv_hard_iface *primary_if, *hard_iface;
> +       struct batadv_priv *bat_priv;
> +       unsigned char **ogm_buff;

How about this function ? It deserves some explanation too. After all, this is 
the only new function this patchsets adds.

Cheers,
Marek
