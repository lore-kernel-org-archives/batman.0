Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 13 Apr 2012 22:33:43 +0200
References: <1334214449-3996-1-git-send-email-ordex@autistici.org>
	<1334214449-3996-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1334214449-3996-3-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201204132233.43625.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/3] batman-adv: use static const for
	STP constant address
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

On Thursday, April 12, 2012 09:07:28 Antonio Quartulli wrote:
> stp_addr is now declared as a simple "uint8_t []", but since it's content
> is statically defined, it has to be declared as "static const uint8_t []"
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  soft-interface.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied in revision 94ca561.

Thanks,
Marek
