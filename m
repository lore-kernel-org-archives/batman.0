Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 11 Sep 2013 19:33:35 +0800
Message-ID: <2988608.6K7gzWSjDC@diderot>
In-Reply-To: <1378847522-13776-6-git-send-email-sven@narfation.org>
References: <1378847522-13776-1-git-send-email-sven@narfation.org>
 <1378847522-13776-6-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCH 05/11] batctl: Add include guards to
	avoid redundant declarations or include loops
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

On Tuesday, September 10, 2013 11:11:56 PM Sven Eckelmann wrote:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  allocate.h   | 4 ++--
>  bat-hosts.h  | 4 ++--
>  bisect_iv.h  | 5 +++++
>  debug.h      | 4 ++++
>  functions.h  | 5 ++++-
>  ioctl.h      | 4 ++++
>  main.h       | 5 +++++
>  ping.h       | 5 ++++-
>  sys.h        | 4 ++++
>  tcpdump.h    | 4 ++++
>  traceroute.h | 5 ++++-
>  translate.h  | 5 ++++-
>  12 files changed, 46 insertions(+), 8 deletions(-)

Applied in revision 2e15205.

Thanks,
Marek

