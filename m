Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 22 Aug 2012 01:36:10 +0200
References: <1343602203-11584-1-git-send-email-ordex@autistici.org>
 <1343747955-5657-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1343747955-5657-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201208220136.10267.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: use check_unicast_packet()
	in recv_roam_adv()
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

On Tuesday, July 31, 2012 17:19:15 Antonio Quartulli wrote:
> To avoid code duplication and to simplify further changes,
> check_unicast_packet() is now used in recv_roam_adv() to check for not
> well formed packets and so discard them.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> v2
> - coment rearrangement
> v3
> - fixed sizeof argument (use the variable name instead of the type, if
> possible)
> 
>  routing.c |   15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)

Applied in revision 2ce4b9b.

Thanks,
Marek
