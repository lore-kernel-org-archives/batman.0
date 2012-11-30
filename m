Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 30 Nov 2012 17:39:22 +0800
References: <1353886730-32477-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1353886730-32477-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211301739.22456.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: use ETH_P_BATMAN
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

On Monday, November 26, 2012 07:38:50 Antonio Quartulli wrote:
> The ETH_P_BATMAN ethertype is now defined kernel-wide. Use it instead
> of the private BATADV_ETH_P_BATMAN define.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  compat.h         | 2 ++
>  hard-interface.c | 3 ++-
>  packet.h         | 2 --
>  send.c           | 6 ++++--
>  soft-interface.c | 9 +++++----
>  5 files changed, 13 insertions(+), 9 deletions(-)

Applied in revision 87907ac.

Thanks,
Marek
