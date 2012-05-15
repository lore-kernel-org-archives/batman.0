Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 15 May 2012 16:14:15 +0800
References: <1336823339-4095-1-git-send-email-sven@narfation.org>
In-Reply-To: <1336823339-4095-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205151614.15822.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/8] batman-adv: Move hash_ipv4 to
	distributed-arp-table.c
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

On Saturday, May 12, 2012 19:48:52 Sven Eckelmann wrote:
> hash_ipv4 is only used in distributed-arp-table.c and therefore can be
> placed inside this file instead of the header.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  distributed-arp-table.c |   24 +++++++++++++++++++++++-
>  distributed-arp-table.h |   22 ----------------------
>  2 files changed, 23 insertions(+), 23 deletions(-)

Applied in revision 9fed716.

Thanks,
Marek
