Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 16 Feb 2013 21:35:21 +0800
References: <1361019052-17476-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1361019052-17476-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201302162135.21344.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: make
	batadv_softif_destroy_netlink() static
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

On Saturday, February 16, 2013 20:50:52 Antonio Quartulli wrote:
> batadv_softif_destroy_netlink() is used in the file where it is defined
> only, therefore it must be static.
> 
> Introduced by 5317331775c3168b8155b03ec89b1c4c508b9043 ("batman-adv: Allow
> to use rntl_link for device creation/deletion")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  soft-interface.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied in revision 17d1d49.

Thanks,
Marek
