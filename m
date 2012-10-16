Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 17 Oct 2012 01:46:40 +0800
References: <1350246055-18000-1-git-send-email-sven@narfation.org>
In-Reply-To: <1350246055-18000-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210170146.40285.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 1/4] batctl: Translate client mac to
	originator mac for ping/traceroute
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

On Monday, October 15, 2012 04:20:52 Sven Eckelmann wrote:
> A user may want to check the path selected by batman-adv for any client
> when only the MAC of the device with the IPv4 is known, but not the
> originator address. batctl can assist the user by parsing the global
> translation table to automatically translate it for him.
> 
> The ping itself will only be done until the originator is reached and not
> until the actual client could be contacted because the client cannot
> understand batman-adv ping packets.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> rebased on DAT
> 
>  README       |    1 +
>  debug.h      |    1 +
>  functions.c  |   82
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> functions.h  |    1 +
>  man/batctl.8 |   10 ++++---
>  ping.c       |   11 +++++++-
>  traceroute.c |   11 +++++++-
>  7 files changed, 111 insertions(+), 6 deletions(-)

Applied in revision de4b7a2.

Thanks,
Marek
