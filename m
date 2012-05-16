Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 16 May 2012 17:02:04 +0800
References: <1336840447-6580-1-git-send-email-sven@narfation.org>
	<1336840447-6580-10-git-send-email-sven@narfation.org>
In-Reply-To: <1336840447-6580-10-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205161702.04777.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 10/18] batman-adv: Prefix icmp_socket
	local static functions with batadv_
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

On Sunday, May 13, 2012 00:33:59 Sven Eckelmann wrote:
> All non-static symbols of batman-adv were prefixed with batadv_ to avoid
> collisions with other symbols of the kernel. Other symbols of batman-adv
> should use the same prefix to keep the naming scheme consistent.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  icmp_socket.c |   66
> +++++++++++++++++++++++++++++---------------------------- 1 file changed,
> 34 insertions(+), 32 deletions(-)

Applied in revision e4f3aef.

Thanks,
Marek
