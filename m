Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 18 Apr 2013 20:38:05 +0800
References: <1366136543-16916-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1366136543-16916-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304182038.05456.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: pass a 16bit long flag
	argument to tt_global_add()
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

On Wednesday, April 17, 2013 02:22:22 Antonio Quartulli wrote:
> @@ -786,7 +786,7 @@ out:
>  /* caller must hold orig_node refcount */
>  int batadv_tt_global_add(struct batadv_priv *bat_priv,
>                          struct batadv_orig_node *orig_node,
> -                        const unsigned char *tt_addr, uint8_t flags,
> +                        const unsigned char *tt_addr, uint16_t flags,
>                          uint8_t ttvn)
>  {
>         struct batadv_tt_global_entry *tt_global_entry;

If you resubmit the patch with the missing kernel doc I will merge it.  :)

Cheers,
Marek
