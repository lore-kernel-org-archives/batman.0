Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 9 Jun 2013 12:30:44 +0800
References: <1369307262-21901-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1369307262-21901-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201306091230.44280.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: forward late OGMs from
	best next hop
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
Cc: Simon Wunderlich <simon@open-mesh.com>

On Thursday, May 23, 2013 19:07:42 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> When a packet is received from another node first and later from the
> best next hop, this packet is dropped. However the first OGM was sent
> with the BATADV_NOT_BEST_NEXT_HOP flag and thus dropped by neighbors.
> The late OGM from the best neighbor is then dropped because it is a
> duplicate.
> 
> If this situation happens constantly, a node might end up not forwarding
> the "valid" OGMs anymore, and nodes behind will starve from not getting
> valid OGMs.
> 
> Fix this by refining the duplicate checking behaviour: The actions
> should depend on whether it was a duplicate for a neighbor only or for
> the originator. OGMs which are not duplicates for a specific neighbor
> will now be considered in batadv_iv_ogm_forward(), but only actually
> forwarded for the best next hop. Therefore, late OGMs from the best
> next hop are forwarded now and not dropped as duplicates anymore.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> 
> ---
> Changes to PATCHv1:
>  * use enum to distinguish different duplicate states
>  * fix typo "is_simlar -> is_similar"
>  * remove antonios sign off (the patch changed, feel free to add it if
>    he is ok with it, it was his idea originally ...)
> ---
>  bat_iv_ogm.c |   86
> +++++++++++++++++++++++++++++++++++++--------------------- 1 file changed,
> 55 insertions(+), 31 deletions(-)

Applied in revision 3d999e5.

Thanks,
Marek
