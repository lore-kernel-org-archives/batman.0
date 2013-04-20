Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 20 Apr 2013 17:42:53 +0800
References: <1366401149-31600-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1366401149-31600-6-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1366401149-31600-6-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304201742.53262.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 5/6] batman-adv: reorder batadv_iv_flags
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

On Saturday, April 20, 2013 03:52:28 Simon Wunderlich wrote:
> @@ -70,10 +70,9 @@ enum batadv_subtype {
>  #define BATADV_COMPAT_VERSION 14
>  
>  enum batadv_iv_flags {
> -       BATADV_NOT_BEST_NEXT_HOP   = BIT(3),
> -       BATADV_PRIMARIES_FIRST_HOP = BIT(4),
> -       BATADV_VIS_SERVER          = BIT(5),
> -       BATADV_DIRECTLINK          = BIT(6),
> +       BATADV_NOT_BEST_NEXT_HOP   = BIT(0),
> +       BATADV_PRIMARIES_FIRST_HOP = BIT(1),
> +       BATADV_DIRECTLINK          = BIT(2),
>  };

Can we get some kernel doc here as well ?

Cheers,
Marek
