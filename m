Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 17 Apr 2013 00:41:44 +0800
References: <1366129056-29381-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1366129056-29381-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304170041.45081.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: fix batadv_is_my_mac()
	usage
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

On Wednesday, April 17, 2013 00:17:36 Antonio Quartulli wrote:
> batadv_is_my_mac() has been changed in net and now code in
> net-next using it must be adapted.
> Some kernel doc has been added as well.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  main.c           |  6 ++++++
>  network-coding.c | 18 ++++++++++--------
>  routing.c        |  1 +
>  3 files changed, 17 insertions(+), 8 deletions(-)

Applied in revision 8746974.

Thanks,
Marek
