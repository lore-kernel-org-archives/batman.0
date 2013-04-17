Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 18 Apr 2013 03:56:15 +0800
References: <1366227943-25134-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1366227943-25134-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304180356.15905.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: fix global protection
	fault during soft_iface destruction
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

On Thursday, April 18, 2013 03:45:43 Antonio Quartulli wrote:
> batadv_mesh_free() schedules some RCU callbacks which need the bat_priv
> struct to do their jobs, while free_netdev(), which is called immediately
> after, is destroying the private data.
> 
> Put an rcu_barrier() in the middle so that free_netdev() is invoked only
> after all the callbacks returned.
> 
> This bug has been introduced by ab8f433dd39be94e8617cff2dfe9f7eca162eb15
> ("batman-adv: Move deinitialization of soft-interface to destructor")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> 
>  soft-interface.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied in revision 73eb82e.

Thanks,
Marek
