Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 3 Sep 2013 16:50:08 +0800
References: <1378116909-551-1-git-send-email-ordex@autistici.org>
 <1378116909-551-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1378116909-551-3-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201309031650.08884.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv7 2/9] batman-adv: make struct
	batadv_orig_node algorithm agnostic
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <ordex@autistici.org>

On Monday, September 02, 2013 18:15:02 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> some of the struct batadv_orig_node members are B.A.T.M.A.N. IV
> specific and therefore they are moved in a algorithm specific
> substruct in order to make batadv_orig_node routing algorithm
> agnostic
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  bat_iv_ogm.c | 108
> ++++++++++++++++++++++++++++++++++++++++++++--------------- originator.c
> |  89 ++++++++++++++++++------------------------------ originator.h |   3
> +-
>  types.h      |  30 +++++++++++------
>  4 files changed, 135 insertions(+), 95 deletions(-)

Applied in revision 9e696f7.

Thanks,
Marek
