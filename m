Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 25 Aug 2012 00:08:45 +0200
References: <1345451209-8898-2-git-send-email-sven@narfation.org>
 <1345498646-21878-1-git-send-email-sven@narfation.org>
In-Reply-To: <1345498646-21878-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201208250008.45829.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/3] batman-adv: Check return value of
	try_module_get
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

On Monday, August 20, 2012 23:37:26 Sven Eckelmann wrote:
> New operations should not be started when they need an increased module
> reference counter and try_module_get failed.
> 
> This patch addresses Coverity #712284: Unchecked return value
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Removed the wrapper functions
> 
>  debugfs.c     |    6 ++++--
>  icmp_socket.c |   12 ++++++++----
>  main.c        |   10 ----------
>  main.h        |    2 --
>  4 files changed, 12 insertions(+), 18 deletions(-)

Applied in revision 2e66c5e.

Thanks,
Marek
