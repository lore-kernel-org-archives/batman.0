Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 8 Aug 2013 19:43:31 +0800
References: <1375892936-3602-1-git-send-email-ordex@autistici.org>
 <1375892936-3602-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1375892936-3602-3-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201308081943.31872.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: make the backbone gw
	check VLAN specific
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Antonio Quartulli <ordex@autistici.org>, Antonio Quartulli <antonio@open-mesh.com>

On Thursday, August 08, 2013 00:28:56 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> The backbone gw check has to be VLAN specific so that code
> using it can specify VID where the check has to be done.
> 
> In the TT code, the check has been moved into the
> tt_global_add() function so that it can be performed on a
> per-entry basis instead of ignoring all the TT data received
> from another backbone node. Only TT global entries belonging
> to the VLAN where the backbone node is connected to are
> skipped.
> All the other spots where the TT code was checking whether a
> node is a backbone have been removed.
> 
> Moreover, batadv_bla_is_backbone_gw_orig() now returns bool
> since it used to return only 1 or 0.
> 
> Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  bridge_loop_avoidance.c | 19 +++++++++++--------
>  bridge_loop_avoidance.h | 10 ++++++----
>  translation-table.c     | 41 ++++++++++-------------------------------
>  3 files changed, 27 insertions(+), 43 deletions(-)

Applied in revision 5af869e.

Thanks,
Marek
