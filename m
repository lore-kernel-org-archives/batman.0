Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 29 Nov 2012 11:18:30 +0800
References: <1354150462-4253-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1354150462-4253-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211291118.30461.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: don't print the last_seen
	time for bat0 TT local entry
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

On Thursday, November 29, 2012 08:54:22 Antonio Quartulli wrote:
> @@ -504,19 +505,22 @@ int batadv_tt_local_seq_print_text(struct seq_file
> *seq, void *offset) last_seen_secs = last_seen_msecs / 1000;
>                         last_seen_msecs = last_seen_msecs % 1000;
>  
> +                       no_purge = tt_common_entry->flags &
> +                                  BATADV_TT_CLIENT_NOPURGE;


Do you think David will accept this ?

Cheers,
Marek
