Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 21 Nov 2012 14:37:00 +0800
References: <1353440655-10461-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1353440655-10461-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211211437.00804.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH next] Revert "batman-adv: export
	compatibility version via debugfs"
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

On Wednesday, November 21, 2012 03:44:15 Antonio Quartulli wrote:
> This reverts commit 0679ec75758588e185ceec11e5823de65b427a6f.
> 
> Conflicts:
>         main.c
>         main.h
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  debugfs.c | 12 ------------
>  main.c    | 12 ------------
>  main.h    |  1 -
>  3 files changed, 25 deletions(-)

Applied in revision eba8ed0.

Thanks,
Marek
