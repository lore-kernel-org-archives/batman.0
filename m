Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 1 Oct 2012 16:47:21 +0800
References: <1348432717-20913-1-git-send-email-ordex@autistici.org>
 <1348432717-20913-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1348432717-20913-4-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210011647.22214.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 4/4] batman-adv: roaming handling
	mechanism redesign
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

On Monday, September 24, 2012 04:38:37 Antonio Quartulli wrote:
> This patch allows clients to roam multiple times within the same
> originator-interval.
> 
> To enable this new feature two key aspects that have been introduced:
> 1) packets are always directed to the node that was originally
> serving the roamed client which will then re-route the data
> to the correct destination at any point in time;
> 2) the client flags handling mechanism has been properly modified
> in order to allow multiple roamings withinin the same orig-int.
> Therefore flags are now set properly even in this scenario.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  translation-table.c | 160
> ++++++++++++++++++++++++++++++++++++++++------------ 1 file changed, 123
> insertions(+), 37 deletions(-)

Applied in revision 2443ba3.

Thanks,
Marek
