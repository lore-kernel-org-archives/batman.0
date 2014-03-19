Return-Path: <linus.luessing@web.de>
Date: Wed, 19 Mar 2014 10:03:16 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140319090316.GH5208@Linus-Debian>
References: <1395216532-31099-1-git-send-email-antonio@meshcoding.com>
 <1395216532-31099-3-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1395216532-31099-3-git-send-email-antonio@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 next 03/11] batman-adv: fix multicast
	kerneldoc
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi Antonio,

Two things are confusing me, firstly:

On Wed, Mar 19, 2014 at 09:08:44AM +0100, Antonio Quartulli wrote:
> The kerneldoc should always use the third person singular in
> the long function description.
> Moreover it should always try use up to 80 chars per line.

vs.

On Sun, May 12, 2013 at 12:55:25AM +0200, Antonio Quartulli wrote:
> For some reason we agreed on not using the third person while describing the
> function. For consistency I'd suggest you to do the same your kernel doc.
>

Secondly:

Why do you only change it in multicast.{c,h}, why not changing
things everywhere? For instance translation-table.c sometimes uses
"Returns", sometimes "Return".

Or functions in translation-table.c using first person in their
description:
* batadv_tt_prepare_tvlv_global_data()
* batadv_tt_prepare_tvlv_local_data()
* batadv_tt_global_add()
* batadv_tt_global_del_orig_entry()
* batadv_tt_global_del_orig_node()
* batadv_send_roam_adv()
* batadv_tt_local_resize_to_mtu()

While these using the third one:
* batadv_transtable_best_orig()
* batadv_tt_global_print_entry()
* batadv_tt_global_crc()
* batadv_tt_check_roam_count()


Cheers, Linus
