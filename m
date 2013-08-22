Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 22 Aug 2013 15:52:36 +0800
References: <1377156073-556-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1377156073-556-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201308221552.36925.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: print the VID in the
	dat_cache output
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

On Thursday, August 22, 2013 15:21:11 Antonio Quartulli wrote:
> @@ -761,8 +761,8 @@ int batadv_dat_cache_seq_print_text(struct seq_file
> *seq, void *offset) goto out;
>  
>         seq_printf(seq, "Distributed ARP Table (%s):\n", net_dev->name);
> -       seq_printf(seq, "          %-7s          %-13s %5s\n", "IPv4",
> "MAC", -                  "last-seen");
> +       seq_printf(seq, "          %-7s          %-9s %4s %11s\n", "IPv4",
> +                  "MAC", "VID", "last-seen");

Why are you shortening the MAC address length while you try to add the vid ?

Cheers,
Marek
