Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 20 Apr 2013 02:54:07 +0800
References: <1366387621-12718-1-git-send-email-ordex@autistici.org>
 <1366387621-12718-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1366387621-12718-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304200254.08037.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/2] batman-adv: print the VID properly
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <ordex@autistici.org>

On Saturday, April 20, 2013 00:07:01 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> Since the MSB bits of any vid variable are now used for
> storing flags, print the vid properly by taking the flags
> away and printing -1 in case of VID representing no real
> VLAN.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  bridge_loop_avoidance.c | 36 ++++++++++++++++++++----------------
>  main.h                  |  2 ++
>  2 files changed, 22 insertions(+), 16 deletions(-)

Applied in revision 454b849 after making it checkpatch clean.

Cheers,
Marek
