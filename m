Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 24 Jan 2013 21:55:28 +0800
References: <1358763746-16742-1-git-send-email-martin@hundeboll.net>
 <1358763746-16742-7-git-send-email-martin@hundeboll.net>
In-Reply-To: <1358763746-16742-7-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201301242155.28511.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 6/6] batman-adv: Receive coded packets
	and decode them.
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

On Monday, January 21, 2013 18:22:26 Martin Hundeb=C3=B8ll wrote:
> --- a/types.h
> +++ b/types.h
> @@ -308,6 +308,10 @@ enum batadv_counters {
>         BATADV_CNT_NC_RECODE,
>         BATADV_CNT_NC_RECODE_BYTES,
>         BATADV_CNT_NC_BUFFER,
> +       BATADV_CNT_NC_DECODE,
> +       BATADV_CNT_NC_DECODE_BYTES,
> +       BATADV_CNT_NC_DECODE_FAILED,
> +       BATADV_CNT_NC_SNIFFED,
>  #endif
>         BATADV_CNT_NUM,
>  };

Kernel doc ?


Cheers,
Marek
