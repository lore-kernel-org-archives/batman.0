Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 24 Sep 2013 20:06:39 +0800
Message-ID: <2146762.XrrjbkmJNL@diderot>
In-Reply-To: <1379860946-32669-1-git-send-email-sven@narfation.org>
References: <1379860946-32669-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/4] batctl: Add missing includes and
	remove unused includes
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
Cc: Sven Eckelmann <sven@narfation.org>

On Sunday 22 September 2013 16:42:23 Sven Eckelmann wrote:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bat-hosts.c   |  5 +++--
>  bat-hosts.h   |  2 +-
>  bisect_iv.c   |  7 ++++---
>  debug.c       |  5 -----
>  debug.h       |  3 +++
>  debugfs.c     | 10 ++++------
>  debugfs.h     |  3 ---
>  functions.c   |  2 ++
>  functions.h   |  3 ++-
>  ioctl.c       |  3 +--
>  list-batman.h |  3 ---
>  main.c        |  3 ---
>  ping.c        |  5 +++++
>  sys.c         |  1 -
>  sys.h         |  2 ++
>  tcpdump.c     |  6 +++++-
>  tcpdump.h     |  5 ++++-
>  traceroute.c  |  4 ++++
>  translate.c   |  1 -
>  19 files changed, 40 insertions(+), 33 deletions(-)

Applied in revision 62eaa83.

Thanks,
Marek

