Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 11 May 2012 15:33:07 +0800
References: <1336629692-32288-1-git-send-email-lindner_marek@yahoo.de>
	<1336668574-16655-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1336668574-16655-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205111533.07711.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman_adv: fix namespace for
	neigh_node_new function
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Friday, May 11, 2012 00:49:34 Marek Lindner wrote:
> Should be merged with 0c9a249ef4dcaf733f6c7f64d4ce5c97b4705968
> 
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
> 
>  - v2: renamed batman_adv prefix to batadv.
> 
>  bat_iv_ogm.c |    2 +-
>  originator.c |    5 +++--
>  originator.h |    5 +++--
>  3 files changed, 7 insertions(+), 5 deletions(-)

Applied in revision 746e5dd.

Regards,
Marek
