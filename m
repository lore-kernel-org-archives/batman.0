Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 3 Apr 2013 19:03:37 +0800
References: <1364215787-17935-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1364215787-17935-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304031903.38093.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: drop useless argument
	seqno in neighbor creation
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

On Monday, March 25, 2013 20:49:46 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> the sequence number is not stored in struct neigh_node,
> therefore there is no need to pass such value to the
> neigh_node creation procedure.
> 
> At the moment the value is only used by a debug message, but
> given the fact that the seqno is not related to the neighbor
> object, it is better to print it elsewhere.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
> 
> do we really want to pass the seqno over every function just to print it at
> the end? If this value is really important (debug? don't know) it should
> be printed in a proper place, e.g. in the function that triggered the
> creation and that possibly has the seqno for other purposes...
> Otherwise we would not be able to create a neigh_nod unless we have a seqno
> to pass.
> 
> Cheers,
> 
>  bat_iv_ogm.c | 11 ++++-------
>  originator.c |  5 ++---
>  originator.h |  2 +-
>  3 files changed, 7 insertions(+), 11 deletions(-)

Applied in revision 30b5722.

Thanks,
Marek
