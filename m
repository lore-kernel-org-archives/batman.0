Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 25 Jun 2012 16:30:01 +0200
References: <1340447658-27405-1-git-send-email-siwu@hrz.tu-chemnitz.de>
	<1340447658-27405-2-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1340447658-27405-2-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201206251630.01504.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: rename bridge loop
	avoidance claim types
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

On Saturday, June 23, 2012 12:34:18 Simon Wunderlich wrote:
> for consistency reasons within the code and with the documentation,
> we should always call it "claim" and "unclaim".
> 
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
>  bridge_loop_avoidance.c |   18 +++++++++---------
>  packet.h                |    4 ++--
>  2 files changed, 11 insertions(+), 11 deletions(-)

Applied in revision f9bb019.

Thanks,
Marek
