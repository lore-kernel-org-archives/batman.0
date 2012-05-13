Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 14 May 2012 00:09:42 +0800
References: <1336781383-15649-1-git-send-email-sven@narfation.org>
In-Reply-To: <1336781383-15649-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205140009.43083.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 01/23] batman-adv: Fix namespace for
	hash_set_lock_class
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

On Saturday, May 12, 2012 08:09:21 Sven Eckelmann wrote:
> This function was introduced in 2c9aa3b4c37bd55148f5f25212c89e7bf5f28497
> without a proper namespace prefix.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bridge_loop_avoidance.c |    7 ++++---
>  hash.c                  |    3 ++-
>  hash.h                  |    3 ++-
>  3 files changed, 8 insertions(+), 5 deletions(-)

Applied in revision a51ca5f.

Thanks,
Marek
