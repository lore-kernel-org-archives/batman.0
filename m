Return-Path: <SRS0=0Aet=X5=goodmis.org=rostedt@kernel.org>
Date: Sun, 24 Jul 2022 19:12:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [for-next][PATCH 17/23] batman-adv: tracing: Use the new
 __vstring() helper
Message-ID: <20220724191250.2097b8eb@rorschach.local.home>
In-Reply-To: <8828005.nfsgNN4c79@sven-l14>
References: <20220714164256.403842845@goodmis.org>
	<20220714164331.060725040@goodmis.org>
	<8828005.nfsgNN4c79@sven-l14>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org

On Sun, 24 Jul 2022 23:31:01 +0200
Sven Eckelmann <sven@narfation.org> wrote:

> On Thursday, 14 July 2022 18:43:13 CEST Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > Instead of open coding a __dynamic_array() with a fixed length (which
> > defeats the purpose of the dynamic array in the first place).  
> 
> Please also make sure to remove the define of BATADV_MAX_MSG_LEN

I usually do not like to rebase my for-next and just add on a patch to
do something like this, but for this series I'll make an exception.

-- Steve
