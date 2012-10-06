Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 7 Oct 2012 03:22:06 +0800
References: <1349550683-22892-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1349550683-22892-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210070322.09980.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batctl: add support for the DAT
	local table
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

On Sunday, October 07, 2012 03:11:21 Antonio Quartulli wrote:
> --- a/debug.c
> +++ b/debug.c
> @@ -64,6 +64,11 @@ const struct debug_table_data
> batctl_debug_tables[BATCTL_TABLE_NUM] = { .opt_short = "bbt",
>                 .debugfs_name = "bla_backbone_table",
>         },
> +       {
> +               .opt_long = "datcache",
> +               .opt_short = "dc",
> +               .debugfs_name = "dat_cache",
> +       },
>  };

How about adding this entry to the "can be compiled out" parameter list ? 
Check "fs_compile_out_param" list in functions.c. Same applies to patch3.

Cheers,
Marek
