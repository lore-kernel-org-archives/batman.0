Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 2 Sep 2012 16:37:06 +0800
References: <1345935956-28111-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1345935956-28111-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201209021637.06838.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: print packets re-routing
	on DBG_TT and ratelimit it
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

On Sunday, August 26, 2012 07:05:56 Antonio Quartulli wrote:
> To simplify TranslationTable debugging it is better to print the packet
> rerouting message on the DBG_TT log level. In this way a developer
> interested in packets rerouting doesn't need to filter it out of the whole
> ROUTES log.
> 
> Moreover, since this message will appear for each rerouted message, it is
> now "ratelimited".
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> v3:
> - added net_ratelimited_function() macro to compat.h
> 
>  compat.h  | 10 ++++++++++
>  routing.c |  8 ++++----
>  2 files changed, 14 insertions(+), 4 deletions(-)

Applied in revision 3632c33.

Thanks,
Marek
