Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 22 Jun 2012 20:50:38 +0200
References: <1340035834-29105-1-git-send-email-ordex@autistici.org>
	<1340194376-11220-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1340194376-11220-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201206222050.38442.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: fix race condition in TT
	full-table replacement
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

On Wednesday, June 20, 2012 14:12:56 Antonio Quartulli wrote:
> bug introduced with cea194d90b11aff7fc289149e4c7f305fad3535a
> 
> In the current TT code, when a TT_Response containing a full table is
> received form an originator, the node first purges all the clients for
> that originator in the global translation-table and then merges the new
> received table. During the purging phase each client deletion is done by
> means of a call_rcu() invocation and at the end of this phase the global
> entry counter for that originator is set to 0. However the invoked rcu
> function decreases by one the global entry counter for that originator too
> and since the rcu invocation is likely to be postponed, the node will end
> up in first setting the counter to 0 and then decreasing it one by one for
> each deleted client.
> 
> This bug leads to having a wrong global entry counter for the related node,
> say X. Then when the node with the broken counter will answer to a
> TT_REQUEST on behalf of node X, it will create faulty TT_RESPONSE that
> will generate an unrecoverable situation on the node that asked for the
> full table recover.
> 
> The non-recoverability is given by the fact that the node with the broken
> counter will keep answering on behalf of X because its knowledge about X's
> state (ttvn + tt_crc) is correct.
> 
> To solve this problem the counter is not explicitly set to 0 anymore and
> the counter decrement is performed right before the invocation of
> call_rcu().
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> v2:
> - patch rebased on top of maint
> - commit message extended
> 
>  translation-table.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied in revision d1f13e2.

Thanks,
Marek
