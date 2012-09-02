Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 2 Sep 2012 16:42:01 +0800
References: <1346016359-27041-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1346016359-27041-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201209021642.01329.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: check for more space before
	accessing the skb
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

On Monday, August 27, 2012 05:25:59 Antonio Quartulli wrote:
> In batadv_check_unicast_ttvn() the code accesses both the unicast header
> and the Ethernet header in the payload. For this reason pskb_may_pull()
> must be invoked to check for the required space.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  routing.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied in revision 94494a1.

Thanks,
Marek
