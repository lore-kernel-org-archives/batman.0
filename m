Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 2 Sep 2012 16:30:20 +0800
References: <1345823647-27198-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1345823647-27198-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201209021630.20886.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: properly store the roaming
	time
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

On Friday, August 24, 2012 23:54:07 Antonio Quartulli wrote:
> in case of a new global entry added because of roaming, the roam_at field
> must be properly initiated with the current time. This value will be later
> use to purge this entry out on time out (if nobody claims it). Instead
> roam_at field is now set to zero in this situation leading to an immediate
> purging of the related entry.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  translation-table.c |    6 ++++++
>  1 file changed, 6 insertions(+)

Applied in revision 700ae88.

Thanks,
Marek
