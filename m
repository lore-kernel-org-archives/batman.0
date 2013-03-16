Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 16 Mar 2013 19:08:43 +0800
References: <1363430978-24202-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1363430978-24202-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201303161908.43771.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add compat RCU code for
	kernel < 2.6.37
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

On Saturday, March 16, 2013 18:49:38 Antonio Quartulli wrote:
> @@ -236,6 +242,7 @@ static int __batadv_interface_set_mac_addr(x, y)
>         ASSERT_RTNL();\
>         dev->master;\
>  })
> +
>  #define hlist_entry_safe(ptr, type, member) \
>         (ptr) ? hlist_entry(ptr, type, member) : NULL

Why the extra line here ?

Cheers,
Marek
