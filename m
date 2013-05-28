Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 28 May 2013 15:19:57 +0800
References: <1369333096-15869-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1369333096-15869-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305281519.57686.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: consider network coding
	overhead when calculating required mtu
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

On Friday, May 24, 2013 02:18:16 Marek Lindner wrote:
> The module prints a warning when the MTU on the hard interface is too
> small to transfer payload traffic without fragmentation. The required
> MTU is calculated based on the encapsulation header size. If network
> coding is compild into the module its header size is taken into
> account as well.
> 
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  hard-interface.c |   19 ++++++++++---------
>  main.c           |   25 +++++++++++++++++++++++++
>  main.h           |    1 +
>  soft-interface.c |    2 +-
>  types.h          |    7 -------
>  5 files changed, 37 insertions(+), 17 deletions(-)

Applied in revision f1f310d.

Regards,
Marek
