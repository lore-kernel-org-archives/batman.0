Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 3 Sep 2013 16:51:07 +0800
References: <1378116909-551-1-git-send-email-ordex@autistici.org>
 <1378116909-551-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1378116909-551-4-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201309031651.07851.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv7 3/9] batman-adv: add bat_orig_print API
	function
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

On Monday, September 02, 2013 18:15:03 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> Each routing protocol has its own metric and private
> variables, therefore it is useful to introduce a new API
> for originator information printing.
> 
> This API needs to be implemented by each protocol in order
> to provide its specific originator table output.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  bat_iv_ogm.c | 65
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ originator.c |
> 66 +++++++++---------------------------------------------------
> types.h      |  3 +++
>  3 files changed, 78 insertions(+), 56 deletions(-)

Applied in revision e675e2e.

Thanks,
Marek
