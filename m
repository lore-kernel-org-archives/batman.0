Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 15 Dec 2012 16:20:16 +0800
References: <50BF0779.4080906@web.de>
In-Reply-To: <50BF0779.4080906@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201212151620.16913.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batctl: output errors to stderr
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

On Wednesday, December 05, 2012 16:36:09 Moritz Warning wrote:
> batctl outputs many errors to stdout instead of stderr.
> This patch corrects this behavior by redirecting errors
> and the usage texts to stderr.
> 
> Signed-off-by: Moritz Warning <moritzwarning@web.de>
> ---
> From: Moritz Warning <moritzwarning@web.de>
> Subject: [PATCH] batctl: output errors to stderr
> Context: http://www.open-mesh.org/issues/167
> 
> ---
>  bisect_iv.c  |   34 ++++++++++++-------------
>  debug.c      |   36 +++++++++++++-------------
>  debugfs.c    |    2 +-
>  functions.c  |   18 ++++++-------
>  ioctl.c      |   10 ++++----
>  main.c       |   62 ++++++++++++++++++++++-----------------------
>  ping.c       |   30 +++++++++++-----------
>  sys.c        |   80
> +++++++++++++++++++++++++++++-----------------------------
> tcpdump.c    |   34 ++++++++++++-------------
>  traceroute.c |   28 ++++++++++----------
>  translate.c  |    2 +-
>  vis.c        |    8 +++---
>  12 files changed, 172 insertions(+), 172 deletions(-)

Applied in revision 2b80a87.

Thanks,
Marek
